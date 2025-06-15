import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
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

    // Delete in correct order to respect foreign key constraints
    console.log('Deleting news_items...')
    const { error: newsError } = await supabaseAdmin
      .from('news_items')
      .delete()
      .gte('created_at', '2000-01-01')  // Delete all

    if (newsError) {
      console.error('Error deleting news_items:', newsError)
    }

    console.log('Deleting news_research_queue...')
    const { error: queueError } = await supabaseAdmin
      .from('news_research_queue')
      .delete()
      .gte('created_at', '2000-01-01')  // Delete all

    if (queueError) {
      console.error('Error deleting news_research_queue:', queueError)
    }

    console.log('Deleting daily_briefings...')
    const { error: briefingError } = await supabaseAdmin
      .from('daily_briefings')
      .delete()
      .gte('created_at', '2000-01-01')  // Delete all

    if (briefingError) {
      console.error('Error deleting daily_briefings:', briefingError)
    }

    console.log('Deleting user_briefing_settings...')
    const { error: settingsError } = await supabaseAdmin
      .from('user_briefing_settings')
      .delete()
      .gte('created_at', '2000-01-01')  // Delete all

    if (settingsError) {
      console.error('Error deleting user_briefing_settings:', settingsError)
    }

    return new Response(
      JSON.stringify({ 
        success: true,
        message: 'All briefing data cleaned successfully'
      }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 200 }
    )
  } catch (error) {
    console.error('Error cleaning briefing data:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 500 }
    )
  }
})