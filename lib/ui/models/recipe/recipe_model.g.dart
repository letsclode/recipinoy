// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeModelImpl _$$RecipeModelImplFromJson(Map<String, dynamic> json) =>
    _$RecipeModelImpl(
      id: json['id'] as String?,
      title: json['title'] as String?,
      photo: json['photo'] as String?,
      description: json['description'] as String?,
      time: json['time'] as String?,
      similarity: (json['similarity'] as num?)?.toDouble(),
      sliceIngre: (json['sliceIngre'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sliceIns: (json['sliceIns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ingredients: json['ingredients'] as List<dynamic>?,
      isSave: json['isSave'] as bool? ?? false,
    );

Map<String, dynamic> _$$RecipeModelImplToJson(_$RecipeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'photo': instance.photo,
      'description': instance.description,
      'time': instance.time,
      'similarity': instance.similarity,
      'sliceIngre': instance.sliceIngre,
      'sliceIns': instance.sliceIns,
      'ingredients': instance.ingredients,
      'isSave': instance.isSave,
    };
