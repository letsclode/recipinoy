// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_model.freezed.dart';
part 'recipe_model.g.dart';

@freezed
class RecipeModel with _$RecipeModel {
  const factory RecipeModel(
    String? title,
    String? photo,
    String? time,
    double? similarity,
    List<String>? sliceIngre,
    List<String>? sliceIns,
    List<String>? ingredients,
  ) = _RecipeModel;

  factory RecipeModel.fromJson(Map<String, Object?> json) =>
      _$RecipeModelFromJson(json);
}
