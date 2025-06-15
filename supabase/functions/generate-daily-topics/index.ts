import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const PERPLEXITY_API_KEY = Deno.env.get('PERPLEXITY_API_KEY')!
const PERPLEXITY_API_URL = 'https://api.perplexity.ai/chat/completions'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

interface TopicSelectionRequest {
  country_code: string
  region?: string
  categories?: string[]
}

interface NewsTopicItem {
  title: string
  category: string
  keywords: string[]
}

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '',
      {
        auth: {
          autoRefreshToken: false,
          persistSession: false
        }
      }
    )

    const { country_code = 'KR', region = 'Seoul', categories = ["정치", "경제", "사회", "과학", "문화"] } = await req.json() as TopicSelectionRequest

    // 오늘 날짜
    const today = new Date()
    const todayStr = today.toISOString().split('T')[0]
    
    // 어제 날짜
    const yesterday = new Date(today)
    yesterday.setDate(yesterday.getDate() - 1)
    const yesterdayStr = yesterday.toISOString().split('T')[0]

    // 이미 오늘의 브리핑이 있는지 확인
    const { data: existingBriefing } = await supabaseAdmin
      .from('daily_briefings')
      .select('id')
      .eq('country_code', country_code)
      .eq('region', region)
      .eq('briefing_date', todayStr)
      .single()

    if (existingBriefing) {
      return new Response(
        JSON.stringify({ message: 'Daily briefing already exists', briefing_id: existingBriefing.id }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 200 }
      )
    }

    // 신뢰할 수 있는 뉴스 소스
    const trustedDomains = [
      "reuters.com", "bloomberg.com", "nytimes.com", "wsj.com", "ft.com",
      "bbc.com", "cnn.com", "theguardian.com", "apnews.com", "npr.org",
      // 한국 뉴스
      "chosun.com", "donga.com", "hankyung.com", "mk.co.kr", "yna.co.kr",
      "hani.co.kr", "khan.co.kr", "sbs.co.kr", "kbs.co.kr", "ytn.co.kr"
    ]

    // Perplexity API 호출하여 주제 선정
    const prompt = `You are a news curator for ${country_code} ${region}. Select today's 10 most important news topics.

Categories to cover: ${categories.join(', ')}

Requirements:
1. Mix of local, national, and international news relevant to the region
2. Balanced coverage across categories
3. Focus on impactful, developing stories
4. Include both breaking news and important ongoing stories
5. IMPORTANT: All content (titles, keywords) must be in Korean language

Return ONLY a valid JSON array with exactly 10 items in this format:
[
  {
    "title": "뉴스의 간략한 제목 (한국어로)",
    "category": "제공된 카테고리 중 하나",
    "keywords": ["키워드1", "키워드2", "키워드3"]
  }
]`

    const response = await fetch(PERPLEXITY_API_URL, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${PERPLEXITY_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: 'sonar-pro',
        messages: [
          {
            role: 'system',
            content: 'You are a professional news curator for Korean audiences. Always return valid JSON only, no additional text. All content must be in Korean language.'
          },
          {
            role: 'user',
            content: prompt
          }
        ],
        search_options: {
          search_after_date_filter: yesterdayStr,
          search_before_date_filter: todayStr,
          user_location: `${country_code}, ${region}`,
          context_length: 'high',
          domains: trustedDomains,
          exclude_domains: ['twitter.com', 'facebook.com', 'reddit.com', 'instagram.com']
        },
        temperature: 0.1,
        max_tokens: 2000
      })
    })

    if (!response.ok) {
      throw new Error(`Perplexity API error: ${response.status}`)
    }

    const perplexityData = await response.json()
    
    // Extract topics from the response
    let topics: NewsTopicItem[]
    try {
      const content = perplexityData.choices[0].message.content
      // Try to extract JSON from the content
      const jsonMatch = content.match(/\[[\s\S]*\]/)
      if (jsonMatch) {
        topics = JSON.parse(jsonMatch[0])
      } else {
        throw new Error('No valid JSON found in response')
      }
    } catch (parseError) {
      console.error('Failed to parse topics:', parseError)
      throw new Error('Failed to parse topic selection response')
    }

    // Validate topics
    if (!Array.isArray(topics) || topics.length !== 10) {
      throw new Error('Invalid topic selection: expected 10 topics')
    }

    // Save to database
    const { data: briefing, error: briefingError } = await supabaseAdmin
      .from('daily_briefings')
      .insert({
        country_code,
        region,
        briefing_date: todayStr,
        topics: topics
      })
      .select()
      .single()

    if (briefingError) {
      throw briefingError
    }

    return new Response(
      JSON.stringify({ 
        success: true, 
        briefing_id: briefing.id,
        topics: topics
      }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 200 }
    )
  } catch (error) {
    console.error('Error generating daily topics:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 500 }
    )
  }
})