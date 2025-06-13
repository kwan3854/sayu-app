import 'package:equatable/equatable.dart';

class Issue extends Equatable {
  final String id;
  final String headline;
  final String summary;
  final String imageUrl;
  final DateTime publishedAt;
  final List<String> categories;
  final int importance; // 1-5 scale
  final Map<String, dynamic>? metadata;

  const Issue({
    required this.id,
    required this.headline,
    required this.summary,
    required this.imageUrl,
    required this.publishedAt,
    required this.categories,
    required this.importance,
    this.metadata,
  });

  @override
  List<Object?> get props => [
        id,
        headline,
        summary,
        imageUrl,
        publishedAt,
        categories,
        importance,
        metadata,
      ];
}