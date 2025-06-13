import 'package:equatable/equatable.dart';

class Reflection extends Equatable {
  final String id;
  final String issueId;
  final String issueTitle;
  final String content;
  final List<String> perspectivesSeen;
  final String? predictionMade;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<String> tags;
  final int wordCount;

  const Reflection({
    required this.id,
    required this.issueId,
    required this.issueTitle,
    required this.content,
    required this.perspectivesSeen,
    this.predictionMade,
    required this.createdAt,
    this.updatedAt,
    required this.tags,
    required this.wordCount,
  });

  @override
  List<Object?> get props => [
        id,
        issueId,
        issueTitle,
        content,
        perspectivesSeen,
        predictionMade,
        createdAt,
        updatedAt,
        tags,
        wordCount,
      ];
}