import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient_model.freezed.dart';
part 'ingredient_model.g.dart';

@freezed
class IngredientModel with _$IngredientModel {
  const factory IngredientModel({
    String? name,
    String? size,
  }) = _IngredientModel;

  factory IngredientModel.fromJson(Map<String, Object?> json) =>
      _$IngredientModelFromJson(json);
}
