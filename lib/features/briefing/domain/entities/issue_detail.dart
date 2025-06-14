import 'package:equatable/equatable.dart';
import 'issue.dart';
import 'perspective.dart';

class NewsSource {
  final String title;
  final String publisher;
  final String url;
  final DateTime publishedAt;
  
  const NewsSource({
    required this.title,
    required this.publisher,
    required this.url,
    required this.publishedAt,
  });
}

class BackgroundKnowledge {
  final String id;
  final String title;
  final String content;
  final String category; // '역사적 맥락', '관련 법규', '기술적 배경' 등
  
  const BackgroundKnowledge({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
  });
}

class FactCheck {
  final String id;
  final String claim; // 주장
  final String verdict; // '사실', '대체로 사실', '논란의 여지', '오해의 소지', '거짓'
  final String explanation; // 설명
  final List<String> sources; // 출처
  
  const FactCheck({
    required this.id,
    required this.claim,
    required this.verdict,
    required this.explanation,
    required this.sources,
  });
}

class IssueDetail extends Equatable {
  final Issue issue;
  final String detailedSummary;
  final List<String> keyTerms;
  final Map<String, String> termDefinitions;
  final List<BackgroundKnowledge> backgroundKnowledge; // 배경 지식 카드
  final List<Map<String, dynamic>> dataVisualizations; // charts, graphs data
  final List<Perspective> perspectives;
  final List<NewsSource> sources; // 상세한 출처 정보
  final List<FactCheck> factChecks; // 팩트 체크

  const IssueDetail({
    required this.issue,
    required this.detailedSummary,
    required this.keyTerms,
    required this.termDefinitions,
    required this.backgroundKnowledge,
    required this.dataVisualizations,
    required this.perspectives,
    required this.sources,
    required this.factChecks,
  });

  @override
  List<Object?> get props => [
        issue,
        detailedSummary,
        keyTerms,
        termDefinitions,
        backgroundKnowledge,
        dataVisualizations,
        perspectives,
        sources,
        factChecks,
      ];
}