# 사유의 아침 - 뉴스 리서치 시스템 설계

## 개요
Perplexity API를 활용하여 사용자 위치 기반으로 매일 오전 8시에 맞춤형 뉴스 브리핑을 제공하는 시스템

## 시스템 아키텍처

### 1. 데이터 플로우
```
[Cron Job (새벽 5시)] 
    ↓
[뉴스 주제 선정 (Sonar Pro)]
    ↓
[개별 뉴스 리서치 (Sonar Pro x 10)]
    ↓
[추가 컨텍스트 생성]
    - 배경 지식 (Sonar)
    - 팩트 체크 (Sonar)
    - 다각적 관점 (Sonar Pro)
    ↓
[데이터베이스 저장]
    ↓
[오전 8시 사용자별 푸시]
```

### 2. 데이터베이스 스키마 확장

```sql
-- 일일 브리핑 테이블
CREATE TABLE daily_briefings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    country_code VARCHAR(2) NOT NULL,
    region VARCHAR(100),
    briefing_date DATE NOT NULL,
    topics JSONB NOT NULL, -- 10개의 주제 리스트
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(country_code, region, briefing_date)
);

-- 개별 뉴스 아이템
CREATE TABLE news_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    briefing_id UUID REFERENCES daily_briefings(id),
    position INTEGER NOT NULL, -- 1-10
    title TEXT NOT NULL,
    summary TEXT NOT NULL,
    main_content TEXT NOT NULL,
    key_terms JSONB, -- [{term, definition}]
    background_context TEXT,
    fact_check JSONB, -- {status, details}
    sources JSONB, -- [{title, url}]
    perspectives JSONB, -- [{expert, viewpoint}]
    perplexity_search_id VARCHAR(255), -- 추적용
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 사용자 브리핑 설정
CREATE TABLE user_briefing_settings (
    user_id UUID REFERENCES profiles(id) PRIMARY KEY,
    country_code VARCHAR(2) NOT NULL,
    region VARCHAR(100),
    delivery_time TIME DEFAULT '08:00:00',
    enabled BOOLEAN DEFAULT true,
    categories JSONB DEFAULT '["정치", "경제", "사회", "과학", "문화"]',
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

## API 호출 전략

### 1단계: 주제 선정 (1회 호출)
```javascript
const topicSelectionPrompt = {
  model: "sonar-pro",
  messages: [{
    role: "system",
    content: "당신은 뉴스 큐레이터입니다. 오늘의 가장 중요한 뉴스 10개를 선정해주세요."
  }, {
    role: "user",
    content: `${country} ${region}의 오늘 주요 뉴스 10개를 선정해주세요. 
    카테고리: 정치, 경제, 사회, 과학기술, 문화
    형식: JSON [{title, category, keywords}]`
  }],
  search_options: {
    search_after_date_filter: todayMinus1,
    search_before_date_filter: today,
    user_location: `${country}, ${region}`,
    context_length: "high",
    domains: ["reuters.com", "bloomberg.com", "nytimes.com", ...trustedSources],
    exclude_domains: ["twitter.com", "facebook.com", "reddit.com"]
  }
};
```

### 2단계: 개별 뉴스 심층 리서치 (10회 호출)
```javascript
const newsResearchPrompt = {
  model: "sonar-pro",
  messages: [{
    role: "user",
    content: `"${newsTitle}"에 대한 심층 분석:
    1. 핵심 요약 (3-5문장)
    2. 주요 내용 (상세)
    3. 핵심 용어 및 설명
    4. 인용 가능한 출처들`
  }],
  search_options: {
    search_recency_filter: "day",
    context_length: "high",
    domains: trustedNewsDomains
  }
};
```

### 3단계: 보조 정보 생성

#### 배경 지식 (Sonar 모델 사용)
```javascript
const backgroundPrompt = {
  model: "sonar", // 비용 절감
  messages: [{
    role: "user",
    content: `"${newsTitle}"를 이해하기 위한 배경 지식을 제공해주세요.
    - 역사적 맥락
    - 관련 사건들
    - 기본 개념 설명`
  }],
  search_options: {
    context_length: "medium"
  }
};
```

#### 팩트 체크 (Sonar 모델)
```javascript
const factCheckPrompt = {
  model: "sonar",
  messages: [{
    role: "user",
    content: `다음 내용의 팩트체크: "${mainClaim}"
    - 사실 여부
    - 근거 자료
    - 신뢰도 평가`
  }],
  search_options: {
    domains: ["snopes.com", "factcheck.org", "politifact.com"],
    context_length: "high"
  }
};
```

#### 다각적 관점 (Sonar Pro 모델)
```javascript
const perspectivesPrompt = {
  model: "sonar-pro",
  messages: [{
    role: "user",
    content: `"${newsTitle}"에 대한 다양한 전문가 의견:
    1. 진보적 관점
    2. 보수적 관점
    3. 중립적/학술적 관점
    4. 산업계 관점
    5. 시민사회 관점`
  }],
  search_options: {
    context_length: "high",
    domains: expertDomains
  }
};
```

## 구현 전략

### 1. Supabase Edge Function 생성
- `generate-daily-briefing`: 매일 새벽 5시 실행
- `fetch-news-details`: 개별 뉴스 상세 정보 수집
- `deliver-briefing`: 사용자별 시간대에 맞춰 전송

### 2. 비용 최적화
- 주제 선정: Sonar Pro (1회)
- 개별 리서치: Sonar Pro (10회)
- 배경/팩트체크: Sonar (20회)
- 다각적 관점: Sonar Pro (10회)
- **일일 예상 비용**: 약 $0.50-$1.00 per region

### 3. 캐싱 전략
- 국가/지역별로 브리핑 캐싱
- 동일 지역 사용자는 같은 브리핑 공유
- 24시간 캐시 유지

### 4. 에러 처리
- API 호출 실패 시 3회 재시도
- 부분 실패 시 사용 가능한 데이터만으로 브리핑 생성
- 완전 실패 시 이전 날 브리핑 + 알림

## Flutter 앱 통합

### 1. 브리핑 조회 API
```dart
class MorningBriefingRepository {
  Future<DailyBriefing> getTodaysBriefing() async {
    final userLocation = await getUserLocation();
    final response = await supabase
      .from('daily_briefings')
      .select('*, news_items(*)')
      .eq('country_code', userLocation.countryCode)
      .eq('briefing_date', DateTime.now().toIso8601String().split('T')[0])
      .single();
    
    return DailyBriefing.fromJson(response);
  }
}
```

### 2. UI 업데이트
- 기존 MockMorningBriefingScreen을 실제 데이터로 교체
- 로딩 상태 처리
- 에러 상태 처리 (오프라인 캐시 제공)

## 타임라인

### Phase 1: 백엔드 구현 (1주)
- [ ] 데이터베이스 스키마 생성
- [ ] Perplexity API 통합 Edge Function
- [ ] 주제 선정 로직 구현
- [ ] 개별 뉴스 리서치 구현

### Phase 2: 데이터 처리 (3일)
- [ ] 배경 지식 생성
- [ ] 팩트 체크 통합
- [ ] 다각적 관점 수집
- [ ] 데이터 정규화 및 저장

### Phase 3: 앱 통합 (3일)
- [ ] Repository 구현
- [ ] BLoC 패턴 적용
- [ ] UI 실제 데이터 연결
- [ ] 푸시 알림 설정

### Phase 4: 테스트 및 최적화 (3일)
- [ ] 다양한 지역 테스트
- [ ] 성능 최적화
- [ ] 비용 모니터링
- [ ] 사용자 피드백 수집

## 예상 문제점 및 해결책

1. **API 비용 증가**
   - 해결: 캐싱 강화, 사용자별 요청 제한

2. **뉴스 품질 불균형**
   - 해결: 신뢰할 수 있는 도메인 리스트 관리

3. **지역별 언어 차이**
   - 해결: 한국어 우선, 추후 다국어 지원

4. **실시간성 부족**
   - 해결: 중요 뉴스는 즉시 업데이트 옵션 제공