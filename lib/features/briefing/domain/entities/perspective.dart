import 'package:equatable/equatable.dart';

class Perspective extends Equatable {
  final String id;
  final String issueId;
  final String title;
  final String content;
  final String expertName;
  final String expertTitle;
  final String? expertImageUrl;
  final String stance; // 'positive', 'negative', 'neutral', 'technical', 'social', 'economic'
  final List<String> interactiveQuestions;
  final DateTime createdAt;

  const Perspective({
    required this.id,
    required this.issueId,
    required this.title,
    required this.content,
    required this.expertName,
    required this.expertTitle,
    this.expertImageUrl,
    required this.stance,
    required this.interactiveQuestions,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        issueId,
        title,
        content,
        expertName,
        expertTitle,
        expertImageUrl,
        stance,
        interactiveQuestions,
        createdAt,
      ];
}