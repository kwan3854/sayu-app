-- Clean existing briefing data
TRUNCATE TABLE public.news_items CASCADE;
TRUNCATE TABLE public.news_research_queue CASCADE;
TRUNCATE TABLE public.daily_briefings CASCADE;
TRUNCATE TABLE public.user_briefing_settings CASCADE;