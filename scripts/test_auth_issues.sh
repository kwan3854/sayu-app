#!/bin/bash

# Supabase local development credentials
SUPABASE_URL="http://127.0.0.1:54321"
ANON_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0"

echo "=== Testing Authentication Issues ==="
echo

# Test 1: Create first user
echo "Test 1: Creating first user (user1@test.com)"
USER1_RESPONSE=$(curl -s -X POST \
  "${SUPABASE_URL}/auth/v1/signup" \
  -H "apikey: ${ANON_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user1@test.com",
    "password": "password123",
    "data": {"name": "User One"}
  }')

echo "$USER1_RESPONSE" | jq -r '.user.id // .error // .msg // "Unknown response"'
echo

# Test 2: Try to create duplicate user (should fail)
echo "Test 2: Attempting to create duplicate user with same email"
DUPLICATE_RESPONSE=$(curl -s -X POST \
  "${SUPABASE_URL}/auth/v1/signup" \
  -H "apikey: ${ANON_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user1@test.com",
    "password": "differentpassword",
    "data": {"name": "Duplicate User"}
  }')

echo "$DUPLICATE_RESPONSE" | jq -r '.error // .msg // "Success (This should not happen!)"'
echo

# Test 3: Create second user with different email
echo "Test 3: Creating second user (user2@test.com)"
USER2_RESPONSE=$(curl -s -X POST \
  "${SUPABASE_URL}/auth/v1/signup" \
  -H "apikey: ${ANON_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user2@test.com",
    "password": "password123",
    "data": {"name": "User Two"}
  }')

echo "$USER2_RESPONSE" | jq -r '.user.id // .error // .msg // "Unknown response"'
echo

# Test 4: Login with correct credentials
echo "Test 4: Login with user1@test.com (correct password)"
LOGIN_CORRECT=$(curl -s -X POST \
  "${SUPABASE_URL}/auth/v1/token?grant_type=password" \
  -H "apikey: ${ANON_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user1@test.com",
    "password": "password123"
  }')

if echo "$LOGIN_CORRECT" | jq -e '.access_token' > /dev/null 2>&1; then
  echo "Success: Login successful"
else
  echo "Failed: $(echo "$LOGIN_CORRECT" | jq -r '.error // .msg // "Unknown error"')"
fi
echo

# Test 5: Login with incorrect password
echo "Test 5: Login with user1@test.com (wrong password)"
LOGIN_WRONG=$(curl -s -X POST \
  "${SUPABASE_URL}/auth/v1/token?grant_type=password" \
  -H "apikey: ${ANON_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user1@test.com",
    "password": "wrongpassword"
  }')

echo "Expected failure: $(echo "$LOGIN_WRONG" | jq -r '.error // .msg // "Unknown response"')"
echo

# Test 6: Check if email confirmation is required
echo "Test 6: Checking auth configuration"
AUTH_CONFIG=$(curl -s -X GET \
  "${SUPABASE_URL}/auth/v1/settings" \
  -H "apikey: ${ANON_KEY}")

echo "Email confirmations enabled: $(echo "$AUTH_CONFIG" | jq -r '.require_email_confirmation // false')"
echo "Signup enabled: $(echo "$AUTH_CONFIG" | jq -r '.disable_signup // true | not')"
echo