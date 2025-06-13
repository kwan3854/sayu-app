class SupabaseConfig {
  // TODO: Replace with your actual Supabase credentials
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
  
  // Auth settings
  static const Duration sessionRefreshInterval = Duration(minutes: 5);
  static const Duration connectionTimeout = Duration(seconds: 30);
}