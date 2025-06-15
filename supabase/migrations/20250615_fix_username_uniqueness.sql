-- Fix the handle_new_user function to ensure unique usernames
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
DECLARE
  base_username TEXT;
  final_username TEXT;
  counter INTEGER := 0;
BEGIN
  -- Get base username from name metadata or email prefix
  base_username := COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1));
  final_username := base_username;
  
  -- Check if username exists and add suffix if needed
  WHILE EXISTS (SELECT 1 FROM public.profiles WHERE username = final_username) LOOP
    counter := counter + 1;
    final_username := base_username || counter::text;
  END LOOP;
  
  -- Insert profile with unique username
  INSERT INTO public.profiles (id, username, display_name, created_at, updated_at)
  VALUES (
    NEW.id,
    final_username,
    COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1)),
    NOW(),
    NOW()
  );
  
  -- Insert user stats
  INSERT INTO public.user_stats (user_id, created_at, updated_at)
  VALUES (
    NEW.id,
    NOW(),
    NOW()
  );
  
  RETURN NEW;
EXCEPTION
  WHEN OTHERS THEN
    -- Log the error but don't fail the user creation
    RAISE LOG 'Error in handle_new_user for user %: %', NEW.id, SQLERRM;
    -- Still try to create minimal records
    BEGIN
      -- Try with UUID suffix to ensure uniqueness
      INSERT INTO public.profiles (id, username, display_name, created_at, updated_at)
      VALUES (
        NEW.id,
        split_part(NEW.email, '@', 1) || '_' || substring(NEW.id::text, 1, 8),
        COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1)),
        NOW(),
        NOW()
      );
      
      INSERT INTO public.user_stats (user_id, created_at, updated_at)
      VALUES (
        NEW.id,
        NOW(),
        NOW()
      );
    EXCEPTION
      WHEN OTHERS THEN
        RAISE LOG 'Failed to create profile for user %: %', NEW.id, SQLERRM;
    END;
    RETURN NEW;
END;
$$;

-- Note: Index on auth.users(email) would improve performance but requires superuser permissions