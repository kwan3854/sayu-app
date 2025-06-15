import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppConfig {
  // API Keys
  String get perplexityApiKey => dotenv.env['PERPLEXITY_API_KEY'] ?? '';
  
  String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  
  String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  
  // Feature Flags
  bool get useMockData {
    final envValue = dotenv.env['USE_MOCK_DATA'];
    return envValue?.toLowerCase() == 'true';
  }
  
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