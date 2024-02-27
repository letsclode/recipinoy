// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateModelImpl _$$UpdateModelImplFromJson(Map<String, dynamic> json) =>
    _$UpdateModelImpl(
      description: json['description'] as String,
      image: json['image'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UpdateModelImplToJson(_$UpdateModelImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'image': instance.image,
      'createdAt': instance.createdAt.toIso8601String(),
    };
