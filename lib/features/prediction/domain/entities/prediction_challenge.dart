import 'package:equatable/equatable.dart';

class PredictionChallenge extends Equatable {
  final String id;
  final String type; // 'micro', 'macro', 'strategic'
  final String question;
  final String? context;
  final List<String> options;
  final DateTime deadline;
  final String? expertConsensus;
  final bool isActive;
  final String? result;
  final String? resultExplanation;

  const PredictionChallenge({
    required this.id,
    required this.type,
    required this.question,
    this.context,
    required this.options,
    required this.deadline,
    this.expertConsensus,
    required this.isActive,
    this.result,
    this.resultExplanation,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        question,
        context,
        options,
        deadline,
        expertConsensus,
        isActive,
        result,
        resultExplanation,
      ];
}