-- Auth 트리거 제거 (권한 문제 해결)
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- 대신 RLS 정책을 통해 사용자가 자신의 프로필을 생성할 수 있도록 함
ALTER TABLE profiles ALTER COLUMN username DROP NOT NULL;
ALTER TABLE profiles ALTER COLUMN username SET DEFAULT NULL;