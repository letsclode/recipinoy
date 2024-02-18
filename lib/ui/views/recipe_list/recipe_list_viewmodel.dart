import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/recipe_generator_service.dart';

class RecipeListViewModel extends BaseViewModel {
  //TODO: create service
  TextEditingController searchInputController = TextEditingController();

  final _recipeGeneratorService = locator<RecipeGeneratorService>();

  Future<List<RecipeModel>> generateRecipe(
      {required List<String> ingredients}) async {
    print('INPUT : $ingredients');
    return await _recipeGeneratorService.generate(
        inputIngredients: ingredients);
  }
}
