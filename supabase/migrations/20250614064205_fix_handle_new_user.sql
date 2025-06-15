-- handle_new_user 함수 수정
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO profiles (id, username, display_name, created_at, updated_at)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1)),
    COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1)),
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