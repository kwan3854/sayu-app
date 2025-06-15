import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/daily_briefing.dart';
import '../../domain/usecases/get_todays_briefing.dart';

part 'morning_briefing_event.dart';
part 'morning_briefing_state.dart';
part 'morning_briefing_bloc.freezed.dart';

@injectable
class MorningBriefingBloc extends Bloc<MorningBriefingEvent, MorningBriefingState> {
  final GetTodaysBriefing _getTodaysBriefing;

  MorningBriefingBloc(
    this._getTodaysBriefing,
  ) : super(const MorningBriefingState.initial()) {
    on<_LoadBriefing>(_onLoadBriefing);
    on<_RefreshBriefing>(_onRefreshBriefing);
  }

  Future<void> _onLoadBriefing(
    _LoadBriefing event,
    Emitter<MorningBriefingState> emit,
  ) async {
    emit(const MorningBriefingState.loading());

    final result = await _getTodaysBriefing(
      BriefingParams(
        countryCode: event.countryCode,
        region: event.region,
      ),
    );

    result.fold(
      (failure) => emit(MorningBriefingState.error(failure.toString())),
      (briefing) {
        if (briefing == null) {
          emit(const MorningBriefingState.noBriefing());
        } else {
          emit(MorningBriefingState.loaded(briefing));
        }
      },
    );
  }

  Future<void> _onRefreshBriefing(
    _RefreshBriefing event,
    Emitter<MorningBriefingState> emit,
  ) async {
    // Keep current state while refreshing in background
    final currentState = state;
    
    final result = await _getTodaysBriefing(
      BriefingParams(
        countryCode: event.countryCode,
        region: event.region,
      ),
    );

    result.fold(
      (failure) {
        // If refresh fails, keep current state but show error snackbar
        if (currentState is _Loaded) {
          emit(currentState);
        } else {
          emit(MorningBriefingState.error(failure.toString()));
        }
      },
      (briefing) {
        if (briefing == null) {
          emit(const MorningBriefingState.noBriefing());
        } else {
          emit(MorningBriefingState.loaded(briefing));
        }
      },
    );
  }
}