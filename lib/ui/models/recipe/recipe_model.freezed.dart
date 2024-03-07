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
  String? get description => throw _privateConstructorUsedError;
  String? get time => throw _privateConstructorUsedError;
  double? get similarity => throw _privateConstructorUsedError;
  List<String>? get sliceIngre => throw _privateConstructorUsedError;
  List<String>? get sliceIns => throw _privateConstructorUsedError;
  List<String>? get ingredients => throw _privateConstructorUsedError;

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
      String? description,
      String? time,
      double? similarity,
      List<String>? sliceIngre,
      List<String>? sliceIns,
      List<String>? ingredients});
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
    Object? description = freezed,
    Object? time = freezed,
    Object? similarity = freezed,
    Object? sliceIngre = freezed,
    Object? sliceIns = freezed,
    Object? ingredients = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      similarity: freezed == similarity
          ? _value.similarity
          : similarity // ignore: cast_nullable_to_non_nullable
              as double?,
      sliceIngre: freezed == sliceIngre
          ? _value.sliceIngre
          : sliceIngre // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      sliceIns: freezed == sliceIns
          ? _value.sliceIns
          : sliceIns // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      ingredients: freezed == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
      String? description,
      String? time,
      double? similarity,
      List<String>? sliceIngre,
      List<String>? sliceIns,
      List<String>? ingredients});
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
    Object? description = freezed,
    Object? time = freezed,
    Object? similarity = freezed,
    Object? sliceIngre = freezed,
    Object? sliceIns = freezed,
    Object? ingredients = freezed,
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
      freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == similarity
          ? _value.similarity
          : similarity // ignore: cast_nullable_to_non_nullable
              as double?,
      freezed == sliceIngre
          ? _value._sliceIngre
          : sliceIngre // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      freezed == sliceIns
          ? _value._sliceIns
          : sliceIns // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      freezed == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeModelImpl implements _RecipeModel {
  const _$RecipeModelImpl(
      this.title,
      this.photo,
      this.description,
      this.time,
      this.similarity,
      final List<String>? sliceIngre,
      final List<String>? sliceIns,
      final List<String>? ingredients)
      : _sliceIngre = sliceIngre,
        _sliceIns = sliceIns,
        _ingredients = ingredients;

  factory _$RecipeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeModelImplFromJson(json);

  @override
  final String? title;
  @override
  final String? photo;
  @override
  final String? description;
  @override
  final String? time;
  @override
  final double? similarity;
  final List<String>? _sliceIngre;
  @override
  List<String>? get sliceIngre {
    final value = _sliceIngre;
    if (value == null) return null;
    if (_sliceIngre is EqualUnmodifiableListView) return _sliceIngre;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _sliceIns;
  @override
  List<String>? get sliceIns {
    final value = _sliceIns;
    if (value == null) return null;
    if (_sliceIns is EqualUnmodifiableListView) return _sliceIns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _ingredients;
  @override
  List<String>? get ingredients {
    final value = _ingredients;
    if (value == null) return null;
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'RecipeModel(title: $title, photo: $photo, description: $description, time: $time, similarity: $similarity, sliceIngre: $sliceIngre, sliceIns: $sliceIns, ingredients: $ingredients)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.similarity, similarity) ||
                other.similarity == similarity) &&
            const DeepCollectionEquality()
                .equals(other._sliceIngre, _sliceIngre) &&
            const DeepCollectionEquality().equals(other._sliceIns, _sliceIns) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      photo,
      description,
      time,
      similarity,
      const DeepCollectionEquality().hash(_sliceIngre),
      const DeepCollectionEquality().hash(_sliceIns),
      const DeepCollectionEquality().hash(_ingredients));

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
      final String? description,
      final String? time,
      final double? similarity,
      final List<String>? sliceIngre,
      final List<String>? sliceIns,
      final List<String>? ingredients) = _$RecipeModelImpl;

  factory _RecipeModel.fromJson(Map<String, dynamic> json) =
      _$RecipeModelImpl.fromJson;

  @override
  String? get title;
  @override
  String? get photo;
  @override
  String? get description;
  @override
  String? get time;
  @override
  double? get similarity;
  @override
  List<String>? get sliceIngre;
  @override
  List<String>? get sliceIns;
  @override
  List<String>? get ingredients;
  @override
  @JsonKey(ignore: true)
  _$$RecipeModelImplCopyWith<_$RecipeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
