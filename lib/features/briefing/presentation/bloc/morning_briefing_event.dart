part of 'morning_briefing_bloc.dart';

@freezed
class MorningBriefingEvent with _$MorningBriefingEvent {
  const factory MorningBriefingEvent.loadBriefing({
    required String countryCode,
    String? region,
  }) = _LoadBriefing;
  
  const factory MorningBriefingEvent.refreshBriefing({
    required String countryCode,
    String? region,
  }) = _RefreshBriefing;
}