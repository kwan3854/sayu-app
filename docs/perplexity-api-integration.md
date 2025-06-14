# Perplexity API 통합 가이드

## 개요
사유(Sayu) 앱은 Perplexity API를 사용하여 다음 기능을 제공합니다:
- 데일리 브리핑 생성
- 다각적 관점 생성
- 예측 결과 분석
- 사용자 질문 답변

## 설정 방법

### 1. API 키 발급
1. [Perplexity API](https://docs.perplexity.ai/) 웹사이트에서 계정 생성
2. API 키 발급
3. 프로젝트 루트에 `.env` 파일 생성

### 2. 환경 변수 설정
```bash
# .env 파일 생성
cp .env.example .env

# .env 파일 편집
PERPLEXITY_API_KEY=your_actual_api_key_here
```

### 3. 앱 실행
```bash
# 환경 변수와 함께 실행
flutter run --dart-define-from-file=.env
```

## API 사용 현황

### 1. 브리핑 생성 (BriefingService)
- **엔드포인트**: `/chat/completions`
- **모델**: `sonar-pro`
- **용도**: 사용자 관심사 기반 일일 브리핑 생성
- **호출 빈도**: 사용자당 1일 1회

### 2. 관점 생성 (PerspectiveService)
- **엔드포인트**: `/chat/completions`
- **모델**: `sonar-pro`
- **용도**: 이슈별 3-4개의 다양한 관점 생성
- **호출 빈도**: 이슈당 1회 (캐싱)

### 3. 예측 분석 (PredictionService)
- **엔드포인트**: `/chat/completions`
- **모델**: `sonar`
- **용도**: 예측 결과에 대한 분석 제공
- **호출 빈도**: 예측 결과 공개 시

## 모델 선택 가이드

### sonar (기본)
- 일반적인 질문/답변
- 빠른 응답 필요 시
- 비용 효율적

### sonar-pro
- 심층 분석 필요 시
- 브리핑 생성
- 다각적 관점 생성

### sonar-reasoning-pro
- 복잡한 추론 필요 시
- 예측 결과 심층 분석
- (현재 미사용)

## 비용 최적화 전략

### 1. 캐싱
- 브리핑: 24시간 캐싱
- 관점: 7일 캐싱
- 예측 분석: 영구 저장

### 2. 배치 처리
- 여러 사용자의 브리핑을 모아서 처리
- 비슷한 관심사 그룹화

### 3. 사용량 제한
- 사용자당 일일 API 호출 제한: 100회
- 무료 사용자: 기본 기능만
- 프리미엄 사용자: 전체 기능

## 에러 처리

### 1. API 키 누락
```dart
if (apiKey.isEmpty) {
  // Mock 데이터로 폴백
  return MockDataService.getBriefing();
}
```

### 2. 할당량 초과
```dart
catch (e) {
  if (e.statusCode == 429) {
    // 사용자에게 제한 알림
    showRateLimitDialog();
  }
}
```

### 3. 네트워크 오류
- 자동 재시도 (최대 3회)
- 오프라인 모드 전환

## 개발 모드

### Mock 데이터 사용
```bash
# .env 파일
USE_MOCK_DATA=true
```

### 디버그 로깅
```bash
# .env 파일
DEBUG_MODE=true
```

## 프로덕션 체크리스트

- [ ] API 키 서버 사이드 보관
- [ ] 사용량 모니터링 설정
- [ ] 에러 로깅 시스템 구축
- [ ] 캐싱 레이어 구현
- [ ] 사용자별 할당량 관리

## 참고 자료
- [Perplexity API 문서](https://docs.perplexity.ai/)
- [API 가격 정책](https://www.perplexity.ai/pricing)
- [모델 비교](https://docs.perplexity.ai/models)