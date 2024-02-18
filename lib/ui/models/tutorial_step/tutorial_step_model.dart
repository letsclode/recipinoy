// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tutorial_step_model.freezed.dart';
part 'tutorial_step_model.g.dart';

@freezed
class TutorialStepModel with _$TutorialStepModel {
  const factory TutorialStepModel({
    String? step,
    String? description,
  }) = _TutorialStepModel;

  factory TutorialStepModel.fromJson(Map<String, Object?> json) =>
      _$TutorialStepModelFromJson(json);
}
