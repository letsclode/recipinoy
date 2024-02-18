// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) {
  return _RecipeModel.fromJson(json);
}

/// @nodoc
mixin _$RecipeModel {
  String? get title => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  String? get time => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double? get similarity => throw _privateConstructorUsedError;
  List<IngredientModel>? get ingridients => throw _privateConstructorUsedError;
  List<TutorialStepModel>? get tutorial => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeModelCopyWith<RecipeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeModelCopyWith<$Res> {
  factory $RecipeModelCopyWith(
          RecipeModel value, $Res Function(RecipeModel) then) =
      _$RecipeModelCopyWithImpl<$Res, RecipeModel>;
  @useResult
  $Res call(
      {String? title,
      String? photo,
      String? time,
      String? description,
      double? similarity,
      List<IngredientModel>? ingridients,
      List<TutorialStepModel>? tutorial});
}

/// @nodoc
class _$RecipeModelCopyWithImpl<$Res, $Val extends RecipeModel>
    implements $RecipeModelCopyWith<$Res> {
  _$RecipeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? photo = freezed,
    Object? time = freezed,
    Object? description = freezed,
    Object? similarity = freezed,
    Object? ingridients = freezed,
    Object? tutorial = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      similarity: freezed == similarity
          ? _value.similarity
          : similarity // ignore: cast_nullable_to_non_nullable
              as double?,
      ingridients: freezed == ingridients
          ? _value.ingridients
          : ingridients // ignore: cast_nullable_to_non_nullable
              as List<IngredientModel>?,
      tutorial: freezed == tutorial
          ? _value.tutorial
          : tutorial // ignore: cast_nullable_to_non_nullable
              as List<TutorialStepModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeModelImplCopyWith<$Res>
    implements $RecipeModelCopyWith<$Res> {
  factory _$$RecipeModelImplCopyWith(
          _$RecipeModelImpl value, $Res Function(_$RecipeModelImpl) then) =
      __$$RecipeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? photo,
      String? time,
      String? description,
      double? similarity,
      List<IngredientModel>? ingridients,
      List<TutorialStepModel>? tutorial});
}

/// @nodoc
class __$$RecipeModelImplCopyWithImpl<$Res>
    extends _$RecipeModelCopyWithImpl<$Res, _$RecipeModelImpl>
    implements _$$RecipeModelImplCopyWith<$Res> {
  __$$RecipeModelImplCopyWithImpl(
      _$RecipeModelImpl _value, $Res Function(_$RecipeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? photo = freezed,
    Object? time = freezed,
    Object? description = freezed,
    Object? similarity = freezed,
    Object? ingridients = freezed,
    Object? tutorial = freezed,
  }) {
    return _then(_$RecipeModelImpl(
      freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == similarity
          ? _value.similarity
          : similarity // ignore: cast_nullable_to_non_nullable
              as double?,
      freezed == ingridients
          ? _value._ingridients
          : ingridients // ignore: cast_nullable_to_non_nullable
              as List<IngredientModel>?,
      freezed == tutorial
          ? _value._tutorial
          : tutorial // ignore: cast_nullable_to_non_nullable
              as List<TutorialStepModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeModelImpl with DiagnosticableTreeMixin implements _RecipeModel {
  const _$RecipeModelImpl(
      this.title,
      this.photo,
      this.time,
      this.description,
      this.similarity,
      final List<IngredientModel>? ingridients,
      final List<TutorialStepModel>? tutorial)
      : _ingridients = ingridients,
        _tutorial = tutorial;

  factory _$RecipeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeModelImplFromJson(json);

  @override
  final String? title;
  @override
  final String? photo;
  @override
  final String? time;
  @override
  final String? description;
  @override
  final double? similarity;
  final List<IngredientModel>? _ingridients;
  @override
  List<IngredientModel>? get ingridients {
    final value = _ingridients;
    if (value == null) return null;
    if (_ingridients is EqualUnmodifiableListView) return _ingridients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TutorialStepModel>? _tutorial;
  @override
  List<TutorialStepModel>? get tutorial {
    final value = _tutorial;
    if (value == null) return null;
    if (_tutorial is EqualUnmodifiableListView) return _tutorial;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RecipeModel(title: $title, photo: $photo, time: $time, description: $description, similarity: $similarity, ingridients: $ingridients, tutorial: $tutorial)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RecipeModel'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('photo', photo))
      ..add(DiagnosticsProperty('time', time))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('similarity', similarity))
      ..add(DiagnosticsProperty('ingridients', ingridients))
      ..add(DiagnosticsProperty('tutorial', tutorial));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.similarity, similarity) ||
                other.similarity == similarity) &&
            const DeepCollectionEquality()
                .equals(other._ingridients, _ingridients) &&
            const DeepCollectionEquality().equals(other._tutorial, _tutorial));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      photo,
      time,
      description,
      similarity,
      const DeepCollectionEquality().hash(_ingridients),
      const DeepCollectionEquality().hash(_tutorial));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeModelImplCopyWith<_$RecipeModelImpl> get copyWith =>
      __$$RecipeModelImplCopyWithImpl<_$RecipeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeModelImplToJson(
      this,
    );
  }
}

abstract class _RecipeModel implements RecipeModel {
  const factory _RecipeModel(
      final String? title,
      final String? photo,
      final String? time,
      final String? description,
      final double? similarity,
      final List<IngredientModel>? ingridients,
      final List<TutorialStepModel>? tutorial) = _$RecipeModelImpl;

  factory _RecipeModel.fromJson(Map<String, dynamic> json) =
      _$RecipeModelImpl.fromJson;

  @override
  String? get title;
  @override
  String? get photo;
  @override
  String? get time;
  @override
  String? get description;
  @override
  double? get similarity;
  @override
  List<IngredientModel>? get ingridients;
  @override
  List<TutorialStepModel>? get tutorial;
  @override
  @JsonKey(ignore: true)
  _$$RecipeModelImplCopyWith<_$RecipeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
