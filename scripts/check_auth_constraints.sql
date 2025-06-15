-- Check constraints on auth.users table
SELECT 
    con.conname AS constraint_name,
    con.contype AS constraint_type,
    pg_get_constraintdef(con.oid) AS constraint_definition
FROM pg_constraint con
JOIN pg_namespace nsp ON nsp.oid = con.connamespace
JOIN pg_class cls ON cls.oid = con.conrelid
WHERE nsp.nspname = 'auth' 
AND cls.relname = 'users'
ORDER BY con.conname;

-- Check constraints on profiles table
SELECT 
    con.conname AS constraint_name,
    con.contype AS constraint_type,
    pg_get_constraintdef(con.oid) AS constraint_definition
FROM pg_constraint con
JOIN pg_namespace nsp ON nsp.oid = con.connamespace
JOIN pg_class cls ON cls.oid = con.conrelid
WHERE nsp.nspname = 'public' 
AND cls.relname = 'profiles'
ORDER BY con.conname;

-- Check indexes on auth.users
SELECT 
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'auth'
AND tablename = 'users';

-- Check if there are any duplicate emails in auth.users
SELECT 
    email,
    COUNT(*) as count
FROM auth.users
GROUP BY email
HAVING COUNT(*) > 1;