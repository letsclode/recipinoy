import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/recipe_generator_service.dart';

class RecipeListViewModel extends BaseViewModel {
  // final FirestoreService _firestoreService = locator<FirestoreService>();

  TextEditingController searchInputController = TextEditingController();

  final _recipeGeneratorService = locator<RecipeGeneratorService>();

  late List<RecipeModel> _recipes;
  List<RecipeModel> get recipes => _recipes;

  Future<List<RecipeModel>> generateRecipe(
      {required List<String> ingredients}) async {
    print('INPUT : $ingredients');
    return await _recipeGeneratorService.generate(
        inputIngredients: ingredients);
  }

  // Future<List<RecipeModel>> fetchRecipes() async {
  //   try {
  //     // TODO: Find or Create a TaskType that will automaticall do the setBusy(true/false) when being run.
  //     List<RecipeModel> postsResults = await _firestoreService.getRecipes();
  //     return postsResults;
  //   } catch (e) {
  //     print(e);
  //   }
  //   return [];
  // }
}
