import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const PERPLEXITY_API_KEY = Deno.env.get('PERPLEXITY_API_KEY')!
const PERPLEXITY_API_URL = 'https://api.perplexity.ai/chat/completions'
const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!
const SUPABASE_ANON_KEY = Deno.env.get('SUPABASE_ANON_KEY')!

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

async function callPerplexity(prompt: string, model: string = 'sonar-pro', searchOptions: any = {}) {
  const response = await fetch(PERPLEXITY_API_URL, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${PERPLEXITY_API_KEY}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      model,
      messages: [
        {
          role: 'system',
          content: 'You are a professional Korean news analyst. Always provide responses in Korean language unless specifically asked for English (like URLs).'
        },
        {
          role: 'user',
          content: prompt
        }
      ],
      search_options: {
        search_recency_filter: 'day',
        context_length: 'high',
        ...searchOptions
      },
      temperature: 0.1,
      max_tokens: 3000
    })
  })

  if (!response.ok) {
    throw new Error(`Perplexity API error: ${response.status}`)
  }

  const data = await response.json()
  return data.choices[0].message.content
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

    // Get the oldest pending task
    const { data: task, error: taskError } = await supabaseAdmin
      .from('news_research_queue')
      .select('*')
      .eq('status', 'pending')
      .order('created_at', { ascending: true })
      .limit(1)
      .single()

    if (taskError || !task) {
      return new Response(
        JSON.stringify({ message: 'No pending tasks' }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 200 }
      )
    }

    // Mark task as processing
    await supabaseAdmin
      .from('news_research_queue')
      .update({ 
        status: 'processing',
        attempts: task.attempts + 1
      })
      .eq('id', task.id)

    try {
      // Process the research using the existing logic
      const topic = task.topic
      
      // 1. 메인 리서치 (Sonar Pro)
      const mainResearchPrompt = `한국 뉴스 분석: "${topic.title}"

다음을 한국어로 작성하세요:
1. 핵심 요약 (불릿포인트 3-5개, 각각 핵심 사실 하나씩)
2. 상세 내용 (문단별로 구분하여 작성):
   - 사건의 경과와 현재 상황
   - 주요 관련자와 그들의 입장
   - 이 뉴스가 중요한 이유
   - 향후 전망과 예상되는 영향
3. 독자가 알아야 할 핵심 용어 (명확한 정의 포함)
4. 검증된 출처 (한국 및 국제 언론사)

JSON 형식:
{
  "title": "명확하고 간결한 제목",
  "summary": "• 첫 번째 핵심 사실\\n• 두 번째 핵심 사실\\n• 세 번째 핵심 사실",
  "main_content": "첫 번째 문단 (사건 개요)\\n\\n두 번째 문단 (상세 내용)\\n\\n세 번째 문단 (영향과 전망)",
  "key_terms": [
    {"term": "핵심용어1", "definition": "일반인도 이해할 수 있는 명확한 설명"},
    {"term": "핵심용어2", "definition": "일반인도 이해할 수 있는 명확한 설명"}
  ],
  "sources": [
    {"title": "기사 제목", "url": "https://..."},
    {"title": "기사 제목", "url": "https://..."}
  ]
}`

      const mainResearchResponse = await callPerplexity(mainResearchPrompt)
      
      let mainResearch: any
      try {
        const jsonMatch = mainResearchResponse.match(/\{[\s\S]*\}/)
        if (jsonMatch) {
          mainResearch = JSON.parse(jsonMatch[0])
        } else {
          throw new Error('No valid JSON found in main research response')
        }
      } catch (parseError) {
        console.error('Failed to parse main research:', parseError)
        throw new Error('Failed to parse main research response')
      }

      // 2. 배경 지식 (Sonar 일반)
      const backgroundPrompt = `"${topic.title}" 뉴스의 배경 지식을 한국어로 작성하세요.

다음 항목별로 구분하여 작성:
역사적 맥락: 이 사건의 역사적 배경과 관련 사건들
정치적 배경: 관련 정책이나 정치 상황 (해당하는 경우)
경제적 배경: 경제적 요인이나 시장 상황 (해당하는 경우)
사회적 맥락: 사회 변화나 여론 동향 (해당하는 경우)

각 항목을 "제목: 내용" 형식으로 명확히 구분하세요.`

      const backgroundContext = await callPerplexity(backgroundPrompt, 'sonar')

      // 3. 팩트 체크 (Sonar 일반)
      const factCheckPrompt = `"${topic.title}" 뉴스의 주요 주장들을 팩트체크하세요.

분석할 내용:
1. 뉴스에서 제시된 주요 주장들
2. 각 주장의 사실 여부 검증
3. 근거 자료와 출처
4. 전반적인 신뢰도 평가

한국어로 상세히 작성하고, JSON 형식으로 반환:
{
  "status": "사실/대체로 사실/논란의 여지/거짓/미확인",
  "details": "주장: [구체적 주장]\\n검증: [사실 여부와 근거]\\n\\n주장: [다른 주장]\\n검증: [사실 여부와 근거]"
}`

      const factCheckResponse = await callPerplexity(factCheckPrompt, 'sonar', {
        domains: ['snopes.com', 'factcheck.org', 'politifact.com', 'kbs.co.kr/news/factcheck', 'snu.ac.kr/factcheck']
      })

      let factCheck
      try {
        const jsonMatch = factCheckResponse.match(/\{[\s\S]*\}/)
        if (jsonMatch) {
          factCheck = JSON.parse(jsonMatch[0])
        } else {
          factCheck = { status: 'unverified', details: '사실 확인을 할 수 없습니다' }
        }
      } catch {
        factCheck = { status: 'unverified', details: 'Unable to verify claims' }
      }

      // 4. 다각적 관점 (Sonar Pro) - 실제 전문가 의견 수집
      const perspectivesPrompt = `"${topic.title}" 뉴스에 대한 실제 전문가들의 발언과 의견을 찾아주세요.

다음을 찾아서 정리:
1. 이 뉴스에 대해 실제로 발언한 전문가들 (이름과 소속 포함)
2. 그들의 구체적인 의견이나 분석
3. 가능한 다양한 관점의 전문가 포함 (정부, 학계, 시민단체, 업계 등)

실제 전문가와 그들의 발언만 포함하세요. 가상의 의견은 만들지 마세요.

JSON 배열 형식:
[
  {"expert": "홍길동 (서울대 경제학과 교수)", "viewpoint": "이 정책은... [실제 발언 인용]"},
  {"expert": "김철수 (한국경제연구원 연구위원)", "viewpoint": "시장 측면에서... [실제 발언 인용]"},
  {"expert": "이영희 (시민단체 대표)", "viewpoint": "시민사회 입장에서... [실제 발언 인용]"}
]

만약 관련 전문가 의견을 찾을 수 없다면 빈 배열 [] 반환`

      const perspectivesResponse = await callPerplexity(perspectivesPrompt)
      
      let perspectives
      try {
        const jsonMatch = perspectivesResponse.match(/\[[\s\S]*\]/)
        if (jsonMatch) {
          perspectives = JSON.parse(jsonMatch[0])
        } else {
          perspectives = []
        }
      } catch {
        perspectives = []
      }

      // Save to database
      const { error: insertError } = await supabaseAdmin
        .from('news_items')
        .insert({
          briefing_id: task.briefing_id,
          position: task.position,
          title: mainResearch.title,
          summary: mainResearch.summary,
          main_content: mainResearch.main_content,
          key_terms: mainResearch.key_terms,
          background_context: backgroundContext,
          fact_check: factCheck,
          sources: mainResearch.sources,
          perspectives: perspectives,
          perplexity_search_id: `${task.briefing_id}-${task.position}`,
          processing_status: 'completed'
        })

      if (insertError) {
        throw insertError
      }

      // Mark task as completed
      await supabaseAdmin
        .from('news_research_queue')
        .update({ 
          status: 'completed',
          completed_at: new Date().toISOString()
        })
        .eq('id', task.id)

      return new Response(
        JSON.stringify({ 
          success: true,
          task_id: task.id,
          position: task.position,
          title: mainResearch.title
        }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 200 }
      )
    } catch (error) {
      // Mark task as failed
      await supabaseAdmin
        .from('news_research_queue')
        .update({ 
          status: 'failed',
          error_message: error.message
        })
        .eq('id', task.id)

      throw error
    }
  } catch (error) {
    console.error('Error processing news queue:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 500 }
    )
  }
})