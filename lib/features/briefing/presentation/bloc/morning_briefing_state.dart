part of 'morning_briefing_bloc.dart';

@freezed
class MorningBriefingState with _$MorningBriefingState {
  const factory MorningBriefingState.initial() = _Initial;
  const factory MorningBriefingState.loading() = _Loading;
  const factory MorningBriefingState.loaded(DailyBriefing briefing) = _Loaded;
  const factory MorningBriefingState.noBriefing() = _NoBriefing;
  const factory MorningBriefingState.error(String message) = _Error;
}