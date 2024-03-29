// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportModelImpl _$$ReportModelImplFromJson(Map<String, dynamic> json) =>
    _$ReportModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      userId: json['userId'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      isVerified: json['isVerified'] as bool,
      verifiedDate: json['verifiedDate'] == null
          ? null
          : DateTime.parse(json['verifiedDate'] as String),
      completedDate: json['completedDate'] == null
          ? null
          : DateTime.parse(json['completedDate'] as String),
      rejectedDate: json['rejectedDate'] == null
          ? null
          : DateTime.parse(json['rejectedDate'] as String),
      type: json['type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      reason: json['reason'] as String?,
      imageUrl: json['imageUrl'] as String?,
      updates: (json['updates'] as List<dynamic>)
          .map((e) => UpdateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: json['address'] as String,
      landmark: json['landmark'] as String,
      ratings: (json['ratings'] as num?)?.toDouble(),
      position: json['position'],
    );

Map<String, dynamic> _$$ReportModelImplToJson(_$ReportModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'userId': instance.userId,
      'description': instance.description,
      'status': instance.status,
      'isVerified': instance.isVerified,
      'verifiedDate': instance.verifiedDate?.toIso8601String(),
      'completedDate': instance.completedDate?.toIso8601String(),
      'rejectedDate': instance.rejectedDate?.toIso8601String(),
      'type': instance.type,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'reason': instance.reason,
      'imageUrl': instance.imageUrl,
      'updates': instance.updates,
      'address': instance.address,
      'landmark': instance.landmark,
      'ratings': instance.ratings,
      'position': instance.position,
    };
