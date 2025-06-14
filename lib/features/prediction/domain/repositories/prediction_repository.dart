import 'package:dartz/dartz.dart';
import '../entities/prediction_challenge.dart';

abstract class PredictionRepository {
  Future<Either<Exception, List<PredictionChallenge>>> getTodaysPredictions();
  Future<Either<Exception, void>> submitPrediction(String challengeId, String answer);
  Future<Either<Exception, Map<String, dynamic>>> analyzePredictionResult(
    String challengeId,
    String userAnswer,
    String actualResult,
  );
}