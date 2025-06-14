import 'package:equatable/equatable.dart';

class Perspective extends Equatable {
  final String id;
  final String issueId;
  final String title;
  final String content;
  final String expertName;
  final String expertTitle;
  final String? expertImageUrl;
  final String stance; // deprecated - will be removed
  final String perspectiveType; // '이해관계자', '시간적 관점', '전문 분야', '지역별', '철학적' 등
  final String perspectiveDetail; // '정부 입장', '단기적 영향', '경제학자 관점' 등 구체적 설명
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
    required this.perspectiveType,
    required this.perspectiveDetail,
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
        perspectiveType,
        perspectiveDetail,
        interactiveQuestions,
        createdAt,
      ];
}