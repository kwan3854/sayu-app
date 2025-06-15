import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> signInWithEmail(String email, String password);
  Future<AuthResponse> signUpWithEmail(String email, String password, String name);
  Future<AuthResponse> signInWithGoogle();
  Future<AuthResponse> signInWithApple();
  Future<void> signOut();
  Stream<AuthState> get authStateChanges;
  User? get currentUser;
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;

  AuthRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    final response = await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  }

  @override
  Future<AuthResponse> signUpWithEmail(String email, String password, String name) async {
    final response = await _supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
    return response;
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  @override
  Future<AuthResponse> signInWithGoogle() async {
    final response = await _supabaseClient.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.sayu://login-callback/',
      scopes: 'email profile',
    );
    if (!response) {
      throw AuthException('OAuth sign in was cancelled or failed');
    }
    // Wait for auth state to update
    await Future.delayed(const Duration(seconds: 1));
    final session = _supabaseClient.auth.currentSession;
    if (session == null) {
      throw AuthException('No session after OAuth sign in');
    }
    return AuthResponse(session: session, user: session.user);
  }

  @override
  Future<AuthResponse> signInWithApple() async {
    final response = await _supabaseClient.auth.signInWithOAuth(
      OAuthProvider.apple,
      redirectTo: 'io.supabase.sayu://login-callback/',
      scopes: 'email name',
    );
    if (!response) {
      throw AuthException('OAuth sign in was cancelled or failed');
    }
    // Wait for auth state to update
    await Future.delayed(const Duration(seconds: 1));
    final session = _supabaseClient.auth.currentSession;
    if (session == null) {
      throw AuthException('No session after OAuth sign in');
    }
    return AuthResponse(session: session, user: session.user);
  }

  @override
  Stream<AuthState> get authStateChanges => _supabaseClient.auth.onAuthStateChange;

  @override
  User? get currentUser => _supabaseClient.auth.currentUser;
}