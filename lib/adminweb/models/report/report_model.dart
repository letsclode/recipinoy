import 'package:freezed_annotation/freezed_annotation.dart';

import '../update_model/update_model.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

@freezed
class ReportModel with _$ReportModel {
  factory ReportModel(
      {required String id,
      required String title,
      required String userId,
      required String description,
      required String status,
      required bool isVerified,
      DateTime? verifiedDate,
      DateTime? completedDate,
      DateTime? rejectedDate,
      required String type,
      required DateTime createdAt,
      required DateTime updatedAt,
      String? reason,
      String? imageUrl,
      required List<UpdateModel> updates,
      required String address,
      required String landmark,
      double? ratings,
      required dynamic position}) = _ReportModel;

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);
}
