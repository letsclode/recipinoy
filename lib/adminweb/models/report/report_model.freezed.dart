// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) {
  return _ReportModel.fromJson(json);
}

/// @nodoc
mixin _$ReportModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  DateTime? get verifiedDate => throw _privateConstructorUsedError;
  DateTime? get completedDate => throw _privateConstructorUsedError;
  DateTime? get rejectedDate => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<UpdateModel> get updates => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get landmark => throw _privateConstructorUsedError;
  double? get ratings => throw _privateConstructorUsedError;
  dynamic get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportModelCopyWith<ReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportModelCopyWith<$Res> {
  factory $ReportModelCopyWith(
          ReportModel value, $Res Function(ReportModel) then) =
      _$ReportModelCopyWithImpl<$Res, ReportModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String userId,
      String description,
      String status,
      bool isVerified,
      DateTime? verifiedDate,
      DateTime? completedDate,
      DateTime? rejectedDate,
      String type,
      DateTime createdAt,
      DateTime updatedAt,
      String? reason,
      String? imageUrl,
      List<UpdateModel> updates,
      String address,
      String landmark,
      double? ratings,
      dynamic position});
}

/// @nodoc
class _$ReportModelCopyWithImpl<$Res, $Val extends ReportModel>
    implements $ReportModelCopyWith<$Res> {
  _$ReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? userId = null,
    Object? description = null,
    Object? status = null,
    Object? isVerified = null,
    Object? verifiedDate = freezed,
    Object? completedDate = freezed,
    Object? rejectedDate = freezed,
    Object? type = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? reason = freezed,
    Object? imageUrl = freezed,
    Object? updates = null,
    Object? address = null,
    Object? landmark = null,
    Object? ratings = freezed,
    Object? position = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      verifiedDate: freezed == verifiedDate
          ? _value.verifiedDate
          : verifiedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedDate: freezed == completedDate
          ? _value.completedDate
          : completedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectedDate: freezed == rejectedDate
          ? _value.rejectedDate
          : rejectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      updates: null == updates
          ? _value.updates
          : updates // ignore: cast_nullable_to_non_nullable
              as List<UpdateModel>,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      landmark: null == landmark
          ? _value.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String,
      ratings: freezed == ratings
          ? _value.ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as double?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportModelImplCopyWith<$Res>
    implements $ReportModelCopyWith<$Res> {
  factory _$$ReportModelImplCopyWith(
          _$ReportModelImpl value, $Res Function(_$ReportModelImpl) then) =
      __$$ReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String userId,
      String description,
      String status,
      bool isVerified,
      DateTime? verifiedDate,
      DateTime? completedDate,
      DateTime? rejectedDate,
      String type,
      DateTime createdAt,
      DateTime updatedAt,
      String? reason,
      String? imageUrl,
      List<UpdateModel> updates,
      String address,
      String landmark,
      double? ratings,
      dynamic position});
}

/// @nodoc
class __$$ReportModelImplCopyWithImpl<$Res>
    extends _$ReportModelCopyWithImpl<$Res, _$ReportModelImpl>
    implements _$$ReportModelImplCopyWith<$Res> {
  __$$ReportModelImplCopyWithImpl(
      _$ReportModelImpl _value, $Res Function(_$ReportModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? userId = null,
    Object? description = null,
    Object? status = null,
    Object? isVerified = null,
    Object? verifiedDate = freezed,
    Object? completedDate = freezed,
    Object? rejectedDate = freezed,
    Object? type = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? reason = freezed,
    Object? imageUrl = freezed,
    Object? updates = null,
    Object? address = null,
    Object? landmark = null,
    Object? ratings = freezed,
    Object? position = freezed,
  }) {
    return _then(_$ReportModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      verifiedDate: freezed == verifiedDate
          ? _value.verifiedDate
          : verifiedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedDate: freezed == completedDate
          ? _value.completedDate
          : completedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectedDate: freezed == rejectedDate
          ? _value.rejectedDate
          : rejectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      updates: null == updates
          ? _value._updates
          : updates // ignore: cast_nullable_to_non_nullable
              as List<UpdateModel>,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      landmark: null == landmark
          ? _value.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String,
      ratings: freezed == ratings
          ? _value.ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as double?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportModelImpl implements _ReportModel {
  _$ReportModelImpl(
      {required this.id,
      required this.title,
      required this.userId,
      required this.description,
      required this.status,
      required this.isVerified,
      this.verifiedDate,
      this.completedDate,
      this.rejectedDate,
      required this.type,
      required this.createdAt,
      required this.updatedAt,
      this.reason,
      this.imageUrl,
      required final List<UpdateModel> updates,
      required this.address,
      required this.landmark,
      this.ratings,
      required this.position})
      : _updates = updates;

  factory _$ReportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String userId;
  @override
  final String description;
  @override
  final String status;
  @override
  final bool isVerified;
  @override
  final DateTime? verifiedDate;
  @override
  final DateTime? completedDate;
  @override
  final DateTime? rejectedDate;
  @override
  final String type;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String? reason;
  @override
  final String? imageUrl;
  final List<UpdateModel> _updates;
  @override
  List<UpdateModel> get updates {
    if (_updates is EqualUnmodifiableListView) return _updates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_updates);
  }

  @override
  final String address;
  @override
  final String landmark;
  @override
  final double? ratings;
  @override
  final dynamic position;

  @override
  String toString() {
    return 'ReportModel(id: $id, title: $title, userId: $userId, description: $description, status: $status, isVerified: $isVerified, verifiedDate: $verifiedDate, completedDate: $completedDate, rejectedDate: $rejectedDate, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, reason: $reason, imageUrl: $imageUrl, updates: $updates, address: $address, landmark: $landmark, ratings: $ratings, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.verifiedDate, verifiedDate) ||
                other.verifiedDate == verifiedDate) &&
            (identical(other.completedDate, completedDate) ||
                other.completedDate == completedDate) &&
            (identical(other.rejectedDate, rejectedDate) ||
                other.rejectedDate == rejectedDate) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._updates, _updates) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.landmark, landmark) ||
                other.landmark == landmark) &&
            (identical(other.ratings, ratings) || other.ratings == ratings) &&
            const DeepCollectionEquality().equals(other.position, position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        userId,
        description,
        status,
        isVerified,
        verifiedDate,
        completedDate,
        rejectedDate,
        type,
        createdAt,
        updatedAt,
        reason,
        imageUrl,
        const DeepCollectionEquality().hash(_updates),
        address,
        landmark,
        ratings,
        const DeepCollectionEquality().hash(position)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportModelImplCopyWith<_$ReportModelImpl> get copyWith =>
      __$$ReportModelImplCopyWithImpl<_$ReportModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportModelImplToJson(
      this,
    );
  }
}

abstract class _ReportModel implements ReportModel {
  factory _ReportModel(
      {required final String id,
      required final String title,
      required final String userId,
      required final String description,
      required final String status,
      required final bool isVerified,
      final DateTime? verifiedDate,
      final DateTime? completedDate,
      final DateTime? rejectedDate,
      required final String type,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final String? reason,
      final String? imageUrl,
      required final List<UpdateModel> updates,
      required final String address,
      required final String landmark,
      final double? ratings,
      required final dynamic position}) = _$ReportModelImpl;

  factory _ReportModel.fromJson(Map<String, dynamic> json) =
      _$ReportModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get userId;
  @override
  String get description;
  @override
  String get status;
  @override
  bool get isVerified;
  @override
  DateTime? get verifiedDate;
  @override
  DateTime? get completedDate;
  @override
  DateTime? get rejectedDate;
  @override
  String get type;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String? get reason;
  @override
  String? get imageUrl;
  @override
  List<UpdateModel> get updates;
  @override
  String get address;
  @override
  String get landmark;
  @override
  double? get ratings;
  @override
  dynamic get position;
  @override
  @JsonKey(ignore: true)
  _$$ReportModelImplCopyWith<_$ReportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
