# 사유(Sayu) 데이터베이스 스키마 설계

## 1. 개요

사유 앱의 데이터베이스는 다음과 같은 주요 기능을 지원해야 합니다:
- 사용자 인증 및 프로필 관리
- 일일 뉴스 브리핑 제공
- 다각적 관점 콘텐츠 관리
- 사용자 성찰 기록 저장
- 예측 챌린지 참여 및 결과 추적
- 사용자 성장 데이터 분석

## 2. 테이블 구조

### 2.1 사용자 관련 테이블

#### profiles (사용자 프로필)
```sql
CREATE TABLE profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  display_name TEXT,
  bio TEXT,
  interests TEXT[], -- 관심 분야 (정치, 경제, 기술, 사회, 환경 등)
  preferred_categories TEXT[], -- 선호 뉴스 카테고리
  notification_settings JSONB DEFAULT '{"daily_briefing": true, "weekly_report": true}',
  onboarding_completed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

#### user_stats (사용자 통계)
```sql
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
```

### 2.2 콘텐츠 관련 테이블

#### issues (이슈/뉴스)
```sql
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

-- 인덱스
CREATE INDEX idx_issues_published_at ON issues(published_at DESC);
CREATE INDEX idx_issues_categories ON issues USING GIN(categories);
CREATE INDEX idx_issues_status ON issues(status);
```

#### issue_details (이슈 상세 정보)
```sql
CREATE TABLE issue_details (
  issue_id UUID REFERENCES issues(id) PRIMARY KEY,
  key_terms TEXT[],
  term_definitions JSONB, -- {"term": "definition"} 형태
  metadata JSONB, -- 추가 메타데이터
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

#### background_knowledge (배경 지식)
```sql
CREATE TABLE background_knowledge (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  issue_id UUID REFERENCES issues(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  category TEXT NOT NULL CHECK (category IN ('역사적 맥락', '관련 법규', '기술적 배경', '기타')),
  display_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 인덱스
CREATE INDEX idx_background_knowledge_issue_id ON background_knowledge(issue_id);
```

#### fact_checks (팩트 체크)
```sql
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

-- 인덱스
CREATE INDEX idx_fact_checks_issue_id ON fact_checks(issue_id);
```

#### news_sources (뉴스 출처)
```sql
CREATE TABLE news_sources (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  issue_id UUID REFERENCES issues(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  publisher TEXT NOT NULL,
  url TEXT NOT NULL,
  published_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 인덱스
CREATE INDEX idx_news_sources_issue_id ON news_sources(issue_id);
```

#### perspectives (다각적 관점)
```sql
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

-- 인덱스
CREATE INDEX idx_perspectives_issue_id ON perspectives(issue_id);
CREATE INDEX idx_perspectives_type ON perspectives(perspective_type);
```

### 2.3 사용자 활동 관련 테이블

#### daily_briefings (일일 브리핑)
```sql
CREATE TABLE daily_briefings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  briefing_date DATE NOT NULL,
  issue_ids UUID[] NOT NULL, -- 해당 날짜의 이슈 ID들
  viewed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, briefing_date)
);

-- 인덱스
CREATE INDEX idx_daily_briefings_user_date ON daily_briefings(user_id, briefing_date DESC);
```

#### reflections (성찰 기록)
```sql
CREATE TABLE reflections (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  issue_id UUID REFERENCES issues(id) ON DELETE SET NULL,
  content TEXT NOT NULL,
  word_count INTEGER NOT NULL,
  perspectives_seen TEXT[], -- 본 관점들의 ID
  prediction_made TEXT, -- 연관된 예측 ID
  tags TEXT[],
  ai_feedback TEXT, -- AI 피드백 저장
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 인덱스
CREATE INDEX idx_reflections_user_id ON reflections(user_id);
CREATE INDEX idx_reflections_issue_id ON reflections(issue_id);
CREATE INDEX idx_reflections_created_at ON reflections(created_at DESC);
```

#### prediction_challenges (예측 챌린지)
```sql
CREATE TABLE prediction_challenges (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  category TEXT NOT NULL,
  options JSONB NOT NULL, -- 예측 선택지들
  correct_option TEXT, -- 정답 (결과 발표 후)
  resolution_date DATE NOT NULL,
  resolved_at TIMESTAMPTZ,
  resolution_explanation TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 인덱스
CREATE INDEX idx_prediction_challenges_resolution_date ON prediction_challenges(resolution_date);
```

#### user_predictions (사용자 예측)
```sql
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

-- 인덱스
CREATE INDEX idx_user_predictions_user_id ON user_predictions(user_id);
CREATE INDEX idx_user_predictions_challenge_id ON user_predictions(challenge_id);
```

### 2.4 시스템 관련 테이블

#### api_usage_logs (API 사용 로그)
```sql
CREATE TABLE api_usage_logs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),
  api_name TEXT NOT NULL, -- 'perplexity', 'openai' 등
  endpoint TEXT NOT NULL,
  tokens_used INTEGER,
  cost_estimate DECIMAL(10, 4),
  response_time_ms INTEGER,
  status_code INTEGER,
  error_message TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 인덱스
CREATE INDEX idx_api_usage_logs_created_at ON api_usage_logs(created_at DESC);
CREATE INDEX idx_api_usage_logs_user_id ON api_usage_logs(user_id);
```

## 3. Row Level Security (RLS) 정책

### 3.1 profiles 테이블
```sql
-- RLS 활성화
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- 정책: 사용자는 자신의 프로필만 볼 수 있음
CREATE POLICY "Users can view own profile" ON profiles
  FOR SELECT USING (auth.uid() = id);

-- 정책: 사용자는 자신의 프로필만 수정할 수 있음
CREATE POLICY "Users can update own profile" ON profiles
  FOR UPDATE USING (auth.uid() = id);

-- 정책: 인증된 사용자는 프로필을 생성할 수 있음
CREATE POLICY "Users can insert own profile" ON profiles
  FOR INSERT WITH CHECK (auth.uid() = id);
```

### 3.2 reflections 테이블
```sql
-- RLS 활성화
ALTER TABLE reflections ENABLE ROW LEVEL SECURITY;

-- 정책: 사용자는 자신의 성찰만 볼 수 있음
CREATE POLICY "Users can view own reflections" ON reflections
  FOR SELECT USING (auth.uid() = user_id);

-- 정책: 사용자는 자신의 성찰만 생성할 수 있음
CREATE POLICY "Users can create own reflections" ON reflections
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- 정책: 사용자는 자신의 성찰만 수정할 수 있음
CREATE POLICY "Users can update own reflections" ON reflections
  FOR UPDATE USING (auth.uid() = user_id);

-- 정책: 사용자는 자신의 성찰만 삭제할 수 있음
CREATE POLICY "Users can delete own reflections" ON reflections
  FOR DELETE USING (auth.uid() = user_id);
```

### 3.3 공개 콘텐츠 테이블 (issues, perspectives 등)
```sql
-- 모든 인증된 사용자가 읽을 수 있음
CREATE POLICY "Authenticated users can view published issues" ON issues
  FOR SELECT USING (auth.role() = 'authenticated' AND status = 'published');
```

## 4. 트리거 및 함수

### 4.1 updated_at 자동 업데이트
```sql
-- updated_at 필드를 자동으로 업데이트하는 함수
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

CREATE TRIGGER update_reflections_updated_at BEFORE UPDATE ON reflections
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

### 4.2 사용자 통계 자동 업데이트
```sql
-- 성찰 작성 시 통계 업데이트
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
```

## 5. 초기 데이터 및 샘플 쿼리

### 5.1 오늘의 브리핑 조회
```sql
-- 특정 사용자의 오늘 브리핑 조회
SELECT 
  db.*,
  array_agg(
    json_build_object(
      'id', i.id,
      'headline', i.headline,
      'summary', i.summary,
      'categories', i.categories,
      'image_url', i.image_url
    )
  ) as issues
FROM daily_briefings db
JOIN issues i ON i.id = ANY(db.issue_ids)
WHERE db.user_id = $1 
  AND db.briefing_date = CURRENT_DATE
  AND i.status = 'published'
GROUP BY db.id;
```

### 5.2 이슈 상세 정보 조회
```sql
-- 이슈와 관련된 모든 정보 조회
WITH issue_data AS (
  SELECT 
    i.*,
    id.key_terms,
    id.term_definitions
  FROM issues i
  LEFT JOIN issue_details id ON i.id = id.issue_id
  WHERE i.id = $1
)
SELECT 
  i.*,
  json_agg(DISTINCT p.*) as perspectives,
  json_agg(DISTINCT bk.*) as background_knowledge,
  json_agg(DISTINCT fc.*) as fact_checks,
  json_agg(DISTINCT ns.*) as news_sources
FROM issue_data i
LEFT JOIN perspectives p ON i.id = p.issue_id
LEFT JOIN background_knowledge bk ON i.id = bk.issue_id
LEFT JOIN fact_checks fc ON i.id = fc.issue_id
LEFT JOIN news_sources ns ON i.id = ns.issue_id
GROUP BY i.id, i.headline, i.summary, i.detailed_summary, 
         i.image_url, i.categories, i.importance, i.status,
         i.published_at, i.created_at, i.updated_at,
         i.key_terms, i.term_definitions;
```

## 6. 성능 최적화 고려사항

1. **인덱싱 전략**
   - 자주 조회되는 컬럼에 인덱스 추가
   - 복합 인덱스 활용 (user_id + created_at 등)
   - GIN 인덱스로 배열 검색 최적화

2. **파티셔닝**
   - api_usage_logs는 월별 파티셔닝 고려
   - reflections는 연도별 파티셔닝 고려

3. **캐싱**
   - 자주 조회되는 이슈 데이터는 Redis 캐싱 고려
   - 사용자 통계는 materialized view 활용

## 7. 마이그레이션 순서

1. 기본 테이블 생성 (users 의존성 없는 것부터)
2. 사용자 관련 테이블 생성
3. 콘텐츠 관련 테이블 생성
4. 활동 관련 테이블 생성
5. 인덱스 생성
6. RLS 정책 적용
7. 트리거 및 함수 생성
8. 초기 데이터 삽입

## 8. 백업 및 복구 전략

1. **일일 백업**
   - 전체 데이터베이스 백업
   - Point-in-time recovery 설정

2. **중요 데이터 실시간 복제**
   - reflections, predictions 테이블은 실시간 복제

3. **데이터 보존 정책**
   - API 로그: 3개월 후 아카이빙
   - 사용자 활동 데이터: 영구 보존