-- Check registered users
SELECT id, email, created_at, last_sign_in_at 
FROM auth.users 
ORDER BY created_at DESC;

-- Check user profiles
SELECT * FROM public.profiles;