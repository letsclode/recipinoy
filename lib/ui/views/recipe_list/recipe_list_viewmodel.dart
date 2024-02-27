import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/firestore_service.dart';
import '../../../services/recipe_generator_service.dart';

class RecipeListViewModel extends BaseViewModel {
  //TODO: create service
  final FirestoreService _firestoreService = locator<FirestoreService>();

  final DialogService _dialogService = locator<DialogService>();

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

  Future<List<RecipeModel>> fetchRecipes() async {
    setBusy(true);
    // TODO: Find or Create a TaskType that will automaticall do the setBusy(true/false) when being run.
    var postsResults = await _firestoreService.getRecipes();
    setBusy(false);

    if (postsResults is List<RecipeModel>) {
      _recipes = postsResults;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'Posts Update Failed',
        description: postsResults,
      );
    }
    return _recipes;
  }
}
