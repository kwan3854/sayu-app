import 'package:equatable/equatable.dart';

class DailyBriefing extends Equatable {
  final String id;
  final String countryCode;
  final String? region;
  final DateTime briefingDate;
  final List<BriefingTopic> topics;
  final List<NewsItem> newsItems;
  final DateTime createdAt;

  const DailyBriefing({
    required this.id,
    required this.countryCode,
    this.region,
    required this.briefingDate,
    required this.topics,
    required this.newsItems,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, countryCode, region, briefingDate, topics, newsItems, createdAt];
}

class BriefingTopic extends Equatable {
  final String title;
  final String category;
  final List<String> keywords;

  const BriefingTopic({
    required this.title,
    required this.category,
    required this.keywords,
  });

  @override
  List<Object?> get props => [title, category, keywords];
}

class NewsItem extends Equatable {
  final String id;
  final String briefingId;
  final int position;
  final String title;
  final String summary;
  final String mainContent;
  final List<KeyTerm> keyTerms;
  final String? backgroundContext;
  final FactCheck factCheck;
  final List<NewsSource> sources;
  final List<NewsPerspective> perspectives;
  final String? perplexitySearchId;
  final DateTime createdAt;

  const NewsItem({
    required this.id,
    required this.briefingId,
    required this.position,
    required this.title,
    required this.summary,
    required this.mainContent,
    required this.keyTerms,
    this.backgroundContext,
    required this.factCheck,
    required this.sources,
    required this.perspectives,
    this.perplexitySearchId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        briefingId,
        position,
        title,
        summary,
        mainContent,
        keyTerms,
        backgroundContext,
        factCheck,
        sources,
        perspectives,
        perplexitySearchId,
        createdAt,
      ];
}

class KeyTerm extends Equatable {
  final String term;
  final String definition;

  const KeyTerm({
    required this.term,
    required this.definition,
  });

  @override
  List<Object?> get props => [term, definition];
}

class FactCheck extends Equatable {
  final String status;
  final String details;

  const FactCheck({
    required this.status,
    required this.details,
  });

  @override
  List<Object?> get props => [status, details];
}

class NewsSource extends Equatable {
  final String title;
  final String url;

  const NewsSource({
    required this.title,
    required this.url,
  });

  @override
  List<Object?> get props => [title, url];
}

class NewsPerspective extends Equatable {
  final String expert;
  final String viewpoint;

  const NewsPerspective({
    required this.expert,
    required this.viewpoint,
  });

  @override
  List<Object?> get props => [expert, viewpoint];
}