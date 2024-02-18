// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeModelImpl _$$RecipeModelImplFromJson(Map<String, dynamic> json) =>
    _$RecipeModelImpl(
      json['title'] as String?,
      json['photo'] as String?,
      json['time'] as String?,
      json['description'] as String?,
      (json['similarity'] as num?)?.toDouble(),
      (json['ingridients'] as List<dynamic>?)
          ?.map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['tutorial'] as List<dynamic>?)
          ?.map((e) => TutorialStepModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RecipeModelImplToJson(_$RecipeModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'photo': instance.photo,
      'time': instance.time,
      'description': instance.description,
      'similarity': instance.similarity,
      'ingridients': instance.ingridients,
      'tutorial': instance.tutorial,
    };
