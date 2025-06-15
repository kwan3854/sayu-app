import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/daily_briefing.dart';
import '../../domain/repositories/briefing_repository.dart';
import '../datasources/briefing_remote_datasource.dart';
import '../models/daily_briefing_model.dart';

@LazySingleton(as: BriefingRepository)
class BriefingRepositoryImpl implements BriefingRepository {
  final BriefingRemoteDataSource _remoteDataSource;

  BriefingRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, DailyBriefing?>> getTodaysBriefing(
    String countryCode,
    String? region,
  ) async {
    try {
      final briefingModel = await _remoteDataSource.getTodaysBriefing(countryCode, region);
      
      if (briefingModel == null) {
        return const Right(null);
      }

      final briefing = _mapModelToEntity(briefingModel);
      return Right(briefing);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> generateDailyBriefing(
    String countryCode,
    String? region,
  ) async {
    try {
      await _remoteDataSource.generateDailyBriefing(countryCode, region);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  DailyBriefing _mapModelToEntity(DailyBriefingModel model) {
    return DailyBriefing(
      id: model.id,
      countryCode: model.countryCode,
      region: model.region,
      briefingDate: model.briefingDate,
      topics: model.topics.map(_mapTopicToEntity).toList(),
      newsItems: model.newsItems.map(_mapNewsItemToEntity).toList(),
      createdAt: model.createdAt,
    );
  }

  BriefingTopic _mapTopicToEntity(BriefingTopicModel model) {
    return BriefingTopic(
      title: model.title,
      category: model.category,
      keywords: model.keywords,
    );
  }

  NewsItem _mapNewsItemToEntity(NewsItemModel model) {
    return NewsItem(
      id: model.id,
      briefingId: model.briefingId,
      position: model.position,
      title: model.title,
      summary: model.summary,
      mainContent: model.mainContent,
      keyTerms: model.keyTerms
          .map((kt) => KeyTerm(term: kt.term, definition: kt.definition))
          .toList(),
      backgroundContext: model.backgroundContext,
      factCheck: FactCheck(
        status: model.factCheck.status,
        details: model.factCheck.details,
      ),
      sources: model.sources
          .map((s) => NewsSource(title: s.title, url: s.url))
          .toList(),
      perspectives: model.perspectives
          .map((p) => NewsPerspective(expert: p.expert, viewpoint: p.viewpoint))
          .toList(),
      perplexitySearchId: model.perplexitySearchId,
      createdAt: model.createdAt,
    );
  }
}