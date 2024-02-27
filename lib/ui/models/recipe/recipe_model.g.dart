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
      (json['similarity'] as num?)?.toDouble(),
      (json['sliceIngre'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['sliceIns'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['ingredients'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$RecipeModelImplToJson(_$RecipeModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'photo': instance.photo,
      'time': instance.time,
      'similarity': instance.similarity,
      'sliceIngre': instance.sliceIngre,
      'sliceIns': instance.sliceIns,
      'ingredients': instance.ingredients,
    };
