// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateModel _$UpdateModelFromJson(Map<String, dynamic> json) {
  return _UpdateModel.fromJson(json);
}

/// @nodoc
mixin _$UpdateModel {
  String get description => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateModelCopyWith<UpdateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateModelCopyWith<$Res> {
  factory $UpdateModelCopyWith(
          UpdateModel value, $Res Function(UpdateModel) then) =
      _$UpdateModelCopyWithImpl<$Res, UpdateModel>;
  @useResult
  $Res call({String description, String image, DateTime createdAt});
}

/// @nodoc
class _$UpdateModelCopyWithImpl<$Res, $Val extends UpdateModel>
    implements $UpdateModelCopyWith<$Res> {
  _$UpdateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? image = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateModelImplCopyWith<$Res>
    implements $UpdateModelCopyWith<$Res> {
  factory _$$UpdateModelImplCopyWith(
          _$UpdateModelImpl value, $Res Function(_$UpdateModelImpl) then) =
      __$$UpdateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String description, String image, DateTime createdAt});
}

/// @nodoc
class __$$UpdateModelImplCopyWithImpl<$Res>
    extends _$UpdateModelCopyWithImpl<$Res, _$UpdateModelImpl>
    implements _$$UpdateModelImplCopyWith<$Res> {
  __$$UpdateModelImplCopyWithImpl(
      _$UpdateModelImpl _value, $Res Function(_$UpdateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? image = null,
    Object? createdAt = null,
  }) {
    return _then(_$UpdateModelImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateModelImpl implements _UpdateModel {
  _$UpdateModelImpl(
      {required this.description,
      required this.image,
      required this.createdAt});

  factory _$UpdateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateModelImplFromJson(json);

  @override
  final String description;
  @override
  final String image;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'UpdateModel(description: $description, image: $image, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateModelImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, description, image, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateModelImplCopyWith<_$UpdateModelImpl> get copyWith =>
      __$$UpdateModelImplCopyWithImpl<_$UpdateModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateModelImplToJson(
      this,
    );
  }
}

abstract class _UpdateModel implements UpdateModel {
  factory _UpdateModel(
      {required final String description,
      required final String image,
      required final DateTime createdAt}) = _$UpdateModelImpl;

  factory _UpdateModel.fromJson(Map<String, dynamic> json) =
      _$UpdateModelImpl.fromJson;

  @override
  String get description;
  @override
  String get image;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$UpdateModelImplCopyWith<_$UpdateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
