import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!
const SUPABASE_ANON_KEY = Deno.env.get('SUPABASE_ANON_KEY')!

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    console.log('News queue worker started')
    
    // Process up to 5 items per run
    const maxItems = 5
    let processedCount = 0
    
    for (let i = 0; i < maxItems; i++) {
      // Call the process-news-queue function
      const response = await fetch(`${SUPABASE_URL}/functions/v1/process-news-queue`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({})
      })

      if (!response.ok) {
        console.error(`Failed to process queue item ${i + 1}:`, await response.text())
        break
      }

      const result = await response.json()
      
      // If no pending tasks, stop processing
      if (result.message === 'No pending tasks') {
        console.log('No more pending tasks')
        break
      }

      processedCount++
      console.log(`Processed item ${processedCount}: ${result.title}`)
      
      // Wait 2 seconds between items to respect rate limits
      if (i < maxItems - 1) {
        await new Promise(resolve => setTimeout(resolve, 2000))
      }
    }

    return new Response(
      JSON.stringify({ 
        success: true,
        processed_count: processedCount
      }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 200 }
    )
  } catch (error) {
    console.error('Error in news queue worker:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 500 }
    )
  }
})