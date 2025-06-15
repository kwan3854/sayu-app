import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/daily_briefing.dart';

abstract class BriefingRepository {
  Future<Either<Failure, DailyBriefing?>> getTodaysBriefing(String countryCode, String? region);
  Future<Either<Failure, void>> generateDailyBriefing(String countryCode, String? region);
}