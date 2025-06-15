# Background Processing for News Research

## Problem
The Edge Functions were timing out after 2 minutes when trying to research all 10 news items synchronously. This was happening because each news item requires multiple Perplexity API calls for:
- Main research (Sonar Pro)
- Background knowledge (Sonar)
- Fact checking (Sonar)
- Expert perspectives (Sonar Pro)

## Solution
Implemented a queue-based background processing system:

### 1. Database Schema
- Added `news_research_queue` table to track research tasks
- Added `processing_status` column to `news_items` table
- Queue tracks: briefing_id, position, topic, status, attempts, error_message

### 2. Edge Functions
- **generate-daily-briefing**: Creates topics and queues research tasks
- **process-news-queue**: Processes a single item from the queue
- **news-queue-worker**: Processes up to 5 items per run (with rate limiting)

### 3. Processing Flow
1. User requests daily briefing
2. Topics are generated immediately
3. Research tasks are queued
4. Worker processes queue items one by one
5. UI shows progress and updates as items complete

### 4. UI Updates
- Shows topic cards with "리서치 진행중..." indicator
- Displays progress bar showing completion status
- Automatically updates as news items are researched
- Users can refresh to check for updates

## Benefits
- No more timeouts
- Better user experience (see progress)
- Respects API rate limits
- Can retry failed items
- Scalable to handle more items

## Future Improvements
1. Set up Supabase cron job to run worker every 2 minutes
2. Add webhook to notify when briefing is complete
3. Implement priority queue for premium users
4. Add retry logic with exponential backoff