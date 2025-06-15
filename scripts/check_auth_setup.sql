-- Check if profiles table exists
SELECT EXISTS (
   SELECT FROM information_schema.tables 
   WHERE  table_schema = 'public'
   AND    table_name   = 'profiles'
);

-- Check handle_new_user function
SELECT EXISTS (
   SELECT FROM pg_proc
   WHERE  proname = 'handle_new_user'
);

-- Check auth trigger
SELECT EXISTS (
   SELECT FROM pg_trigger
   WHERE  tgname = 'on_auth_user_created'
);