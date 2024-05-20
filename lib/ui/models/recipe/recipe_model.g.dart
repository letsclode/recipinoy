// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeModelImpl _$$RecipeModelImplFromJson(Map<String, dynamic> json) =>
    _$RecipeModelImpl(
      id: json['id'] as String?,
      createdBy: json['createdBy'] as String?,
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
      likes:
          (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$RecipeModelImplToJson(_$RecipeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdBy': instance.createdBy,
      'title': instance.title,
      'photo': instance.photo,
      'description': instance.description,
      'time': instance.time,
      'similarity': instance.similarity,
      'sliceIngre': instance.sliceIngre,
      'sliceIns': instance.sliceIns,
      'likes': instance.likes,
    };
