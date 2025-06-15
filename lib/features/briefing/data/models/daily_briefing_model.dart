import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_briefing_model.freezed.dart';
part 'daily_briefing_model.g.dart';

@freezed
class DailyBriefingModel with _$DailyBriefingModel {
  const factory DailyBriefingModel({
    required String id,
    required String countryCode,
    String? region,
    required DateTime briefingDate,
    required List<BriefingTopicModel> topics,
    required List<NewsItemModel> newsItems,
    required DateTime createdAt,
  }) = _DailyBriefingModel;

  factory DailyBriefingModel.fromJson(Map<String, dynamic> json) =>
      _$DailyBriefingModelFromJson(json);
}

@freezed
class BriefingTopicModel with _$BriefingTopicModel {
  const factory BriefingTopicModel({
    required String title,
    required String category,
    required List<String> keywords,
  }) = _BriefingTopicModel;

  factory BriefingTopicModel.fromJson(Map<String, dynamic> json) =>
      _$BriefingTopicModelFromJson(json);
}

@freezed
class NewsItemModel with _$NewsItemModel {
  const factory NewsItemModel({
    required String id,
    required String briefingId,
    required int position,
    required String title,
    required String summary,
    required String mainContent,
    required List<KeyTermModel> keyTerms,
    String? backgroundContext,
    required FactCheckModel factCheck,
    required List<SourceModel> sources,
    required List<PerspectiveModel> perspectives,
    String? perplexitySearchId,
    required DateTime createdAt,
  }) = _NewsItemModel;

  factory NewsItemModel.fromJson(Map<String, dynamic> json) =>
      _$NewsItemModelFromJson(json);
}

@freezed
class KeyTermModel with _$KeyTermModel {
  const factory KeyTermModel({
    required String term,
    required String definition,
  }) = _KeyTermModel;

  factory KeyTermModel.fromJson(Map<String, dynamic> json) =>
      _$KeyTermModelFromJson(json);
}

@freezed
class FactCheckModel with _$FactCheckModel {
  const factory FactCheckModel({
    required String status,
    required String details,
  }) = _FactCheckModel;

  factory FactCheckModel.fromJson(Map<String, dynamic> json) =>
      _$FactCheckModelFromJson(json);
}

@freezed
class SourceModel with _$SourceModel {
  const factory SourceModel({
    required String title,
    required String url,
  }) = _SourceModel;

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      _$SourceModelFromJson(json);
}

@freezed
class PerspectiveModel with _$PerspectiveModel {
  const factory PerspectiveModel({
    required String expert,
    required String viewpoint,
  }) = _PerspectiveModel;

  factory PerspectiveModel.fromJson(Map<String, dynamic> json) =>
      _$PerspectiveModelFromJson(json);
}