// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tutorial_step_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TutorialStepModel _$TutorialStepModelFromJson(Map<String, dynamic> json) {
  return _TutorialStepModel.fromJson(json);
}

/// @nodoc
mixin _$TutorialStepModel {
  String? get step => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TutorialStepModelCopyWith<TutorialStepModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TutorialStepModelCopyWith<$Res> {
  factory $TutorialStepModelCopyWith(
          TutorialStepModel value, $Res Function(TutorialStepModel) then) =
      _$TutorialStepModelCopyWithImpl<$Res, TutorialStepModel>;
  @useResult
  $Res call({String? step, String? description});
}

/// @nodoc
class _$TutorialStepModelCopyWithImpl<$Res, $Val extends TutorialStepModel>
    implements $TutorialStepModelCopyWith<$Res> {
  _$TutorialStepModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      step: freezed == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TutorialStepModelImplCopyWith<$Res>
    implements $TutorialStepModelCopyWith<$Res> {
  factory _$$TutorialStepModelImplCopyWith(_$TutorialStepModelImpl value,
          $Res Function(_$TutorialStepModelImpl) then) =
      __$$TutorialStepModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? step, String? description});
}

/// @nodoc
class __$$TutorialStepModelImplCopyWithImpl<$Res>
    extends _$TutorialStepModelCopyWithImpl<$Res, _$TutorialStepModelImpl>
    implements _$$TutorialStepModelImplCopyWith<$Res> {
  __$$TutorialStepModelImplCopyWithImpl(_$TutorialStepModelImpl _value,
      $Res Function(_$TutorialStepModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = freezed,
    Object? description = freezed,
  }) {
    return _then(_$TutorialStepModelImpl(
      step: freezed == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TutorialStepModelImpl implements _TutorialStepModel {
  const _$TutorialStepModelImpl({this.step, this.description});

  factory _$TutorialStepModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TutorialStepModelImplFromJson(json);

  @override
  final String? step;
  @override
  final String? description;

  @override
  String toString() {
    return 'TutorialStepModel(step: $step, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TutorialStepModelImpl &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, step, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TutorialStepModelImplCopyWith<_$TutorialStepModelImpl> get copyWith =>
      __$$TutorialStepModelImplCopyWithImpl<_$TutorialStepModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TutorialStepModelImplToJson(
      this,
    );
  }
}

abstract class _TutorialStepModel implements TutorialStepModel {
  const factory _TutorialStepModel(
      {final String? step,
      final String? description}) = _$TutorialStepModelImpl;

  factory _TutorialStepModel.fromJson(Map<String, dynamic> json) =
      _$TutorialStepModelImpl.fromJson;

  @override
  String? get step;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$TutorialStepModelImplCopyWith<_$TutorialStepModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
