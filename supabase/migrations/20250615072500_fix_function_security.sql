-- Fix Function Search Path Mutable security issues

-- 1. Fix handle_new_user function
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER 
SET search_path = public
AS $$
DECLARE
  base_username text;
  final_username text;
  counter int := 1;
BEGIN
  -- Extract base username from email or metadata
  base_username := COALESCE(
    NEW.raw_user_meta_data->>'name',
    split_part(NEW.email, '@', 1)
  );
  
  -- Ensure username is unique
  final_username := base_username;
  WHILE EXISTS (SELECT 1 FROM public.profiles WHERE username = final_username) LOOP
    final_username := base_username || counter::text;
    counter := counter + 1;
  END LOOP;
  
  -- Create profile
  INSERT INTO public.profiles (id, username, display_name, created_at, updated_at)
  VALUES (
    NEW.id,
    final_username,
    COALESCE(NEW.raw_user_meta_data->>'name', base_username),
    NOW(),
    NOW()
  );
  
  -- Create user stats
  INSERT INTO public.user_stats (user_id, created_at, updated_at)
  VALUES (
    NEW.id,
    NOW(),
    NOW()
  );
  
  RETURN NEW;
EXCEPTION
  WHEN OTHERS THEN
    RAISE LOG 'Error in handle_new_user: %', SQLERRM;
    RETURN NEW;
END;
$$;

-- 2. Fix update_updated_at_column function
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER
LANGUAGE plpgsql
SET search_path = public
AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;

-- 3. Fix update_user_stats_on_new_prediction function
CREATE OR REPLACE FUNCTION public.update_user_stats_on_new_prediction()
RETURNS TRIGGER
LANGUAGE plpgsql
SET search_path = public
AS $$
BEGIN
  UPDATE public.user_stats
  SET 
    total_predictions = total_predictions + 1,
    active_predictions = active_predictions + 1,
    updated_at = NOW()
  WHERE user_id = NEW.user_id;
  
  RETURN NEW;
END;
$$;

-- 4. Fix update_user_stats_on_prediction_result function
CREATE OR REPLACE FUNCTION public.update_user_stats_on_prediction_result()
RETURNS TRIGGER
LANGUAGE plpgsql
SET search_path = public
AS $$
BEGIN
  -- 예측이 처음 완료될 때만 업데이트
  IF OLD.outcome IS NULL AND NEW.outcome IS NOT NULL THEN
    UPDATE public.user_stats
    SET 
      active_predictions = GREATEST(0, active_predictions - 1),
      correct_predictions = CASE 
        WHEN NEW.outcome = TRUE THEN correct_predictions + 1 
        ELSE correct_predictions 
      END,
      updated_at = NOW()
    WHERE user_id = NEW.user_id;
  END IF;
  
  RETURN NEW;
END;
$$;

-- 5. Fix update_user_stats_on_reflection function
CREATE OR REPLACE FUNCTION public.update_user_stats_on_reflection()
RETURNS TRIGGER
LANGUAGE plpgsql
SET search_path = public
AS $$
BEGIN
  UPDATE public.user_stats
  SET 
    total_reflections = total_reflections + 1,
    updated_at = NOW()
  WHERE user_id = NEW.user_id;
  
  RETURN NEW;
END;
$$;

-- Re-create triggers to ensure they use the updated functions
-- (트리거는 이미 존재하므로 함수만 업데이트하면 됨)