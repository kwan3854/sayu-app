-- Drop unused tables from old schema
-- These tables were part of the initial design but are no longer used

-- Drop views first
DROP VIEW IF EXISTS public.issues_with_details CASCADE;

-- Drop tables in correct order (respecting foreign key constraints)
DROP TABLE IF EXISTS public.user_predictions CASCADE;
DROP TABLE IF EXISTS public.prediction_challenges CASCADE;
DROP TABLE IF EXISTS public.reflections CASCADE;
DROP TABLE IF EXISTS public.perspectives CASCADE;
DROP TABLE IF EXISTS public.news_sources CASCADE;
DROP TABLE IF EXISTS public.fact_checks CASCADE;
DROP TABLE IF EXISTS public.background_knowledge CASCADE;
DROP TABLE IF EXISTS public.issue_details CASCADE;
DROP TABLE IF EXISTS public.issues CASCADE;
DROP TABLE IF EXISTS public.api_usage_logs CASCADE;

-- Keep these tables as they might be used in the future:
-- user_stats (automatically updated by triggers)
-- profiles (used for authentication)