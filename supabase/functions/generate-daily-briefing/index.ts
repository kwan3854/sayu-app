import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!
const SUPABASE_ANON_KEY = Deno.env.get('SUPABASE_ANON_KEY')!

interface BriefingRequest {
  country_code?: string
  region?: string
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

    const { country_code = 'KR', region = 'Seoul' } = await req.json() as BriefingRequest

    console.log(`Generating daily briefing for ${country_code} - ${region}`)

    // Step 1: Generate topics
    const topicsResponse = await fetch(`${SUPABASE_URL}/functions/v1/generate-daily-topics`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ country_code, region })
    })

    if (!topicsResponse.ok) {
      throw new Error('Failed to generate topics')
    }

    const { briefing_id, topics } = await topicsResponse.json()
    console.log(`Generated ${topics.length} topics for briefing ${briefing_id}`)

    // Step 2: Queue research tasks for background processing
    const queueInserts = topics.map((topic: any, index: number) => ({
      briefing_id,
      position: index + 1,
      topic,
      status: 'pending'
    }))

    const { error: queueError } = await supabaseAdmin
      .from('news_research_queue')
      .insert(queueInserts)

    if (queueError) {
      console.error('Error queuing research tasks:', queueError)
      throw queueError
    }

    console.log(`Queued ${topics.length} news items for background research`)

    // Get the complete briefing
    const { data: briefing, error: fetchError } = await supabaseAdmin
      .from('daily_briefings')
      .select(`
        *,
        news_items (*)
      `)
      .eq('id', briefing_id)
      .single()

    if (fetchError) {
      throw fetchError
    }

    return new Response(
      JSON.stringify({ 
        success: true,
        briefing_id,
        topics_count: topics.length,
        queued_count: topics.length,
        briefing
      }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 200 }
    )
  } catch (error) {
    console.error('Error generating daily briefing:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 500 }
    )
  }
})