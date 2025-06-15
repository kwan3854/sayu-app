-- Check for duplicate emails in auth.users
SELECT 
    email,
    COUNT(*) as count,
    STRING_AGG(id::text, ', ') as user_ids,
    STRING_AGG(created_at::text, ', ') as created_dates
FROM auth.users
GROUP BY email
HAVING COUNT(*) > 1
ORDER BY count DESC;

-- Show all users
SELECT 
    id,
    email,
    created_at,
    last_sign_in_at,
    raw_user_meta_data
FROM auth.users
ORDER BY created_at DESC;

-- Check if email uniqueness constraint exists
SELECT 
    con.conname AS constraint_name,
    con.contype AS constraint_type,
    pg_get_constraintdef(con.oid) AS constraint_definition
FROM pg_constraint con
JOIN pg_namespace nsp ON nsp.oid = con.connamespace
JOIN pg_class cls ON cls.oid = con.conrelid
WHERE nsp.nspname = 'auth' 
AND cls.relname = 'users'
AND con.contype IN ('u', 'p');