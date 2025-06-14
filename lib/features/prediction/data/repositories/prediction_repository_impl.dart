import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/services/perplexity/perplexity_api_service.dart';
import '../../domain/entities/prediction_challenge.dart';
import '../../domain/repositories/prediction_repository.dart';
import 'prediction_repository_mock.dart';

@LazySingleton(as: PredictionRepository)
class PredictionRepositoryImpl implements PredictionRepository {
  final PerplexityApiService _perplexityService;
  final bool _useMockData = true; // 개발 중에는 mock 데이터 사용
  
  PredictionRepositoryImpl(this._perplexityService);
  
  @override
  Future<Either<Exception, List<PredictionChallenge>>> getTodaysPredictions() async {
    try {
      if (_useMockData) {
        final predictions = await PredictionRepositoryMock.getTodaysPredictions();
        return Right(predictions);
      }
      
      // Production: 실제 예측 문제는 서버에서 관리
      throw UnimplementedError('Production implementation pending');
    } catch (e) {
      return Left(Exception('Failed to fetch predictions: $e'));
    }
  }
  
  @override
  Future<Either<Exception, void>> submitPrediction(String challengeId, String answer) async {
    try {
      if (_useMockData) {
        await PredictionRepositoryMock.submitPrediction(challengeId, answer);
        return const Right(null);
      }
      
      // Production: 서버에 예측 제출
      throw UnimplementedError('Production implementation pending');
    } catch (e) {
      return Left(Exception('Failed to submit prediction: $e'));
    }
  }
  
  @override
  Future<Either<Exception, Map<String, dynamic>>> analyzePredictionResult(
    String challengeId,
    String userAnswer,
    String actualResult,
  ) async {
    try {
      // Perplexity API를 사용하여 예측 결과 분석
      final analysis = await _perplexityService.analyzePrediction(
        question: challengeId, // TODO: 실제 질문 내용 가져오기
        userAnswer: userAnswer,
        actualResult: actualResult,
      );
      
      return Right(analysis);
    } catch (e) {
      return Left(Exception('Failed to analyze prediction: $e'));
    }
  }
}