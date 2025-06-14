import 'package:injectable/injectable.dart';

@lazySingleton
class AppConfig {
  // API Keys
  String get perplexityApiKey => const String.fromEnvironment(
    'PERPLEXITY_API_KEY',
    defaultValue: '',
  );
  
  String get supabaseUrl => const String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );
  
  String get supabaseAnonKey => const String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: '',
  );
  
  // Feature Flags
  bool get useMockData => const bool.fromEnvironment(
    'USE_MOCK_DATA',
    defaultValue: true,
  );
  
  bool get debugMode => const bool.fromEnvironment(
    'DEBUG_MODE',
    defaultValue: true,
  );
  
  // API Configuration
  int get apiTimeoutSeconds => 30;
  int get maxRetries => 3;
  
  // Cache Configuration
  Duration get cacheExpiration => const Duration(hours: 1);
  
  // User Limits
  int get dailyApiCallLimit => 100;
  int get maxPredictionsPerDay => 10;
}