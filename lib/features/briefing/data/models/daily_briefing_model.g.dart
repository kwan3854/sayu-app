// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_briefing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyBriefingModelImpl _$$DailyBriefingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyBriefingModelImpl(
      id: json['id'] as String,
      countryCode: json['countryCode'] as String,
      region: json['region'] as String?,
      briefingDate: DateTime.parse(json['briefingDate'] as String),
      topics: (json['topics'] as List<dynamic>)
          .map((e) => BriefingTopicModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      newsItems: (json['newsItems'] as List<dynamic>)
          .map((e) => NewsItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$DailyBriefingModelImplToJson(
        _$DailyBriefingModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countryCode': instance.countryCode,
      'region': instance.region,
      'briefingDate': instance.briefingDate.toIso8601String(),
      'topics': instance.topics,
      'newsItems': instance.newsItems,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$BriefingTopicModelImpl _$$BriefingTopicModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BriefingTopicModelImpl(
      title: json['title'] as String,
      category: json['category'] as String,
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$BriefingTopicModelImplToJson(
        _$BriefingTopicModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'category': instance.category,
      'keywords': instance.keywords,
    };

_$NewsItemModelImpl _$$NewsItemModelImplFromJson(Map<String, dynamic> json) =>
    _$NewsItemModelImpl(
      id: json['id'] as String,
      briefingId: json['briefingId'] as String,
      position: (json['position'] as num).toInt(),
      title: json['title'] as String,
      summary: json['summary'] as String,
      mainContent: json['mainContent'] as String,
      keyTerms: (json['keyTerms'] as List<dynamic>)
          .map((e) => KeyTermModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      backgroundContext: json['backgroundContext'] as String?,
      factCheck:
          FactCheckModel.fromJson(json['factCheck'] as Map<String, dynamic>),
      sources: (json['sources'] as List<dynamic>)
          .map((e) => SourceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      perspectives: (json['perspectives'] as List<dynamic>)
          .map((e) => PerspectiveModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      perplexitySearchId: json['perplexitySearchId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$NewsItemModelImplToJson(_$NewsItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'briefingId': instance.briefingId,
      'position': instance.position,
      'title': instance.title,
      'summary': instance.summary,
      'mainContent': instance.mainContent,
      'keyTerms': instance.keyTerms,
      'backgroundContext': instance.backgroundContext,
      'factCheck': instance.factCheck,
      'sources': instance.sources,
      'perspectives': instance.perspectives,
      'perplexitySearchId': instance.perplexitySearchId,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$KeyTermModelImpl _$$KeyTermModelImplFromJson(Map<String, dynamic> json) =>
    _$KeyTermModelImpl(
      term: json['term'] as String,
      definition: json['definition'] as String,
    );

Map<String, dynamic> _$$KeyTermModelImplToJson(_$KeyTermModelImpl instance) =>
    <String, dynamic>{
      'term': instance.term,
      'definition': instance.definition,
    };

_$FactCheckModelImpl _$$FactCheckModelImplFromJson(Map<String, dynamic> json) =>
    _$FactCheckModelImpl(
      status: json['status'] as String,
      details: json['details'] as String,
    );

Map<String, dynamic> _$$FactCheckModelImplToJson(
        _$FactCheckModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'details': instance.details,
    };

_$SourceModelImpl _$$SourceModelImplFromJson(Map<String, dynamic> json) =>
    _$SourceModelImpl(
      title: json['title'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$SourceModelImplToJson(_$SourceModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
    };

_$PerspectiveModelImpl _$$PerspectiveModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PerspectiveModelImpl(
      expert: json['expert'] as String,
      viewpoint: json['viewpoint'] as String,
    );

Map<String, dynamic> _$$PerspectiveModelImplToJson(
        _$PerspectiveModelImpl instance) =>
    <String, dynamic>{
      'expert': instance.expert,
      'viewpoint': instance.viewpoint,
    };
