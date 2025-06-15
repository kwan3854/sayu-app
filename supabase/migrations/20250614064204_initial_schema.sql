-- 사유(Sayu) 초기 데이터베이스 스키마

-- 1. 사용자 관련 테이블

-- profiles 테이블: 사용자 프로필 확장
CREATE TABLE profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  display_name TEXT,
  bio TEXT,
  interests TEXT[], -- 관심 분야
  preferred_categories TEXT[], -- 선호 뉴스 카테고리
  notification_settings JSONB DEFAULT '{"daily_briefing": true, "weekly_report": true}'::jsonb,
  onboarding_completed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- user_stats 테이블: 사용자 통계
CREATE TABLE user_stats (
  user_id UUID REFERENCES auth.users(id) PRIMARY KEY,
  total_reflections INTEGER DEFAULT 0,
  total_predictions INTEGER DEFAULT 0,
  correct_predictions INTEGER DEFAULT 0,
  current_streak INTEGER DEFAULT 0,
  longest_streak INTEGER DEFAULT 0,
  last_activity_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 콘텐츠 관련 테이블

-- issues 테이블: 이슈/뉴스
CREATE TABLE issues (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  headline TEXT NOT NULL,
  summary TEXT NOT NULL,
  detailed_summary TEXT,
  image_url TEXT,
  categories TEXT[] NOT NULL,
  importance INTEGER CHECK (importance BETWEEN 1 AND 5),
  status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'published', 'archived')),
  published_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- issue_details 테이블: 이슈 상세 정보
CREATE TABLE issue_details (
  issue_id UUID REFERENCES issues(id) PRIMARY KEY,
  key_terms TEXT[],
  term_definitions JSONB,
  metadata JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- background_knowledge 테이블: 배경 지식
CREATE TABLE background_knowledge (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  issue_id UUID REFERENCES issues(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  category TEXT NOT NULL CHECK (category IN ('역사적 맥락', '관련 법규', '기술적 배경', '기타')),
  display_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- fact_checks 테이블: 팩트 체크
CREATE TABLE fact_checks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  issue_id UUID REFERENCES issues(id) ON DELETE CASCADE,
  claim TEXT NOT NULL,
  verdict TEXT NOT NULL CHECK (verdict IN ('사실', '대체로 사실', '논란의 여지', '오해의 소지', '거짓')),
  explanation TEXT NOT NULL,
  sources TEXT[],
  display_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- news_sources 테이블: 뉴스 출처
CREATE TABLE news_sources (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  issue_id UUID REFERENCES issues(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  publisher TEXT NOT NULL,
  url TEXT NOT NULL,
  published_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- perspectives 테이블: 다각적 관점
CREATE TABLE perspectives (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  issue_id UUID REFERENCES issues(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  expert_name TEXT NOT NULL,
  expert_title TEXT NOT NULL,
  expert_image_url TEXT,
  perspective_type TEXT NOT NULL CHECK (perspective_type IN ('이해관계자', '시간적 관점', '전문 분야', '지역별', '철학적')),
  perspective_detail TEXT NOT NULL,
  interactive_questions TEXT[],
  display_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. 사용자 활동 관련 테이블

-- daily_briefings 테이블: 일일 브리핑
CREATE TABLE daily_briefings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  briefing_date DATE NOT NULL,
  issue_ids UUID[] NOT NULL,
  viewed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, briefing_date)
);

-- reflections 테이블: 성찰 기록
CREATE TABLE reflections (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  issue_id UUID REFERENCES issues(id) ON DELETE SET NULL,
  content TEXT NOT NULL,
  word_count INTEGER NOT NULL,
  perspectives_seen TEXT[],
  prediction_made TEXT,
  tags TEXT[],
  ai_feedback TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- prediction_challenges 테이블: 예측 챌린지
CREATE TABLE prediction_challenges (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  category TEXT NOT NULL,
  options JSONB NOT NULL,
  correct_option TEXT,
  resolution_date DATE NOT NULL,
  resolved_at TIMESTAMPTZ,
  resolution_explanation TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- user_predictions 테이블: 사용자 예측
CREATE TABLE user_predictions (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  challenge_id UUID REFERENCES prediction_challenges(id) ON DELETE CASCADE,
  prediction TEXT NOT NULL,
  confidence_level INTEGER CHECK (confidence_level BETWEEN 1 AND 5),
  reasoning TEXT,
  is_correct BOOLEAN,
  points_earned INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, challenge_id)
);

-- 4. 시스템 관련 테이블

-- api_usage_logs 테이블: API 사용 로그
CREATE TABLE api_usage_logs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),
  api_name TEXT NOT NULL,
  endpoint TEXT NOT NULL,
  tokens_used INTEGER,
  cost_estimate DECIMAL(10, 4),
  response_time_ms INTEGER,
  status_code INTEGER,
  error_message TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. 인덱스 생성

-- issues 인덱스
CREATE INDEX idx_issues_published_at ON issues(published_at DESC);
CREATE INDEX idx_issues_categories ON issues USING GIN(categories);
CREATE INDEX idx_issues_status ON issues(status);

-- background_knowledge 인덱스
CREATE INDEX idx_background_knowledge_issue_id ON background_knowledge(issue_id);

-- fact_checks 인덱스
CREATE INDEX idx_fact_checks_issue_id ON fact_checks(issue_id);

-- news_sources 인덱스
CREATE INDEX idx_news_sources_issue_id ON news_sources(issue_id);

-- perspectives 인덱스
CREATE INDEX idx_perspectives_issue_id ON perspectives(issue_id);
CREATE INDEX idx_perspectives_type ON perspectives(perspective_type);

-- daily_briefings 인덱스
CREATE INDEX idx_daily_briefings_user_date ON daily_briefings(user_id, briefing_date DESC);

-- reflections 인덱스
CREATE INDEX idx_reflections_user_id ON reflections(user_id);
CREATE INDEX idx_reflections_issue_id ON reflections(issue_id);
CREATE INDEX idx_reflections_created_at ON reflections(created_at DESC);

-- prediction_challenges 인덱스
CREATE INDEX idx_prediction_challenges_resolution_date ON prediction_challenges(resolution_date);

-- user_predictions 인덱스
CREATE INDEX idx_user_predictions_user_id ON user_predictions(user_id);
CREATE INDEX idx_user_predictions_challenge_id ON user_predictions(challenge_id);

-- api_usage_logs 인덱스
CREATE INDEX idx_api_usage_logs_created_at ON api_usage_logs(created_at DESC);
CREATE INDEX idx_api_usage_logs_user_id ON api_usage_logs(user_id);

-- 6. Row Level Security (RLS) 정책

-- profiles 테이블 RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own profile" ON profiles
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON profiles
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile" ON profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- user_stats 테이블 RLS
ALTER TABLE user_stats ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own stats" ON user_stats
  FOR SELECT USING (auth.uid() = user_id);

-- reflections 테이블 RLS
ALTER TABLE reflections ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own reflections" ON reflections
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can create own reflections" ON reflections
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own reflections" ON reflections
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own reflections" ON reflections
  FOR DELETE USING (auth.uid() = user_id);

-- daily_briefings 테이블 RLS
ALTER TABLE daily_briefings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own briefings" ON daily_briefings
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can create own briefings" ON daily_briefings
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own briefings" ON daily_briefings
  FOR UPDATE USING (auth.uid() = user_id);

-- user_predictions 테이블 RLS
ALTER TABLE user_predictions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own predictions" ON user_predictions
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can create own predictions" ON user_predictions
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- 공개 콘텐츠 테이블 RLS (모든 인증된 사용자가 읽을 수 있음)
ALTER TABLE issues ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can view published issues" ON issues
  FOR SELECT USING (auth.role() = 'authenticated' AND status = 'published');

ALTER TABLE issue_details ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can view issue details" ON issue_details
  FOR SELECT USING (
    auth.role() = 'authenticated' AND 
    EXISTS (
      SELECT 1 FROM issues 
      WHERE issues.id = issue_details.issue_id 
      AND issues.status = 'published'
    )
  );

ALTER TABLE perspectives ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can view perspectives" ON perspectives
  FOR SELECT USING (
    auth.role() = 'authenticated' AND 
    EXISTS (
      SELECT 1 FROM issues 
      WHERE issues.id = perspectives.issue_id 
      AND issues.status = 'published'
    )
  );

ALTER TABLE background_knowledge ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can view background knowledge" ON background_knowledge
  FOR SELECT USING (
    auth.role() = 'authenticated' AND 
    EXISTS (
      SELECT 1 FROM issues 
      WHERE issues.id = background_knowledge.issue_id 
      AND issues.status = 'published'
    )
  );

ALTER TABLE fact_checks ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can view fact checks" ON fact_checks
  FOR SELECT USING (
    auth.role() = 'authenticated' AND 
    EXISTS (
      SELECT 1 FROM issues 
      WHERE issues.id = fact_checks.issue_id 
      AND issues.status = 'published'
    )
  );

ALTER TABLE news_sources ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can view news sources" ON news_sources
  FOR SELECT USING (
    auth.role() = 'authenticated' AND 
    EXISTS (
      SELECT 1 FROM issues 
      WHERE issues.id = news_sources.issue_id 
      AND issues.status = 'published'
    )
  );

ALTER TABLE prediction_challenges ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can view challenges" ON prediction_challenges
  FOR SELECT USING (auth.role() = 'authenticated');

-- 7. 트리거 및 함수

-- updated_at 자동 업데이트 함수
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- 각 테이블에 트리거 적용
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_user_stats_updated_at BEFORE UPDATE ON user_stats
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_issues_updated_at BEFORE UPDATE ON issues
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_issue_details_updated_at BEFORE UPDATE ON issue_details
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_reflections_updated_at BEFORE UPDATE ON reflections
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- 사용자 통계 자동 업데이트 함수
CREATE OR REPLACE FUNCTION update_user_stats_on_reflection()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO user_stats (user_id, total_reflections, last_activity_at)
    VALUES (NEW.user_id, 1, NOW())
    ON CONFLICT (user_id)
    DO UPDATE SET
      total_reflections = user_stats.total_reflections + 1,
      last_activity_at = NOW(),
      current_streak = CASE
        WHEN user_stats.last_activity_at::date = CURRENT_DATE - INTERVAL '1 day'
        THEN user_stats.current_streak + 1
        WHEN user_stats.last_activity_at::date < CURRENT_DATE - INTERVAL '1 day'
        THEN 1
        ELSE user_stats.current_streak
      END,
      longest_streak = GREATEST(user_stats.longest_streak, user_stats.current_streak);
  END IF;
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER trigger_update_stats_on_reflection
AFTER INSERT ON reflections
FOR EACH ROW EXECUTE FUNCTION update_user_stats_on_reflection();

-- 예측 결과 업데이트 시 통계 업데이트
CREATE OR REPLACE FUNCTION update_user_stats_on_prediction_result()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.is_correct IS NOT NULL AND OLD.is_correct IS NULL THEN
    UPDATE user_stats
    SET 
      correct_predictions = correct_predictions + CASE WHEN NEW.is_correct THEN 1 ELSE 0 END
    WHERE user_id = NEW.user_id;
  END IF;
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER trigger_update_stats_on_prediction_result
AFTER UPDATE ON user_predictions
FOR EACH ROW EXECUTE FUNCTION update_user_stats_on_prediction_result();

-- 새로운 예측 생성 시 통계 업데이트
CREATE OR REPLACE FUNCTION update_user_stats_on_new_prediction()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO user_stats (user_id, total_predictions, last_activity_at)
  VALUES (NEW.user_id, 1, NOW())
  ON CONFLICT (user_id)
  DO UPDATE SET
    total_predictions = user_stats.total_predictions + 1,
    last_activity_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER trigger_update_stats_on_new_prediction
AFTER INSERT ON user_predictions
FOR EACH ROW EXECUTE FUNCTION update_user_stats_on_new_prediction();

-- 새로운 사용자 생성 시 프로필 자동 생성
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO profiles (id, username, created_at, updated_at)
  VALUES (
    NEW.id,
    NEW.email,
    NOW(),
    NOW()
  );
  
  INSERT INTO user_stats (user_id, created_at, updated_at)
  VALUES (
    NEW.id,
    NOW(),
    NOW()
  );
  
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER on_auth_user_created
AFTER INSERT ON auth.users
FOR EACH ROW EXECUTE FUNCTION handle_new_user();