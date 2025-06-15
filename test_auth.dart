import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // Initialize Supabase
  await Supabase.initialize(
    url: 'http://127.0.0.1:54321',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0',
  );

  final supabase = Supabase.instance.client;

  // Test 1: Sign up with new email
  print('Test 1: Sign up with new email');
  try {
    final response = await supabase.auth.signUp(
      email: 'test@example.com',
      password: 'password123',
      data: {'name': 'Test User'},
    );
    print('Success: User created with ID ${response.user?.id}');
  } on AuthException catch (e) {
    print('AuthException: ${e.message} (${e.statusCode})');
  } catch (e) {
    print('Other error: $e');
  }

  // Test 2: Try duplicate signup
  print('\nTest 2: Try duplicate signup');
  try {
    final response = await supabase.auth.signUp(
      email: 'test@example.com',
      password: 'password123',
      data: {'name': 'Test User 2'},
    );
    print('Success: User created with ID ${response.user?.id}');
  } on AuthException catch (e) {
    print('AuthException: ${e.message} (${e.statusCode})');
  } catch (e) {
    print('Other error: $e');
  }

  // Test 3: Login with correct password
  print('\nTest 3: Login with correct password');
  try {
    final response = await supabase.auth.signInWithPassword(
      email: 'test@example.com',
      password: 'password123',
    );
    print('Success: Logged in with session ${response.session?.accessToken?.substring(0, 20)}...');
  } on AuthException catch (e) {
    print('AuthException: ${e.message} (${e.statusCode})');
  } catch (e) {
    print('Other error: $e');
  }

  // Test 4: Login with wrong password
  print('\nTest 4: Login with wrong password');
  try {
    final response = await supabase.auth.signInWithPassword(
      email: 'test@example.com',
      password: 'wrongpassword',
    );
    print('Success: Logged in with session ${response.session?.accessToken?.substring(0, 20)}...');
  } on AuthException catch (e) {
    print('AuthException: ${e.message} (${e.statusCode})');
  } catch (e) {
    print('Other error: $e');
  }
}