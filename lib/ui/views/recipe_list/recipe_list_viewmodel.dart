import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/recipe_generator_service.dart';

class RecipeListViewModel extends BaseViewModel {
  TextEditingController searchInputController = TextEditingController();

  final _recipeGeneratorService = locator<RecipeGeneratorService>();

  List<RecipeModel> _recipes = [];
  List<RecipeModel> _suggested = [];
  List<RecipeModel> get recipes => _recipes;

  List<RecipeModel> get suggested => _suggested;

  Future<void> generateRecipe({required List<String> ingredients}) async {
    print('INPUT : $ingredients');
    _recipes =
        await _recipeGeneratorService.generate(inputIngredients: ingredients);

    notifyListeners();
  }

  Future<void> generateSuggestedRecipe(
      {required List<String> ingredients}) async {
    print('INPUT : $ingredients');
    _suggested = await _recipeGeneratorService.generateSuggested(
        inputIngredients: ingredients);

    notifyListeners();
  }

  Future<List<RecipeModel>> getRecipe() async {
    return _recipes;
  }

  Future<List<RecipeModel>> getSuggested() async {
    return _suggested;
  }
}
