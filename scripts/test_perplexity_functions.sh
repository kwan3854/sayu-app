#!/bin/bash

# 색상 정의
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Supabase URL과 키
SUPABASE_URL="http://127.0.0.1:54321"
SUPABASE_ANON_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0"

echo -e "${YELLOW}Testing Perplexity News Functions${NC}"
echo "=================================="

# 1. 주제 생성 테스트
echo -e "\n${GREEN}1. Testing generate-daily-topics${NC}"
TOPICS_RESPONSE=$(curl -s -X POST "${SUPABASE_URL}/functions/v1/generate-daily-topics" \
  -H "Authorization: Bearer ${SUPABASE_ANON_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "country_code": "KR",
    "region": "Seoul"
  }')

echo "Response: $TOPICS_RESPONSE"

# briefing_id 추출
BRIEFING_ID=$(echo $TOPICS_RESPONSE | jq -r '.briefing_id')

if [ "$BRIEFING_ID" != "null" ] && [ -n "$BRIEFING_ID" ]; then
    echo -e "${GREEN}✓ Topics generated successfully${NC}"
    echo "Briefing ID: $BRIEFING_ID"
    
    # 2. 첫 번째 뉴스 아이템 리서치 테스트
    echo -e "\n${GREEN}2. Testing research-news-item${NC}"
    
    # topics 배열에서 첫 번째 항목 추출
    FIRST_TOPIC=$(echo $TOPICS_RESPONSE | jq '.topics[0]')
    
    if [ "$FIRST_TOPIC" != "null" ]; then
        echo "Researching topic: $(echo $FIRST_TOPIC | jq -r '.title')"
        
        RESEARCH_RESPONSE=$(curl -s -X POST "${SUPABASE_URL}/functions/v1/research-news-item" \
          -H "Authorization: Bearer ${SUPABASE_ANON_KEY}" \
          -H "Content-Type: application/json" \
          -d "{
            \"briefing_id\": \"$BRIEFING_ID\",
            \"position\": 1,
            \"topic\": $FIRST_TOPIC
          }")
        
        echo "Response: $RESEARCH_RESPONSE"
        
        if echo "$RESEARCH_RESPONSE" | jq -e '.success' > /dev/null; then
            echo -e "${GREEN}✓ News item researched successfully${NC}"
        else
            echo -e "${RED}✗ Failed to research news item${NC}"
        fi
    else
        echo -e "${RED}✗ No topics found in response${NC}"
    fi
else
    echo -e "${RED}✗ Failed to generate topics${NC}"
    echo "Error: $(echo $TOPICS_RESPONSE | jq -r '.error')"
fi

# 3. 전체 브리핑 생성 테스트
echo -e "\n${GREEN}3. Testing generate-daily-briefing${NC}"
BRIEFING_RESPONSE=$(curl -s -X POST "${SUPABASE_URL}/functions/v1/generate-daily-briefing" \
  -H "Authorization: Bearer ${SUPABASE_ANON_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "country_code": "KR",
    "region": "Seoul"
  }')

echo "Response: $BRIEFING_RESPONSE"

if echo "$BRIEFING_RESPONSE" | jq -e '.success' > /dev/null; then
    echo -e "${GREEN}✓ Daily briefing generated successfully${NC}"
    echo "Topics count: $(echo $BRIEFING_RESPONSE | jq -r '.topics_count')"
    echo "Researched count: $(echo $BRIEFING_RESPONSE | jq -r '.researched_count')"
else
    echo -e "${RED}✗ Failed to generate daily briefing${NC}"
fi