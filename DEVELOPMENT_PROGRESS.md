# 사유(Sayu) 개발 진행 상황

## 프로젝트 개요
- **프로젝트명**: 사유 (Sayu) - 마음챙김 일기 앱
- **디자인 컨셉**: 일본식 미니멀리즘 / 불교적 / 다크 테마
- **기술 스택**: Flutter, Clean Architecture, Supabase, Perplexity API

## 완료된 작업 (2025-06-14)

### Step 1: 프로젝트 구조 리팩토링 ✅
- Clean Architecture 패턴 적용
- Feature 기반 모듈 구조 구현
- 의존성 주입 설정 (get_it + injectable)
- 라우팅 시스템 구축 (auto_route)

### Step 2: Supabase 설정 및 인증 시스템 ✅
- Auth 도메인 레이어 구축
  - Entities: SayuUser
  - Repositories: AuthRepository
  - UseCases: SignIn, SignUp, SignOut
- Data 레이어 구현
  - Remote DataSource
  - Repository Implementation
  - User Model
- Presentation 레이어
  - AuthBloc (상태 관리)
  - 로그인/회원가입 화면 UI
- MVP를 위한 Mock 인증 구현

### Step 3: 데일리 브리핑 기능 (Mock 데이터) ✅
- DailyBriefing 엔티티 설계
- Mock 데이터 저장소 구현
- 브리핑 화면 UI 구현
  - 일본식 미니멀리즘 디자인
  - 날짜/인사말 표시
  - 오늘의 명언 카드
  - 오늘의 집중사항 리스트
  - 예측/성찰 프롬프트 카드

### UI/UX 개선사항
- 온보딩 화면 버튼 크기 통일 (160px)
- Glass morphism 효과 개선
- 일본식 미니멀리즘 테마 강화
- 다크 테마 색상 조정

### 기술적 개선사항
- dartz 패키지 추가 (함수형 프로그래밍)
- 모든 deprecation 경고 해결
  - withOpacity → withValues(alpha:)
  - pop() → maybePop()
  - background/onBackground 제거
- 불필요한 import 정리
- BuildContext 안전성 개선

## 현재 상태
- ✅ 온보딩 → 로그인 → 메인 화면 플로우 완성
- ✅ 브리핑 화면에서 Mock 데이터 표시
- ✅ 일본식 미니멀리즘 UI/UX 적용
- ✅ 모든 린트 경고 해결
- ✅ AI 팩트체크 기능 구현 (뉴스 상세 화면)
- ✅ 확장 가능한 배경 지식 카드 UI 구현
- ✅ 성찰 기록에서 AI 팩트체크 도우미 제거

## 완료된 추가 기능 (2025-06-14)

### AI 팩트체크 기능 ✅
- 뉴스 상세 화면에 팩트체크 섹션 추가
- 주요 주장에 대한 검증 결과 표시 (사실/대체로 사실/논란/거짓)
- 각 팩트체크에 대한 설명과 출처 제공
- 시각적 구분을 위한 색상 코딩 및 아이콘

### 확장 가능한 배경 지식 카드 ✅
- 탭하면 펼쳐지는 인터랙티브 UI
- 카테고리별 배경 지식 분류
- 여백을 활용한 깨끗한 디자인

### 성찰 기록 개선 ✅
- AI 팩트체크 도우미 기능 제거
- 순수한 성찰 기록에 집중

## 다음 단계 (TODO)
### Perplexity API 실제 연동
- API 키 발급 및 테스트
- 응답 파싱 로직 구현
- 에러 처리 및 폴백 메커니즘
- API 사용량 모니터링

### 사용자 데이터 영속성
- Supabase 데이터베이스 스키마 구현
- 사용자 성찰 기록 저장
- 예측 결과 추적 및 통계

## 파일 구조
```
lib/
├── core/
│   ├── config/         # 설정 파일
│   ├── error/          # 에러 처리
│   ├── router/         # 라우팅
│   └── usecases/       # UseCase 인터페이스
├── features/
│   ├── auth/           # 인증 기능
│   ├── briefing/       # 브리핑 기능
│   ├── main/           # 메인 화면
│   ├── prediction/     # 예측 기능
│   ├── reflection/     # 성찰 기능
│   └── profile/        # 프로필 기능
├── shared/
│   ├── theme/          # 테마 설정
│   └── widgets/        # 공통 위젯
├── injection.dart      # DI 설정
└── main.dart          # 앱 진입점
```

## 주요 커스텀 위젯
- **EnsoCircle**: 애니메이션이 적용된 선(禅) 원 위젯
- **PremiumGlassContainer**: 고급 글래스모피즘 효과 컨테이너
- **ZenContainer**: 미니멀한 젠 스타일 컨테이너
- **ZenButton**: 커스텀 디자인 버튼

## 색상 팔레트
- Background: #0F1114 (깊은 검정)
- Primary: #4ECDC4 (청록색)
- Secondary: #9B88B4 (보라색)
- Accent: #E8B4A6 (연한 살구색)
- Surface: #1A1D21 (어두운 회색)

## 참고사항
- Supabase 실제 연동을 위해서는 프로젝트 생성 후 credentials 설정 필요
- Perplexity API 키 설정 필요
- 현재는 MVP 버전으로 Mock 데이터 사용 중