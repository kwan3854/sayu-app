import 'package:equatable/equatable.dart';

class DailyBriefing extends Equatable {
  final String id;
  final DateTime date;
  final String greeting;
  final String weatherSummary;
  final String dailyQuote;
  final String quoteAuthor;
  final List<String> todaysFocus;
  final String microPredictionPrompt;
  final String reflectionPrompt;
  final Map<String, dynamic>? metadata;

  const DailyBriefing({
    required this.id,
    required this.date,
    required this.greeting,
    required this.weatherSummary,
    required this.dailyQuote,
    required this.quoteAuthor,
    required this.todaysFocus,
    required this.microPredictionPrompt,
    required this.reflectionPrompt,
    this.metadata,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        greeting,
        weatherSummary,
        dailyQuote,
        quoteAuthor,
        todaysFocus,
        microPredictionPrompt,
        reflectionPrompt,
        metadata,
      ];
}