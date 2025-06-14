# 인증 테스트 가이드

## 회원가입/로그인이 이제 실제로 작동합니다!

### 테스트 방법:

1. **앱 재시작** (Hot Restart - 'R' 키)
   ```bash
   flutter run
   ```

2. **회원가입 테스트**
   - 온보딩 화면에서 "시작하기" 클릭
   - 로그인 화면에서 "회원가입" 클릭
   - 테스트 정보 입력:
     - 이름: 테스트
     - 이메일: test@example.com
     - 비밀번호: test123 (6자 이상)

3. **데이터 확인**
   - 브라우저에서 http://127.0.0.1:54323 접속
   - Authentication 탭에서 가입한 사용자 확인
   - Table Editor > profiles 테이블에서 프로필 데이터 확인

### 수정된 내용:
- ✅ register_screen.dart: Mock 회원가입 → 실제 Supabase 회원가입
- ✅ login_screen.dart: 이미 실제 인증 사용 중
- ✅ 이메일 확인 비활성화 (바로 사용 가능)

### 주의사항:
- 로컬 Supabase를 실행 중이어야 합니다
- 같은 이메일로는 한 번만 가입 가능합니다
- 비밀번호는 최소 6자 이상이어야 합니다

### 문제 해결:
- 회원가입이 안 되면 Supabase가 실행 중인지 확인: `supabase status`
- 이미 가입한 이메일이면 로그인을 시도하세요
- 에러가 발생하면 화면에 빨간색 스낵바로 표시됩니다