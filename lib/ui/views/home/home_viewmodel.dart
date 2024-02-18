import 'package:flavorsph/app/app.locator.dart';
import 'package:flavorsph/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  //TODO: put in service
  TextEditingController searchInputController = TextEditingController();
  FocusNode focusNode = FocusNode();

  List<String> ingredients = [];

  bool get addIngredientButtonIsDisable => searchInputController.text == "";

  bool get ingredientsEmpty => ingredients.isEmpty;

  void addIngredient({required BuildContext context}) {
    final newIngredient = searchInputController.text;

    if (ingredients.contains(newIngredient)) {
      // Show a toast message using ScaffoldMessenger
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$newIngredient is already in the list."),
        ),
      );
    } else {
      ingredients = [...ingredients, newIngredient];
      searchInputController.clear();
      focusNode.unfocus();
      rebuildUi();
    }
  }

  void removeIngredient({required String ingredientToRemove}) {
    ingredients = ingredients
        .where((ingredient) => ingredient != ingredientToRemove)
        .toList();
    rebuildUi();
  }

  void goToGeneratePage() {
    _navigationService.navigateToRecipeListView(ingredients: ingredients);
  }
}
