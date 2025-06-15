// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_briefing_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyBriefingModel _$DailyBriefingModelFromJson(Map<String, dynamic> json) {
  return _DailyBriefingModel.fromJson(json);
}

/// @nodoc
mixin _$DailyBriefingModel {
  String get id => throw _privateConstructorUsedError;
  String get countryCode => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  DateTime get briefingDate => throw _privateConstructorUsedError;
  List<BriefingTopicModel> get topics => throw _privateConstructorUsedError;
  List<NewsItemModel> get newsItems => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this DailyBriefingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyBriefingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyBriefingModelCopyWith<DailyBriefingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyBriefingModelCopyWith<$Res> {
  factory $DailyBriefingModelCopyWith(
          DailyBriefingModel value, $Res Function(DailyBriefingModel) then) =
      _$DailyBriefingModelCopyWithImpl<$Res, DailyBriefingModel>;
  @useResult
  $Res call(
      {String id,
      String countryCode,
      String? region,
      DateTime briefingDate,
      List<BriefingTopicModel> topics,
      List<NewsItemModel> newsItems,
      DateTime createdAt});
}

/// @nodoc
class _$DailyBriefingModelCopyWithImpl<$Res, $Val extends DailyBriefingModel>
    implements $DailyBriefingModelCopyWith<$Res> {
  _$DailyBriefingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyBriefingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? countryCode = null,
    Object? region = freezed,
    Object? briefingDate = null,
    Object? topics = null,
    Object? newsItems = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode: null == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      briefingDate: null == briefingDate
          ? _value.briefingDate
          : briefingDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      topics: null == topics
          ? _value.topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<BriefingTopicModel>,
      newsItems: null == newsItems
          ? _value.newsItems
          : newsItems // ignore: cast_nullable_to_non_nullable
              as List<NewsItemModel>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyBriefingModelImplCopyWith<$Res>
    implements $DailyBriefingModelCopyWith<$Res> {
  factory _$$DailyBriefingModelImplCopyWith(_$DailyBriefingModelImpl value,
          $Res Function(_$DailyBriefingModelImpl) then) =
      __$$DailyBriefingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String countryCode,
      String? region,
      DateTime briefingDate,
      List<BriefingTopicModel> topics,
      List<NewsItemModel> newsItems,
      DateTime createdAt});
}

/// @nodoc
class __$$DailyBriefingModelImplCopyWithImpl<$Res>
    extends _$DailyBriefingModelCopyWithImpl<$Res, _$DailyBriefingModelImpl>
    implements _$$DailyBriefingModelImplCopyWith<$Res> {
  __$$DailyBriefingModelImplCopyWithImpl(_$DailyBriefingModelImpl _value,
      $Res Function(_$DailyBriefingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyBriefingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? countryCode = null,
    Object? region = freezed,
    Object? briefingDate = null,
    Object? topics = null,
    Object? newsItems = null,
    Object? createdAt = null,
  }) {
    return _then(_$DailyBriefingModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode: null == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      briefingDate: null == briefingDate
          ? _value.briefingDate
          : briefingDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      topics: null == topics
          ? _value._topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<BriefingTopicModel>,
      newsItems: null == newsItems
          ? _value._newsItems
          : newsItems // ignore: cast_nullable_to_non_nullable
              as List<NewsItemModel>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyBriefingModelImpl implements _DailyBriefingModel {
  const _$DailyBriefingModelImpl(
      {required this.id,
      required this.countryCode,
      this.region,
      required this.briefingDate,
      required final List<BriefingTopicModel> topics,
      required final List<NewsItemModel> newsItems,
      required this.createdAt})
      : _topics = topics,
        _newsItems = newsItems;

  factory _$DailyBriefingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyBriefingModelImplFromJson(json);

  @override
  final String id;
  @override
  final String countryCode;
  @override
  final String? region;
  @override
  final DateTime briefingDate;
  final List<BriefingTopicModel> _topics;
  @override
  List<BriefingTopicModel> get topics {
    if (_topics is EqualUnmodifiableListView) return _topics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topics);
  }

  final List<NewsItemModel> _newsItems;
  @override
  List<NewsItemModel> get newsItems {
    if (_newsItems is EqualUnmodifiableListView) return _newsItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newsItems);
  }

  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'DailyBriefingModel(id: $id, countryCode: $countryCode, region: $region, briefingDate: $briefingDate, topics: $topics, newsItems: $newsItems, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyBriefingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.briefingDate, briefingDate) ||
                other.briefingDate == briefingDate) &&
            const DeepCollectionEquality().equals(other._topics, _topics) &&
            const DeepCollectionEquality()
                .equals(other._newsItems, _newsItems) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      countryCode,
      region,
      briefingDate,
      const DeepCollectionEquality().hash(_topics),
      const DeepCollectionEquality().hash(_newsItems),
      createdAt);

  /// Create a copy of DailyBriefingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyBriefingModelImplCopyWith<_$DailyBriefingModelImpl> get copyWith =>
      __$$DailyBriefingModelImplCopyWithImpl<_$DailyBriefingModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyBriefingModelImplToJson(
      this,
    );
  }
}

abstract class _DailyBriefingModel implements DailyBriefingModel {
  const factory _DailyBriefingModel(
      {required final String id,
      required final String countryCode,
      final String? region,
      required final DateTime briefingDate,
      required final List<BriefingTopicModel> topics,
      required final List<NewsItemModel> newsItems,
      required final DateTime createdAt}) = _$DailyBriefingModelImpl;

  factory _DailyBriefingModel.fromJson(Map<String, dynamic> json) =
      _$DailyBriefingModelImpl.fromJson;

  @override
  String get id;
  @override
  String get countryCode;
  @override
  String? get region;
  @override
  DateTime get briefingDate;
  @override
  List<BriefingTopicModel> get topics;
  @override
  List<NewsItemModel> get newsItems;
  @override
  DateTime get createdAt;

  /// Create a copy of DailyBriefingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyBriefingModelImplCopyWith<_$DailyBriefingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BriefingTopicModel _$BriefingTopicModelFromJson(Map<String, dynamic> json) {
  return _BriefingTopicModel.fromJson(json);
}

/// @nodoc
mixin _$BriefingTopicModel {
  String get title => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  List<String> get keywords => throw _privateConstructorUsedError;

  /// Serializes this BriefingTopicModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BriefingTopicModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BriefingTopicModelCopyWith<BriefingTopicModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BriefingTopicModelCopyWith<$Res> {
  factory $BriefingTopicModelCopyWith(
          BriefingTopicModel value, $Res Function(BriefingTopicModel) then) =
      _$BriefingTopicModelCopyWithImpl<$Res, BriefingTopicModel>;
  @useResult
  $Res call({String title, String category, List<String> keywords});
}

/// @nodoc
class _$BriefingTopicModelCopyWithImpl<$Res, $Val extends BriefingTopicModel>
    implements $BriefingTopicModelCopyWith<$Res> {
  _$BriefingTopicModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BriefingTopicModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? category = null,
    Object? keywords = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: null == keywords
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BriefingTopicModelImplCopyWith<$Res>
    implements $BriefingTopicModelCopyWith<$Res> {
  factory _$$BriefingTopicModelImplCopyWith(_$BriefingTopicModelImpl value,
          $Res Function(_$BriefingTopicModelImpl) then) =
      __$$BriefingTopicModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String category, List<String> keywords});
}

/// @nodoc
class __$$BriefingTopicModelImplCopyWithImpl<$Res>
    extends _$BriefingTopicModelCopyWithImpl<$Res, _$BriefingTopicModelImpl>
    implements _$$BriefingTopicModelImplCopyWith<$Res> {
  __$$BriefingTopicModelImplCopyWithImpl(_$BriefingTopicModelImpl _value,
      $Res Function(_$BriefingTopicModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BriefingTopicModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? category = null,
    Object? keywords = null,
  }) {
    return _then(_$BriefingTopicModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: null == keywords
          ? _value._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BriefingTopicModelImpl implements _BriefingTopicModel {
  const _$BriefingTopicModelImpl(
      {required this.title,
      required this.category,
      required final List<String> keywords})
      : _keywords = keywords;

  factory _$BriefingTopicModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BriefingTopicModelImplFromJson(json);

  @override
  final String title;
  @override
  final String category;
  final List<String> _keywords;
  @override
  List<String> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  @override
  String toString() {
    return 'BriefingTopicModel(title: $title, category: $category, keywords: $keywords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BriefingTopicModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, category,
      const DeepCollectionEquality().hash(_keywords));

  /// Create a copy of BriefingTopicModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BriefingTopicModelImplCopyWith<_$BriefingTopicModelImpl> get copyWith =>
      __$$BriefingTopicModelImplCopyWithImpl<_$BriefingTopicModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BriefingTopicModelImplToJson(
      this,
    );
  }
}

abstract class _BriefingTopicModel implements BriefingTopicModel {
  const factory _BriefingTopicModel(
      {required final String title,
      required final String category,
      required final List<String> keywords}) = _$BriefingTopicModelImpl;

  factory _BriefingTopicModel.fromJson(Map<String, dynamic> json) =
      _$BriefingTopicModelImpl.fromJson;

  @override
  String get title;
  @override
  String get category;
  @override
  List<String> get keywords;

  /// Create a copy of BriefingTopicModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BriefingTopicModelImplCopyWith<_$BriefingTopicModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NewsItemModel _$NewsItemModelFromJson(Map<String, dynamic> json) {
  return _NewsItemModel.fromJson(json);
}

/// @nodoc
mixin _$NewsItemModel {
  String get id => throw _privateConstructorUsedError;
  String get briefingId => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  String get mainContent => throw _privateConstructorUsedError;
  List<KeyTermModel> get keyTerms => throw _privateConstructorUsedError;
  String? get backgroundContext => throw _privateConstructorUsedError;
  FactCheckModel get factCheck => throw _privateConstructorUsedError;
  List<SourceModel> get sources => throw _privateConstructorUsedError;
  List<PerspectiveModel> get perspectives => throw _privateConstructorUsedError;
  String? get perplexitySearchId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this NewsItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewsItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewsItemModelCopyWith<NewsItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsItemModelCopyWith<$Res> {
  factory $NewsItemModelCopyWith(
          NewsItemModel value, $Res Function(NewsItemModel) then) =
      _$NewsItemModelCopyWithImpl<$Res, NewsItemModel>;
  @useResult
  $Res call(
      {String id,
      String briefingId,
      int position,
      String title,
      String summary,
      String mainContent,
      List<KeyTermModel> keyTerms,
      String? backgroundContext,
      FactCheckModel factCheck,
      List<SourceModel> sources,
      List<PerspectiveModel> perspectives,
      String? perplexitySearchId,
      DateTime createdAt});

  $FactCheckModelCopyWith<$Res> get factCheck;
}

/// @nodoc
class _$NewsItemModelCopyWithImpl<$Res, $Val extends NewsItemModel>
    implements $NewsItemModelCopyWith<$Res> {
  _$NewsItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewsItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? briefingId = null,
    Object? position = null,
    Object? title = null,
    Object? summary = null,
    Object? mainContent = null,
    Object? keyTerms = null,
    Object? backgroundContext = freezed,
    Object? factCheck = null,
    Object? sources = null,
    Object? perspectives = null,
    Object? perplexitySearchId = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      briefingId: null == briefingId
          ? _value.briefingId
          : briefingId // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      mainContent: null == mainContent
          ? _value.mainContent
          : mainContent // ignore: cast_nullable_to_non_nullable
              as String,
      keyTerms: null == keyTerms
          ? _value.keyTerms
          : keyTerms // ignore: cast_nullable_to_non_nullable
              as List<KeyTermModel>,
      backgroundContext: freezed == backgroundContext
          ? _value.backgroundContext
          : backgroundContext // ignore: cast_nullable_to_non_nullable
              as String?,
      factCheck: null == factCheck
          ? _value.factCheck
          : factCheck // ignore: cast_nullable_to_non_nullable
              as FactCheckModel,
      sources: null == sources
          ? _value.sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<SourceModel>,
      perspectives: null == perspectives
          ? _value.perspectives
          : perspectives // ignore: cast_nullable_to_non_nullable
              as List<PerspectiveModel>,
      perplexitySearchId: freezed == perplexitySearchId
          ? _value.perplexitySearchId
          : perplexitySearchId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of NewsItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FactCheckModelCopyWith<$Res> get factCheck {
    return $FactCheckModelCopyWith<$Res>(_value.factCheck, (value) {
      return _then(_value.copyWith(factCheck: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NewsItemModelImplCopyWith<$Res>
    implements $NewsItemModelCopyWith<$Res> {
  factory _$$NewsItemModelImplCopyWith(
          _$NewsItemModelImpl value, $Res Function(_$NewsItemModelImpl) then) =
      __$$NewsItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String briefingId,
      int position,
      String title,
      String summary,
      String mainContent,
      List<KeyTermModel> keyTerms,
      String? backgroundContext,
      FactCheckModel factCheck,
      List<SourceModel> sources,
      List<PerspectiveModel> perspectives,
      String? perplexitySearchId,
      DateTime createdAt});

  @override
  $FactCheckModelCopyWith<$Res> get factCheck;
}

/// @nodoc
class __$$NewsItemModelImplCopyWithImpl<$Res>
    extends _$NewsItemModelCopyWithImpl<$Res, _$NewsItemModelImpl>
    implements _$$NewsItemModelImplCopyWith<$Res> {
  __$$NewsItemModelImplCopyWithImpl(
      _$NewsItemModelImpl _value, $Res Function(_$NewsItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewsItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? briefingId = null,
    Object? position = null,
    Object? title = null,
    Object? summary = null,
    Object? mainContent = null,
    Object? keyTerms = null,
    Object? backgroundContext = freezed,
    Object? factCheck = null,
    Object? sources = null,
    Object? perspectives = null,
    Object? perplexitySearchId = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$NewsItemModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      briefingId: null == briefingId
          ? _value.briefingId
          : briefingId // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      mainContent: null == mainContent
          ? _value.mainContent
          : mainContent // ignore: cast_nullable_to_non_nullable
              as String,
      keyTerms: null == keyTerms
          ? _value._keyTerms
          : keyTerms // ignore: cast_nullable_to_non_nullable
              as List<KeyTermModel>,
      backgroundContext: freezed == backgroundContext
          ? _value.backgroundContext
          : backgroundContext // ignore: cast_nullable_to_non_nullable
              as String?,
      factCheck: null == factCheck
          ? _value.factCheck
          : factCheck // ignore: cast_nullable_to_non_nullable
              as FactCheckModel,
      sources: null == sources
          ? _value._sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<SourceModel>,
      perspectives: null == perspectives
          ? _value._perspectives
          : perspectives // ignore: cast_nullable_to_non_nullable
              as List<PerspectiveModel>,
      perplexitySearchId: freezed == perplexitySearchId
          ? _value.perplexitySearchId
          : perplexitySearchId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsItemModelImpl implements _NewsItemModel {
  const _$NewsItemModelImpl(
      {required this.id,
      required this.briefingId,
      required this.position,
      required this.title,
      required this.summary,
      required this.mainContent,
      required final List<KeyTermModel> keyTerms,
      this.backgroundContext,
      required this.factCheck,
      required final List<SourceModel> sources,
      required final List<PerspectiveModel> perspectives,
      this.perplexitySearchId,
      required this.createdAt})
      : _keyTerms = keyTerms,
        _sources = sources,
        _perspectives = perspectives;

  factory _$NewsItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsItemModelImplFromJson(json);

  @override
  final String id;
  @override
  final String briefingId;
  @override
  final int position;
  @override
  final String title;
  @override
  final String summary;
  @override
  final String mainContent;
  final List<KeyTermModel> _keyTerms;
  @override
  List<KeyTermModel> get keyTerms {
    if (_keyTerms is EqualUnmodifiableListView) return _keyTerms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keyTerms);
  }

  @override
  final String? backgroundContext;
  @override
  final FactCheckModel factCheck;
  final List<SourceModel> _sources;
  @override
  List<SourceModel> get sources {
    if (_sources is EqualUnmodifiableListView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sources);
  }

  final List<PerspectiveModel> _perspectives;
  @override
  List<PerspectiveModel> get perspectives {
    if (_perspectives is EqualUnmodifiableListView) return _perspectives;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_perspectives);
  }

  @override
  final String? perplexitySearchId;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'NewsItemModel(id: $id, briefingId: $briefingId, position: $position, title: $title, summary: $summary, mainContent: $mainContent, keyTerms: $keyTerms, backgroundContext: $backgroundContext, factCheck: $factCheck, sources: $sources, perspectives: $perspectives, perplexitySearchId: $perplexitySearchId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.briefingId, briefingId) ||
                other.briefingId == briefingId) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.mainContent, mainContent) ||
                other.mainContent == mainContent) &&
            const DeepCollectionEquality().equals(other._keyTerms, _keyTerms) &&
            (identical(other.backgroundContext, backgroundContext) ||
                other.backgroundContext == backgroundContext) &&
            (identical(other.factCheck, factCheck) ||
                other.factCheck == factCheck) &&
            const DeepCollectionEquality().equals(other._sources, _sources) &&
            const DeepCollectionEquality()
                .equals(other._perspectives, _perspectives) &&
            (identical(other.perplexitySearchId, perplexitySearchId) ||
                other.perplexitySearchId == perplexitySearchId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      briefingId,
      position,
      title,
      summary,
      mainContent,
      const DeepCollectionEquality().hash(_keyTerms),
      backgroundContext,
      factCheck,
      const DeepCollectionEquality().hash(_sources),
      const DeepCollectionEquality().hash(_perspectives),
      perplexitySearchId,
      createdAt);

  /// Create a copy of NewsItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsItemModelImplCopyWith<_$NewsItemModelImpl> get copyWith =>
      __$$NewsItemModelImplCopyWithImpl<_$NewsItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsItemModelImplToJson(
      this,
    );
  }
}

abstract class _NewsItemModel implements NewsItemModel {
  const factory _NewsItemModel(
      {required final String id,
      required final String briefingId,
      required final int position,
      required final String title,
      required final String summary,
      required final String mainContent,
      required final List<KeyTermModel> keyTerms,
      final String? backgroundContext,
      required final FactCheckModel factCheck,
      required final List<SourceModel> sources,
      required final List<PerspectiveModel> perspectives,
      final String? perplexitySearchId,
      required final DateTime createdAt}) = _$NewsItemModelImpl;

  factory _NewsItemModel.fromJson(Map<String, dynamic> json) =
      _$NewsItemModelImpl.fromJson;

  @override
  String get id;
  @override
  String get briefingId;
  @override
  int get position;
  @override
  String get title;
  @override
  String get summary;
  @override
  String get mainContent;
  @override
  List<KeyTermModel> get keyTerms;
  @override
  String? get backgroundContext;
  @override
  FactCheckModel get factCheck;
  @override
  List<SourceModel> get sources;
  @override
  List<PerspectiveModel> get perspectives;
  @override
  String? get perplexitySearchId;
  @override
  DateTime get createdAt;

  /// Create a copy of NewsItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsItemModelImplCopyWith<_$NewsItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KeyTermModel _$KeyTermModelFromJson(Map<String, dynamic> json) {
  return _KeyTermModel.fromJson(json);
}

/// @nodoc
mixin _$KeyTermModel {
  String get term => throw _privateConstructorUsedError;
  String get definition => throw _privateConstructorUsedError;

  /// Serializes this KeyTermModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KeyTermModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeyTermModelCopyWith<KeyTermModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyTermModelCopyWith<$Res> {
  factory $KeyTermModelCopyWith(
          KeyTermModel value, $Res Function(KeyTermModel) then) =
      _$KeyTermModelCopyWithImpl<$Res, KeyTermModel>;
  @useResult
  $Res call({String term, String definition});
}

/// @nodoc
class _$KeyTermModelCopyWithImpl<$Res, $Val extends KeyTermModel>
    implements $KeyTermModelCopyWith<$Res> {
  _$KeyTermModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KeyTermModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? term = null,
    Object? definition = null,
  }) {
    return _then(_value.copyWith(
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
      definition: null == definition
          ? _value.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KeyTermModelImplCopyWith<$Res>
    implements $KeyTermModelCopyWith<$Res> {
  factory _$$KeyTermModelImplCopyWith(
          _$KeyTermModelImpl value, $Res Function(_$KeyTermModelImpl) then) =
      __$$KeyTermModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String term, String definition});
}

/// @nodoc
class __$$KeyTermModelImplCopyWithImpl<$Res>
    extends _$KeyTermModelCopyWithImpl<$Res, _$KeyTermModelImpl>
    implements _$$KeyTermModelImplCopyWith<$Res> {
  __$$KeyTermModelImplCopyWithImpl(
      _$KeyTermModelImpl _value, $Res Function(_$KeyTermModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of KeyTermModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? term = null,
    Object? definition = null,
  }) {
    return _then(_$KeyTermModelImpl(
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
      definition: null == definition
          ? _value.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KeyTermModelImpl implements _KeyTermModel {
  const _$KeyTermModelImpl({required this.term, required this.definition});

  factory _$KeyTermModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeyTermModelImplFromJson(json);

  @override
  final String term;
  @override
  final String definition;

  @override
  String toString() {
    return 'KeyTermModel(term: $term, definition: $definition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeyTermModelImpl &&
            (identical(other.term, term) || other.term == term) &&
            (identical(other.definition, definition) ||
                other.definition == definition));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, term, definition);

  /// Create a copy of KeyTermModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyTermModelImplCopyWith<_$KeyTermModelImpl> get copyWith =>
      __$$KeyTermModelImplCopyWithImpl<_$KeyTermModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeyTermModelImplToJson(
      this,
    );
  }
}

abstract class _KeyTermModel implements KeyTermModel {
  const factory _KeyTermModel(
      {required final String term,
      required final String definition}) = _$KeyTermModelImpl;

  factory _KeyTermModel.fromJson(Map<String, dynamic> json) =
      _$KeyTermModelImpl.fromJson;

  @override
  String get term;
  @override
  String get definition;

  /// Create a copy of KeyTermModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeyTermModelImplCopyWith<_$KeyTermModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FactCheckModel _$FactCheckModelFromJson(Map<String, dynamic> json) {
  return _FactCheckModel.fromJson(json);
}

/// @nodoc
mixin _$FactCheckModel {
  String get status => throw _privateConstructorUsedError;
  String get details => throw _privateConstructorUsedError;

  /// Serializes this FactCheckModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FactCheckModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FactCheckModelCopyWith<FactCheckModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FactCheckModelCopyWith<$Res> {
  factory $FactCheckModelCopyWith(
          FactCheckModel value, $Res Function(FactCheckModel) then) =
      _$FactCheckModelCopyWithImpl<$Res, FactCheckModel>;
  @useResult
  $Res call({String status, String details});
}

/// @nodoc
class _$FactCheckModelCopyWithImpl<$Res, $Val extends FactCheckModel>
    implements $FactCheckModelCopyWith<$Res> {
  _$FactCheckModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FactCheckModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? details = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FactCheckModelImplCopyWith<$Res>
    implements $FactCheckModelCopyWith<$Res> {
  factory _$$FactCheckModelImplCopyWith(_$FactCheckModelImpl value,
          $Res Function(_$FactCheckModelImpl) then) =
      __$$FactCheckModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String details});
}

/// @nodoc
class __$$FactCheckModelImplCopyWithImpl<$Res>
    extends _$FactCheckModelCopyWithImpl<$Res, _$FactCheckModelImpl>
    implements _$$FactCheckModelImplCopyWith<$Res> {
  __$$FactCheckModelImplCopyWithImpl(
      _$FactCheckModelImpl _value, $Res Function(_$FactCheckModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FactCheckModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? details = null,
  }) {
    return _then(_$FactCheckModelImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FactCheckModelImpl implements _FactCheckModel {
  const _$FactCheckModelImpl({required this.status, required this.details});

  factory _$FactCheckModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FactCheckModelImplFromJson(json);

  @override
  final String status;
  @override
  final String details;

  @override
  String toString() {
    return 'FactCheckModel(status: $status, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FactCheckModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.details, details) || other.details == details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, details);

  /// Create a copy of FactCheckModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FactCheckModelImplCopyWith<_$FactCheckModelImpl> get copyWith =>
      __$$FactCheckModelImplCopyWithImpl<_$FactCheckModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FactCheckModelImplToJson(
      this,
    );
  }
}

abstract class _FactCheckModel implements FactCheckModel {
  const factory _FactCheckModel(
      {required final String status,
      required final String details}) = _$FactCheckModelImpl;

  factory _FactCheckModel.fromJson(Map<String, dynamic> json) =
      _$FactCheckModelImpl.fromJson;

  @override
  String get status;
  @override
  String get details;

  /// Create a copy of FactCheckModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FactCheckModelImplCopyWith<_$FactCheckModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SourceModel _$SourceModelFromJson(Map<String, dynamic> json) {
  return _SourceModel.fromJson(json);
}

/// @nodoc
mixin _$SourceModel {
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  /// Serializes this SourceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SourceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SourceModelCopyWith<SourceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceModelCopyWith<$Res> {
  factory $SourceModelCopyWith(
          SourceModel value, $Res Function(SourceModel) then) =
      _$SourceModelCopyWithImpl<$Res, SourceModel>;
  @useResult
  $Res call({String title, String url});
}

/// @nodoc
class _$SourceModelCopyWithImpl<$Res, $Val extends SourceModel>
    implements $SourceModelCopyWith<$Res> {
  _$SourceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SourceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SourceModelImplCopyWith<$Res>
    implements $SourceModelCopyWith<$Res> {
  factory _$$SourceModelImplCopyWith(
          _$SourceModelImpl value, $Res Function(_$SourceModelImpl) then) =
      __$$SourceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String url});
}

/// @nodoc
class __$$SourceModelImplCopyWithImpl<$Res>
    extends _$SourceModelCopyWithImpl<$Res, _$SourceModelImpl>
    implements _$$SourceModelImplCopyWith<$Res> {
  __$$SourceModelImplCopyWithImpl(
      _$SourceModelImpl _value, $Res Function(_$SourceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SourceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
  }) {
    return _then(_$SourceModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SourceModelImpl implements _SourceModel {
  const _$SourceModelImpl({required this.title, required this.url});

  factory _$SourceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SourceModelImplFromJson(json);

  @override
  final String title;
  @override
  final String url;

  @override
  String toString() {
    return 'SourceModel(title: $title, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, url);

  /// Create a copy of SourceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceModelImplCopyWith<_$SourceModelImpl> get copyWith =>
      __$$SourceModelImplCopyWithImpl<_$SourceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SourceModelImplToJson(
      this,
    );
  }
}

abstract class _SourceModel implements SourceModel {
  const factory _SourceModel(
      {required final String title,
      required final String url}) = _$SourceModelImpl;

  factory _SourceModel.fromJson(Map<String, dynamic> json) =
      _$SourceModelImpl.fromJson;

  @override
  String get title;
  @override
  String get url;

  /// Create a copy of SourceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SourceModelImplCopyWith<_$SourceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PerspectiveModel _$PerspectiveModelFromJson(Map<String, dynamic> json) {
  return _PerspectiveModel.fromJson(json);
}

/// @nodoc
mixin _$PerspectiveModel {
  String get expert => throw _privateConstructorUsedError;
  String get viewpoint => throw _privateConstructorUsedError;

  /// Serializes this PerspectiveModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PerspectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PerspectiveModelCopyWith<PerspectiveModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerspectiveModelCopyWith<$Res> {
  factory $PerspectiveModelCopyWith(
          PerspectiveModel value, $Res Function(PerspectiveModel) then) =
      _$PerspectiveModelCopyWithImpl<$Res, PerspectiveModel>;
  @useResult
  $Res call({String expert, String viewpoint});
}

/// @nodoc
class _$PerspectiveModelCopyWithImpl<$Res, $Val extends PerspectiveModel>
    implements $PerspectiveModelCopyWith<$Res> {
  _$PerspectiveModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PerspectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expert = null,
    Object? viewpoint = null,
  }) {
    return _then(_value.copyWith(
      expert: null == expert
          ? _value.expert
          : expert // ignore: cast_nullable_to_non_nullable
              as String,
      viewpoint: null == viewpoint
          ? _value.viewpoint
          : viewpoint // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PerspectiveModelImplCopyWith<$Res>
    implements $PerspectiveModelCopyWith<$Res> {
  factory _$$PerspectiveModelImplCopyWith(_$PerspectiveModelImpl value,
          $Res Function(_$PerspectiveModelImpl) then) =
      __$$PerspectiveModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String expert, String viewpoint});
}

/// @nodoc
class __$$PerspectiveModelImplCopyWithImpl<$Res>
    extends _$PerspectiveModelCopyWithImpl<$Res, _$PerspectiveModelImpl>
    implements _$$PerspectiveModelImplCopyWith<$Res> {
  __$$PerspectiveModelImplCopyWithImpl(_$PerspectiveModelImpl _value,
      $Res Function(_$PerspectiveModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PerspectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expert = null,
    Object? viewpoint = null,
  }) {
    return _then(_$PerspectiveModelImpl(
      expert: null == expert
          ? _value.expert
          : expert // ignore: cast_nullable_to_non_nullable
              as String,
      viewpoint: null == viewpoint
          ? _value.viewpoint
          : viewpoint // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PerspectiveModelImpl implements _PerspectiveModel {
  const _$PerspectiveModelImpl({required this.expert, required this.viewpoint});

  factory _$PerspectiveModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PerspectiveModelImplFromJson(json);

  @override
  final String expert;
  @override
  final String viewpoint;

  @override
  String toString() {
    return 'PerspectiveModel(expert: $expert, viewpoint: $viewpoint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerspectiveModelImpl &&
            (identical(other.expert, expert) || other.expert == expert) &&
            (identical(other.viewpoint, viewpoint) ||
                other.viewpoint == viewpoint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, expert, viewpoint);

  /// Create a copy of PerspectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerspectiveModelImplCopyWith<_$PerspectiveModelImpl> get copyWith =>
      __$$PerspectiveModelImplCopyWithImpl<_$PerspectiveModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PerspectiveModelImplToJson(
      this,
    );
  }
}

abstract class _PerspectiveModel implements PerspectiveModel {
  const factory _PerspectiveModel(
      {required final String expert,
      required final String viewpoint}) = _$PerspectiveModelImpl;

  factory _PerspectiveModel.fromJson(Map<String, dynamic> json) =
      _$PerspectiveModelImpl.fromJson;

  @override
  String get expert;
  @override
  String get viewpoint;

  /// Create a copy of PerspectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerspectiveModelImplCopyWith<_$PerspectiveModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
