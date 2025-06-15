#!/bin/bash

# Supabase local development credentials
SUPABASE_URL="http://127.0.0.1:54321"
ANON_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0"

# Test email and password
TEST_EMAIL="test@example.com"
TEST_PASSWORD="password123"
TEST_NAME="Test User"

echo "=== Testing Supabase Authentication Flow ==="
echo

# 1. Test signup with new user
echo "1. Testing signup with email: $TEST_EMAIL"
SIGNUP_RESPONSE=$(curl -s -X POST \
  "${SUPABASE_URL}/auth/v1/signup" \
  -H "apikey: ${ANON_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"email\": \"${TEST_EMAIL}\",
    \"password\": \"${TEST_PASSWORD}\",
    \"data\": {
      \"name\": \"${TEST_NAME}\"
    }
  }")

echo "Signup Response:"
echo "$SIGNUP_RESPONSE" | jq '.'
echo

# 2. Test duplicate signup (should fail)
echo "2. Testing duplicate signup with same email"
DUPLICATE_RESPONSE=$(curl -s -X POST \
  "${SUPABASE_URL}/auth/v1/signup" \
  -H "apikey: ${ANON_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"email\": \"${TEST_EMAIL}\",
    \"password\": \"${TEST_PASSWORD}\",
    \"data\": {
      \"name\": \"${TEST_NAME} 2\"
    }
  }")

echo "Duplicate Signup Response:"
echo "$DUPLICATE_RESPONSE" | jq '.'
echo

# 3. Test login
echo "3. Testing login with email: $TEST_EMAIL"
LOGIN_RESPONSE=$(curl -s -X POST \
  "${SUPABASE_URL}/auth/v1/token?grant_type=password" \
  -H "apikey: ${ANON_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"email\": \"${TEST_EMAIL}\",
    \"password\": \"${TEST_PASSWORD}\"
  }")

echo "Login Response:"
echo "$LOGIN_RESPONSE" | jq '.'
echo

# 4. Test login with wrong password
echo "4. Testing login with wrong password"
WRONG_LOGIN_RESPONSE=$(curl -s -X POST \
  "${SUPABASE_URL}/auth/v1/token?grant_type=password" \
  -H "apikey: ${ANON_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"email\": \"${TEST_EMAIL}\",
    \"password\": \"wrongpassword\"
  }")

echo "Wrong Password Login Response:"
echo "$WRONG_LOGIN_RESPONSE" | jq '.'
echo

# 5. Test with another email
TEST_EMAIL2="test2@example.com"
echo "5. Testing signup with different email: $TEST_EMAIL2"
SIGNUP2_RESPONSE=$(curl -s -X POST \
  "${SUPABASE_URL}/auth/v1/signup" \
  -H "apikey: ${ANON_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"email\": \"${TEST_EMAIL2}\",
    \"password\": \"${TEST_PASSWORD}\",
    \"data\": {
      \"name\": \"Test User 2\"
    }
  }")

echo "Second User Signup Response:"
echo "$SIGNUP2_RESPONSE" | jq '.'
echo