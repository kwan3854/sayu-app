-- Create a queue table for news research tasks
CREATE TABLE public.news_research_queue (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    briefing_id UUID NOT NULL REFERENCES public.daily_briefings(id) ON DELETE CASCADE,
    position INTEGER NOT NULL,
    topic JSONB NOT NULL,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'completed', 'failed')),
    attempts INTEGER DEFAULT 0,
    error_message TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    completed_at TIMESTAMPTZ,
    UNIQUE(briefing_id, position)
);

-- Add indexes for efficient queue processing
CREATE INDEX idx_news_research_queue_status ON public.news_research_queue(status);
CREATE INDEX idx_news_research_queue_created_at ON public.news_research_queue(created_at);

-- Create RLS policies
ALTER TABLE public.news_research_queue ENABLE ROW LEVEL SECURITY;

-- Service role can do everything
CREATE POLICY "Service role can manage queue" ON public.news_research_queue
    FOR ALL USING (auth.role() = 'service_role');

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger for updated_at
CREATE TRIGGER update_news_research_queue_updated_at BEFORE UPDATE
    ON public.news_research_queue FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Add a processing status to news_items table
ALTER TABLE public.news_items 
ADD COLUMN IF NOT EXISTS processing_status VARCHAR(20) DEFAULT 'pending' 
CHECK (processing_status IN ('pending', 'processing', 'completed', 'failed'));

-- Create index on processing status
CREATE INDEX IF NOT EXISTS idx_news_items_processing_status ON public.news_items(processing_status);