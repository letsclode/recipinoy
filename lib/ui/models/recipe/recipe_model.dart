// This file is "main.dart"
import 'package:flavorsph/ui/models/ingredient/ingredient_model.dart';
import 'package:flavorsph/ui/models/tutorial_step/tutorial_step_model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_model.freezed.dart';
part 'recipe_model.g.dart';

@freezed
class RecipeModel with _$RecipeModel {
  const factory RecipeModel(
    String? title,
    String? photo,
    String? time,
    String? description,
    double? similarity,
    List<IngredientModel>? ingridients,
    List<TutorialStepModel>? tutorial,
  ) = _RecipeModel;

  factory RecipeModel.fromJson(Map<String, Object?> json) =>
      _$RecipeModelFromJson(json);
}
