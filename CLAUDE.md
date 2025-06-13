# 사유(Sayu) 프로젝트 구조 및 기술 스택

## 프로젝트 아키텍처 다이어그램

```
┌─────────────────────────────────────────────────────────────────┐
│                        Presentation Layer                        │
├─────────────────────────────────────────────────────────────────┤
│  screens/          widgets/           theme/          utils/     │
│  ├── onboarding/   ├── zen_*         ├── app_colors  ├── const │
│  ├── main/         ├── premium_*     ├── app_theme   └── ext   │
│  └── settings/     └── common/       └── app_styles            │
├─────────────────────────────────────────────────────────────────┤
│                         Domain Layer                             │
├─────────────────────────────────────────────────────────────────┤
│  entities/         usecases/          repositories/             │
│  ├── user          ├── auth           └── interfaces/           │
│  ├── briefing      ├── briefing                                 │
│  ├── prediction    ├── prediction                               │
│  └── reflection    └── reflection                               │
├─────────────────────────────────────────────────────────────────┤
│                          Data Layer                              │
├─────────────────────────────────────────────────────────────────┤
│  datasources/      repositories/      models/                    │
│  ├── remote/       └── impl/          ├── user_model            │
│  │   ├── supabase                     ├── briefing_model        │
│  │   └── perplexity                   └── prediction_model      │
│  └── local/                                                      │
│      └── shared_prefs                                           │
└─────────────────────────────────────────────────────────────────┘
```

## 기술 스택

### Frontend (Flutter)
```yaml
dependencies:
  # Core
  flutter: sdk
  flutter_localizations: sdk
  
  # State Management
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  
  # Dependency Injection
  get_it: ^7.6.4
  injectable: ^2.3.2
  
  # Navigation
  auto_route: ^7.8.4
  
  # Network
  dio: ^5.4.0
  retrofit: ^4.0.3
  pretty_dio_logger: ^1.3.1
  
  # Backend Services
  supabase_flutter: ^2.3.0
  
  # Local Storage
  shared_preferences: ^2.2.2
  hive_flutter: ^1.1.0
  
  # UI/UX
  flutter_animate: ^4.3.0
  shimmer: ^3.0.0
  lottie: ^3.0.0
  
  # Utilities
  intl: ^0.18.1
  uuid: ^4.2.2
  url_launcher: ^6.2.2
  
dev_dependencies:
  flutter_test: sdk
  build_runner: ^2.4.7
  auto_route_generator: ^7.3.2
  injectable_generator: ^2.4.1
  retrofit_generator: ^8.0.6
  json_serializable: ^6.7.1
```

### Backend Services

#### 1. Supabase (추천)
- **장점**: 
  - PostgreSQL 기반으로 복잡한 쿼리 가능
  - 실시간 구독 기능 내장
  - Row Level Security로 보안 강화
  - Edge Functions로 서버리스 로직 구현
  - 저렴한 가격

- **구성**:
```sql
-- Users 테이블
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  preferences JSONB DEFAULT '{}',
  subscription_tier TEXT DEFAULT 'free'
);

-- Briefings 테이블
CREATE TABLE briefings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id),
  date DATE NOT NULL,
  content JSONB NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Predictions 테이블
CREATE TABLE predictions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id),
  type TEXT NOT NULL, -- 'micro', 'macro', 'strategic'
  question TEXT NOT NULL,
  user_answer JSONB,
  actual_result JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  resolved_at TIMESTAMPTZ
);

-- Reflections 테이블
CREATE TABLE reflections (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id),
  briefing_id UUID REFERENCES briefings(id),
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

#### 2. Perplexity API 구성
```dart
class PerplexityService {
  // 브리핑 생성용 - 깊이 있는 리서치
  Future<BriefingContent> generateDailyBriefing(List<String> interests) async {
    // sonar-deep-research 사용
    // 사용자 관심사 기반 심층 분석
  }
  
  // 다각적 관점 생성용
  Future<List<Perspective>> generatePerspectives(String topic) async {
    // sonar-pro 사용
    // 여러 관점의 사설/칼럼 생성
  }
  
  // 예측 검증 분석용
  Future<AnalysisResult> analyzePrediction(Prediction prediction) async {
    // sonar-reasoning-pro 사용
    // 예측 결과에 대한 심층 분석
  }
  
  // 일반 질의응답용
  Future<String> askQuestion(String question) async {
    // sonar 사용
    // 사용자 질문에 대한 답변
  }
}
```

### 클린 아키텍처 구조

```
lib/
├── main.dart
├── injection.dart
│
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   └── usecases/
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── briefing/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   │
│   ├── prediction/
│   └── reflection/
│
└── shared/
    ├── theme/
    ├── widgets/
    └── utils/
```

## 개발 우선순위

### Phase 1: MVP (2주)
1. **인증 시스템** (Supabase Auth)
2. **데일리 브리핑** (Perplexity sonar-deep-research)
3. **마이크로 예측** (기본 기능만)
4. **간단한 성찰 기록**

### Phase 2: 핵심 기능 (3주)
1. **다각적 관점 사설** (Perplexity sonar-pro)
2. **예측 검증 시스템** (sonar-reasoning-pro)
3. **성장 트래킹 대시보드**
4. **푸시 알림**

### Phase 3: 고도화 (4주)
1. **AI 기반 개인화**
2. **소셜 기능** (익명 리더보드)
3. **고급 분석 리포트**
4. **프리미엄 구독 모델**

## 개발 시 주의사항

1. **API 사용량 최적화**
   - Perplexity API 호출 캐싱
   - 배치 처리로 API 호출 최소화
   - 사용자별 일일 한도 설정

2. **오프라인 지원**
   - Hive로 로컬 캐싱
   - 오프라인 모드 UI 처리

3. **성능 최적화**
   - 이미지 레이지 로딩
   - 리스트 가상화
   - 애니메이션 최적화

4. **보안**
   - API 키는 서버사이드에서만
   - Row Level Security 활용
   - 민감한 데이터 암호화

## 개발 환경 설정

```bash
# 1. 환경 변수 설정 (.env)
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
PERPLEXITY_API_KEY=your_perplexity_api_key

# 2. 코드 생성
flutter pub run build_runner build --delete-conflicting-outputs

# 3. 실행
flutter run --dart-define-from-file=.env
```

## 참고 자료

- [Supabase Flutter 문서](https://supabase.com/docs/guides/getting-started/quickstarts/flutter)
- [Perplexity API 문서](https://docs.perplexity.ai/)
- [Flutter Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)