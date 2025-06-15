-- 기존 테이블 삭제 (있다면)
DROP TABLE IF EXISTS public.news_items CASCADE;
DROP TABLE IF EXISTS public.user_briefing_settings CASCADE;
DROP TABLE IF EXISTS public.daily_briefings CASCADE;

-- 일일 브리핑 테이블
CREATE TABLE public.daily_briefings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    country_code VARCHAR(2) NOT NULL,
    region VARCHAR(100),
    briefing_date DATE NOT NULL,
    topics JSONB NOT NULL, -- 10개의 주제 리스트
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(country_code, region, briefing_date)
);

-- 개별 뉴스 아이템
CREATE TABLE public.news_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    briefing_id UUID REFERENCES daily_briefings(id) ON DELETE CASCADE,
    position INTEGER NOT NULL CHECK (position >= 1 AND position <= 10),
    title TEXT NOT NULL,
    summary TEXT NOT NULL,
    main_content TEXT NOT NULL,
    key_terms JSONB DEFAULT '[]', -- [{term, definition}]
    background_context TEXT,
    fact_check JSONB DEFAULT '{}', -- {status, details}
    sources JSONB DEFAULT '[]', -- [{title, url}]
    perspectives JSONB DEFAULT '[]', -- [{expert, viewpoint}]
    perplexity_search_id VARCHAR(255), -- 추적용
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(briefing_id, position)
);

-- 사용자 브리핑 설정
CREATE TABLE public.user_briefing_settings (
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE PRIMARY KEY,
    country_code VARCHAR(2) NOT NULL DEFAULT 'KR',
    region VARCHAR(100) DEFAULT 'Seoul',
    delivery_time TIME DEFAULT '08:00:00',
    enabled BOOLEAN DEFAULT true,
    categories JSONB DEFAULT '["정치", "경제", "사회", "과학", "문화"]',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 인덱스 생성
CREATE INDEX idx_daily_briefings_date ON daily_briefings(briefing_date);
CREATE INDEX idx_daily_briefings_location ON daily_briefings(country_code, region);
CREATE INDEX idx_news_items_briefing ON news_items(briefing_id);
CREATE INDEX idx_user_briefing_settings_enabled ON user_briefing_settings(enabled) WHERE enabled = true;

-- RLS 정책
ALTER TABLE daily_briefings ENABLE ROW LEVEL SECURITY;
ALTER TABLE news_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_briefing_settings ENABLE ROW LEVEL SECURITY;

-- 모든 사용자가 브리핑을 읽을 수 있음
CREATE POLICY "Anyone can read briefings" ON daily_briefings
    FOR SELECT USING (true);

CREATE POLICY "Anyone can read news items" ON news_items
    FOR SELECT USING (true);

-- 사용자는 자신의 설정만 관리할 수 있음
CREATE POLICY "Users can manage own briefing settings" ON user_briefing_settings
    FOR ALL USING (auth.uid() = user_id);

-- 트리거: 사용자 브리핑 설정 updated_at 자동 업데이트
CREATE TRIGGER update_user_briefing_settings_updated_at
    BEFORE UPDATE ON user_briefing_settings
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();