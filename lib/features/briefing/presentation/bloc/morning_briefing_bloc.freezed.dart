// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'morning_briefing_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MorningBriefingEvent {
  String get countryCode => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String countryCode, String? region) loadBriefing,
    required TResult Function(String countryCode, String? region)
        refreshBriefing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String countryCode, String? region)? loadBriefing,
    TResult? Function(String countryCode, String? region)? refreshBriefing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String countryCode, String? region)? loadBriefing,
    TResult Function(String countryCode, String? region)? refreshBriefing,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBriefing value) loadBriefing,
    required TResult Function(_RefreshBriefing value) refreshBriefing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBriefing value)? loadBriefing,
    TResult? Function(_RefreshBriefing value)? refreshBriefing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBriefing value)? loadBriefing,
    TResult Function(_RefreshBriefing value)? refreshBriefing,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of MorningBriefingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MorningBriefingEventCopyWith<MorningBriefingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MorningBriefingEventCopyWith<$Res> {
  factory $MorningBriefingEventCopyWith(MorningBriefingEvent value,
          $Res Function(MorningBriefingEvent) then) =
      _$MorningBriefingEventCopyWithImpl<$Res, MorningBriefingEvent>;
  @useResult
  $Res call({String countryCode, String? region});
}

/// @nodoc
class _$MorningBriefingEventCopyWithImpl<$Res,
        $Val extends MorningBriefingEvent>
    implements $MorningBriefingEventCopyWith<$Res> {
  _$MorningBriefingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MorningBriefingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryCode = null,
    Object? region = freezed,
  }) {
    return _then(_value.copyWith(
      countryCode: null == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadBriefingImplCopyWith<$Res>
    implements $MorningBriefingEventCopyWith<$Res> {
  factory _$$LoadBriefingImplCopyWith(
          _$LoadBriefingImpl value, $Res Function(_$LoadBriefingImpl) then) =
      __$$LoadBriefingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String countryCode, String? region});
}

/// @nodoc
class __$$LoadBriefingImplCopyWithImpl<$Res>
    extends _$MorningBriefingEventCopyWithImpl<$Res, _$LoadBriefingImpl>
    implements _$$LoadBriefingImplCopyWith<$Res> {
  __$$LoadBriefingImplCopyWithImpl(
      _$LoadBriefingImpl _value, $Res Function(_$LoadBriefingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MorningBriefingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryCode = null,
    Object? region = freezed,
  }) {
    return _then(_$LoadBriefingImpl(
      countryCode: null == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadBriefingImpl implements _LoadBriefing {
  const _$LoadBriefingImpl({required this.countryCode, this.region});

  @override
  final String countryCode;
  @override
  final String? region;

  @override
  String toString() {
    return 'MorningBriefingEvent.loadBriefing(countryCode: $countryCode, region: $region)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadBriefingImpl &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.region, region) || other.region == region));
  }

  @override
  int get hashCode => Object.hash(runtimeType, countryCode, region);

  /// Create a copy of MorningBriefingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadBriefingImplCopyWith<_$LoadBriefingImpl> get copyWith =>
      __$$LoadBriefingImplCopyWithImpl<_$LoadBriefingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String countryCode, String? region) loadBriefing,
    required TResult Function(String countryCode, String? region)
        refreshBriefing,
  }) {
    return loadBriefing(countryCode, region);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String countryCode, String? region)? loadBriefing,
    TResult? Function(String countryCode, String? region)? refreshBriefing,
  }) {
    return loadBriefing?.call(countryCode, region);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String countryCode, String? region)? loadBriefing,
    TResult Function(String countryCode, String? region)? refreshBriefing,
    required TResult orElse(),
  }) {
    if (loadBriefing != null) {
      return loadBriefing(countryCode, region);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBriefing value) loadBriefing,
    required TResult Function(_RefreshBriefing value) refreshBriefing,
  }) {
    return loadBriefing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBriefing value)? loadBriefing,
    TResult? Function(_RefreshBriefing value)? refreshBriefing,
  }) {
    return loadBriefing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBriefing value)? loadBriefing,
    TResult Function(_RefreshBriefing value)? refreshBriefing,
    required TResult orElse(),
  }) {
    if (loadBriefing != null) {
      return loadBriefing(this);
    }
    return orElse();
  }
}

abstract class _LoadBriefing implements MorningBriefingEvent {
  const factory _LoadBriefing(
      {required final String countryCode,
      final String? region}) = _$LoadBriefingImpl;

  @override
  String get countryCode;
  @override
  String? get region;

  /// Create a copy of MorningBriefingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadBriefingImplCopyWith<_$LoadBriefingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshBriefingImplCopyWith<$Res>
    implements $MorningBriefingEventCopyWith<$Res> {
  factory _$$RefreshBriefingImplCopyWith(_$RefreshBriefingImpl value,
          $Res Function(_$RefreshBriefingImpl) then) =
      __$$RefreshBriefingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String countryCode, String? region});
}

/// @nodoc
class __$$RefreshBriefingImplCopyWithImpl<$Res>
    extends _$MorningBriefingEventCopyWithImpl<$Res, _$RefreshBriefingImpl>
    implements _$$RefreshBriefingImplCopyWith<$Res> {
  __$$RefreshBriefingImplCopyWithImpl(
      _$RefreshBriefingImpl _value, $Res Function(_$RefreshBriefingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MorningBriefingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryCode = null,
    Object? region = freezed,
  }) {
    return _then(_$RefreshBriefingImpl(
      countryCode: null == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RefreshBriefingImpl implements _RefreshBriefing {
  const _$RefreshBriefingImpl({required this.countryCode, this.region});

  @override
  final String countryCode;
  @override
  final String? region;

  @override
  String toString() {
    return 'MorningBriefingEvent.refreshBriefing(countryCode: $countryCode, region: $region)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshBriefingImpl &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.region, region) || other.region == region));
  }

  @override
  int get hashCode => Object.hash(runtimeType, countryCode, region);

  /// Create a copy of MorningBriefingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshBriefingImplCopyWith<_$RefreshBriefingImpl> get copyWith =>
      __$$RefreshBriefingImplCopyWithImpl<_$RefreshBriefingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String countryCode, String? region) loadBriefing,
    required TResult Function(String countryCode, String? region)
        refreshBriefing,
  }) {
    return refreshBriefing(countryCode, region);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String countryCode, String? region)? loadBriefing,
    TResult? Function(String countryCode, String? region)? refreshBriefing,
  }) {
    return refreshBriefing?.call(countryCode, region);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String countryCode, String? region)? loadBriefing,
    TResult Function(String countryCode, String? region)? refreshBriefing,
    required TResult orElse(),
  }) {
    if (refreshBriefing != null) {
      return refreshBriefing(countryCode, region);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBriefing value) loadBriefing,
    required TResult Function(_RefreshBriefing value) refreshBriefing,
  }) {
    return refreshBriefing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBriefing value)? loadBriefing,
    TResult? Function(_RefreshBriefing value)? refreshBriefing,
  }) {
    return refreshBriefing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBriefing value)? loadBriefing,
    TResult Function(_RefreshBriefing value)? refreshBriefing,
    required TResult orElse(),
  }) {
    if (refreshBriefing != null) {
      return refreshBriefing(this);
    }
    return orElse();
  }
}

abstract class _RefreshBriefing implements MorningBriefingEvent {
  const factory _RefreshBriefing(
      {required final String countryCode,
      final String? region}) = _$RefreshBriefingImpl;

  @override
  String get countryCode;
  @override
  String? get region;

  /// Create a copy of MorningBriefingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshBriefingImplCopyWith<_$RefreshBriefingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MorningBriefingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(DailyBriefing briefing) loaded,
    required TResult Function() noBriefing,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailyBriefing briefing)? loaded,
    TResult? Function()? noBriefing,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailyBriefing briefing)? loaded,
    TResult Function()? noBriefing,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_NoBriefing value) noBriefing,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_NoBriefing value)? noBriefing,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_NoBriefing value)? noBriefing,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MorningBriefingStateCopyWith<$Res> {
  factory $MorningBriefingStateCopyWith(MorningBriefingState value,
          $Res Function(MorningBriefingState) then) =
      _$MorningBriefingStateCopyWithImpl<$Res, MorningBriefingState>;
}

/// @nodoc
class _$MorningBriefingStateCopyWithImpl<$Res,
        $Val extends MorningBriefingState>
    implements $MorningBriefingStateCopyWith<$Res> {
  _$MorningBriefingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MorningBriefingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$MorningBriefingStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of MorningBriefingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'MorningBriefingState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(DailyBriefing briefing) loaded,
    required TResult Function() noBriefing,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailyBriefing briefing)? loaded,
    TResult? Function()? noBriefing,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailyBriefing briefing)? loaded,
    TResult Function()? noBriefing,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_NoBriefing value) noBriefing,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_NoBriefing value)? noBriefing,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_NoBriefing value)? noBriefing,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements MorningBriefingState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$MorningBriefingStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MorningBriefingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'MorningBriefingState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(DailyBriefing briefing) loaded,
    required TResult Function() noBriefing,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailyBriefing briefing)? loaded,
    TResult? Function()? noBriefing,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailyBriefing briefing)? loaded,
    TResult Function()? noBriefing,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_NoBriefing value) noBriefing,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_NoBriefing value)? noBriefing,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_NoBriefing value)? noBriefing,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements MorningBriefingState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DailyBriefing briefing});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$MorningBriefingStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MorningBriefingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? briefing = null,
  }) {
    return _then(_$LoadedImpl(
      null == briefing
          ? _value.briefing
          : briefing // ignore: cast_nullable_to_non_nullable
              as DailyBriefing,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(this.briefing);

  @override
  final DailyBriefing briefing;

  @override
  String toString() {
    return 'MorningBriefingState.loaded(briefing: $briefing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.briefing, briefing) ||
                other.briefing == briefing));
  }

  @override
  int get hashCode => Object.hash(runtimeType, briefing);

  /// Create a copy of MorningBriefingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(DailyBriefing briefing) loaded,
    required TResult Function() noBriefing,
    required TResult Function(String message) error,
  }) {
    return loaded(briefing);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailyBriefing briefing)? loaded,
    TResult? Function()? noBriefing,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(briefing);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailyBriefing briefing)? loaded,
    TResult Function()? noBriefing,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(briefing);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_NoBriefing value) noBriefing,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_NoBriefing value)? noBriefing,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_NoBriefing value)? noBriefing,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements MorningBriefingState {
  const factory _Loaded(final DailyBriefing briefing) = _$LoadedImpl;

  DailyBriefing get briefing;

  /// Create a copy of MorningBriefingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoBriefingImplCopyWith<$Res> {
  factory _$$NoBriefingImplCopyWith(
          _$NoBriefingImpl value, $Res Function(_$NoBriefingImpl) then) =
      __$$NoBriefingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoBriefingImplCopyWithImpl<$Res>
    extends _$MorningBriefingStateCopyWithImpl<$Res, _$NoBriefingImpl>
    implements _$$NoBriefingImplCopyWith<$Res> {
  __$$NoBriefingImplCopyWithImpl(
      _$NoBriefingImpl _value, $Res Function(_$NoBriefingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MorningBriefingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NoBriefingImpl implements _NoBriefing {
  const _$NoBriefingImpl();

  @override
  String toString() {
    return 'MorningBriefingState.noBriefing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoBriefingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(DailyBriefing briefing) loaded,
    required TResult Function() noBriefing,
    required TResult Function(String message) error,
  }) {
    return noBriefing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailyBriefing briefing)? loaded,
    TResult? Function()? noBriefing,
    TResult? Function(String message)? error,
  }) {
    return noBriefing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailyBriefing briefing)? loaded,
    TResult Function()? noBriefing,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (noBriefing != null) {
      return noBriefing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_NoBriefing value) noBriefing,
    required TResult Function(_Error value) error,
  }) {
    return noBriefing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_NoBriefing value)? noBriefing,
    TResult? Function(_Error value)? error,
  }) {
    return noBriefing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_NoBriefing value)? noBriefing,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (noBriefing != null) {
      return noBriefing(this);
    }
    return orElse();
  }
}

abstract class _NoBriefing implements MorningBriefingState {
  const factory _NoBriefing() = _$NoBriefingImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$MorningBriefingStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MorningBriefingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'MorningBriefingState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MorningBriefingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(DailyBriefing briefing) loaded,
    required TResult Function() noBriefing,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailyBriefing briefing)? loaded,
    TResult? Function()? noBriefing,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailyBriefing briefing)? loaded,
    TResult Function()? noBriefing,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_NoBriefing value) noBriefing,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_NoBriefing value)? noBriefing,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_NoBriefing value)? noBriefing,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements MorningBriefingState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of MorningBriefingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
