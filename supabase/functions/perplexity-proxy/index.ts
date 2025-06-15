// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

Deno.serve(async (req) => {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const { query, context } = await req.json()

    // Verify authentication
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) {
      return new Response(
        JSON.stringify({ error: 'Missing authorization header' }),
        { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Initialize Supabase client
    const supabaseUrl = Deno.env.get('SUPABASE_URL') ?? ''
    const supabaseAnonKey = Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    const supabase = createClient(supabaseUrl, supabaseAnonKey, {
      global: { headers: { Authorization: authHeader } }
    })

    // Verify user is authenticated
    const { data: { user }, error: authError } = await supabase.auth.getUser()
    if (authError || !user) {
      return new Response(
        JSON.stringify({ error: 'Unauthorized' }),
        { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Get Perplexity API key from environment
    const perplexityApiKey = Deno.env.get('PERPLEXITY_API_KEY')
    if (!perplexityApiKey) {
      return new Response(
        JSON.stringify({ error: 'Perplexity API key not configured' }),
        { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Call Perplexity API
    const perplexityResponse = await fetch('https://api.perplexity.ai/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${perplexityApiKey}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: 'sonar-medium-online',
        messages: [
          {
            role: 'system',
            content: 'You are a helpful assistant for a critical thinking app called Sayu (사유). Provide factual, balanced information with sources when available. Focus on Korean current affairs and news when relevant.'
          },
          {
            role: 'user',
            content: query
          }
        ],
        temperature: 0.2,
        max_tokens: 2048,
        return_citations: true,
        search_recency_filter: 'week',
      }),
    })

    if (!perplexityResponse.ok) {
      const error = await perplexityResponse.text()
      console.error('Perplexity API error:', error)
      return new Response(
        JSON.stringify({ error: 'Failed to get response from Perplexity' }),
        { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    const perplexityData = await perplexityResponse.json()

    // Log API usage
    await supabase.from('api_usage_logs').insert({
      user_id: user.id,
      api_name: 'perplexity',
      endpoint: '/chat/completions',
      tokens_used: perplexityData.usage?.total_tokens || 0,
      cost_estimate: (perplexityData.usage?.total_tokens || 0) * 0.0001, // Estimate cost
      response_time_ms: Date.now() - new Date().getTime(),
      status_code: 200,
    })

    // Return the response
    return new Response(
      JSON.stringify({
        content: perplexityData.choices[0].message.content,
        citations: perplexityData.citations || [],
        usage: perplexityData.usage,
      }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )

  } catch (error) {
    console.error('Function error:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
