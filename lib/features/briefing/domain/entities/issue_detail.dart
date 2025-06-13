import 'package:equatable/equatable.dart';
import 'issue.dart';
import 'perspective.dart';

class IssueDetail extends Equatable {
  final Issue issue;
  final String detailedSummary;
  final List<String> keyTerms;
  final Map<String, String> termDefinitions;
  final List<Map<String, dynamic>> dataVisualizations; // charts, graphs data
  final List<Perspective> perspectives;
  final List<String> sourcesUrls;

  const IssueDetail({
    required this.issue,
    required this.detailedSummary,
    required this.keyTerms,
    required this.termDefinitions,
    required this.dataVisualizations,
    required this.perspectives,
    required this.sourcesUrls,
  });

  @override
  List<Object?> get props => [
        issue,
        detailedSummary,
        keyTerms,
        termDefinitions,
        dataVisualizations,
        perspectives,
        sourcesUrls,
      ];
}