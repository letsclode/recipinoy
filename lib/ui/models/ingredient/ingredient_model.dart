// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient_model.freezed.dart';
part 'ingredient_model.g.dart';

@freezed
class IngredientModel with _$IngredientModel {
  const factory IngredientModel({
    required String title,
    String? id,
    String? createdBy,
  }) = _IngredientModel;

  factory IngredientModel.fromJson(Map<String, Object?> json) =>
      _$IngredientModelFromJson(json);
}
