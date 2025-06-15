import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/daily_briefing.dart';
import '../repositories/briefing_repository.dart';

@lazySingleton
class GetTodaysBriefing implements UseCase<DailyBriefing?, BriefingParams> {
  final BriefingRepository repository;

  GetTodaysBriefing(this.repository);

  @override
  Future<Either<Failure, DailyBriefing?>> call(BriefingParams params) async {
    return await repository.getTodaysBriefing(params.countryCode, params.region);
  }
}

class BriefingParams {
  final String countryCode;
  final String? region;

  const BriefingParams({
    required this.countryCode,
    this.region,
  });
}