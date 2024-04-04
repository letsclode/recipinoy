// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedbackModelImpl _$$FeedbackModelImplFromJson(Map<String, dynamic> json) =>
    _$FeedbackModelImpl(
      user: json['user'] as String,
      text: json['text'] as String,
      screenshot: json['screenshot'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$FeedbackModelImplToJson(_$FeedbackModelImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'text': instance.text,
      'screenshot': instance.screenshot,
      'id': instance.id,
    };
