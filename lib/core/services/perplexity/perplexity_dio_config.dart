import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class PerplexityDioConfig {
  @Named('perplexityDio')
  @lazySingleton
  Dio get perplexityDio {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.perplexity.ai',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    
    // Add interceptors
    dio.interceptors.addAll([
      _AuthInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    ]);
    
    return dio;
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // In production, get API key from secure storage or environment variable
    // For now, we'll use a placeholder
    const apiKey = String.fromEnvironment('PERPLEXITY_API_KEY', defaultValue: '');
    
    if (apiKey.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $apiKey';
    }
    
    handler.next(options);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Handle authentication error
      // Could trigger re-authentication or show error to user
    }
    handler.next(err);
  }
}