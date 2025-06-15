-- 트리거 제거 (이전 마이그레이션에서 이미 제거됨)

-- auth 스키마에 대한 권한 부여
GRANT USAGE ON SCHEMA auth TO postgres, anon, authenticated, service_role;

-- 프로필 생성을 위한 RLS 정책 수정
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- 사용자가 자신의 프로필을 생성할 수 있도록 허용
CREATE POLICY "Users can create their own profile" ON profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- 사용자가 자신의 프로필을 조회할 수 있도록 허용
CREATE POLICY "Users can view their own profile" ON profiles
  FOR SELECT USING (auth.uid() = id);

-- 사용자가 자신의 프로필을 업데이트할 수 있도록 허용
CREATE POLICY "Users can update their own profile" ON profiles
  FOR UPDATE USING (auth.uid() = id);

-- user_stats 테이블에도 동일한 정책 적용
ALTER TABLE user_stats ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can create their own stats" ON user_stats
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can view their own stats" ON user_stats
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own stats" ON user_stats
  FOR UPDATE USING (auth.uid() = user_id);