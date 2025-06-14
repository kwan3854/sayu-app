import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PerplexityApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://api.perplexity.ai';
  
  PerplexityApiService(@Named('perplexityDio') this._dio);
  
  /// Generate daily briefing based on user interests
  Future<Map<String, dynamic>> generateDailyBriefing({
    required List<String> interests,
    required String region,
  }) async {
    try {
      final prompt = _buildBriefingPrompt(interests, region);
      
      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': 'sonar-pro',
          'messages': [
            {
              'role': 'system',
              'content': 'You are a news analyst providing balanced, multi-perspective briefings on current affairs in Korean.',
            },
            {
              'role': 'user',
              'content': prompt,
            },
          ],
          'temperature': 0.3,
          'max_tokens': 2000,
        },
      );
      
      return response.data;
    } catch (e) {
      throw Exception('Failed to generate daily briefing: $e');
    }
  }
  
  /// Generate multiple perspectives for a given issue
  Future<List<Map<String, dynamic>>> generatePerspectives({
    required String issueTitle,
    required String issueSummary,
  }) async {
    try {
      final prompt = _buildPerspectivesPrompt(issueTitle, issueSummary);
      
      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': 'sonar-pro',
          'messages': [
            {
              'role': 'system',
              'content': 'You are an expert analyst providing diverse perspectives on current issues in Korean.',
            },
            {
              'role': 'user',
              'content': prompt,
            },
          ],
          'temperature': 0.5,
          'max_tokens': 3000,
        },
      );
      
      return _parsePerspectives(response.data);
    } catch (e) {
      throw Exception('Failed to generate perspectives: $e');
    }
  }
  
  /// Analyze prediction results with reasoning
  Future<Map<String, dynamic>> analyzePrediction({
    required String question,
    required String userAnswer,
    required String actualResult,
  }) async {
    try {
      final prompt = _buildPredictionAnalysisPrompt(question, userAnswer, actualResult);
      
      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': 'sonar',
          'messages': [
            {
              'role': 'system',
              'content': 'You are an analyst explaining prediction outcomes in Korean.',
            },
            {
              'role': 'user',
              'content': prompt,
            },
          ],
          'temperature': 0.3,
          'max_tokens': 1000,
        },
      );
      
      return response.data;
    } catch (e) {
      throw Exception('Failed to analyze prediction: $e');
    }
  }
  
  /// General Q&A for user questions
  Future<String> askQuestion(String question) async {
    try {
      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': 'sonar',
          'messages': [
            {
              'role': 'user',
              'content': question,
            },
          ],
          'temperature': 0.7,
          'max_tokens': 500,
        },
      );
      
      return response.data['choices'][0]['message']['content'];
    } catch (e) {
      throw Exception('Failed to answer question: $e');
    }
  }
  
  String _buildBriefingPrompt(List<String> interests, String region) {
    return '''
한국의 주요 시사 이슈를 다음 조건에 맞춰 브리핑해주세요:

관심 분야: ${interests.join(', ')}
지역: $region

요구사항:
1. 오늘의 주요 이슈 2-3개를 선정
2. 각 이슈에 대해:
   - 헤드라인 (30자 이내)
   - 핵심 요약 (100자 이내)
   - 중요도 점수 (1-10)
   - 관련 카테고리
3. 다양한 관점이 존재하는 논쟁적 이슈 우선 선정
4. 사실 기반의 객관적 정보 제공

JSON 형식으로 응답해주세요.
''';
  }
  
  String _buildPerspectivesPrompt(String issueTitle, String issueSummary) {
    return '''
다음 이슈에 대해 서로 다른 3-4개의 관점을 제시해주세요:

이슈: $issueTitle
요약: $issueSummary

각 관점별로:
1. 전문가 정보 (이름, 직책)
2. 핵심 주장 (제목)
3. 상세 논거 (300-400자)
4. 입장 (긍정적/부정적/중립적)
5. 생각해볼 질문 2-3개

다양한 이해관계자의 입장을 균형있게 포함해주세요.
JSON 형식으로 응답해주세요.
''';
  }
  
  String _buildPredictionAnalysisPrompt(String question, String userAnswer, String actualResult) {
    return '''
다음 예측에 대한 분석을 제공해주세요:

질문: $question
사용자 예측: $userAnswer
실제 결과: $actualResult

분석 내용:
1. 결과 요약
2. 주요 영향 요인
3. 예측과 실제의 차이점
4. 배울 수 있는 교훈
5. 향후 전망

200-300자로 요약해주세요.
''';
  }
  
  List<Map<String, dynamic>> _parsePerspectives(Map<String, dynamic> response) {
    try {
      final content = response['choices'][0]['message']['content'];
      // Parse JSON response and extract perspectives
      // This is a simplified version - actual implementation would need proper JSON parsing
      return [];
    } catch (e) {
      throw Exception('Failed to parse perspectives: $e');
    }
  }
}