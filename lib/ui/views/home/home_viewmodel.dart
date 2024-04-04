import 'package:flavorsph/app/app.locator.dart';
import 'package:flavorsph/app/app.router.dart';
import 'package:flavorsph/ui/models/ingredient/ingredient_model.dart';
import 'package:flavorsph/ui/views/recipe_list/recipe_list_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  //TODO: put in service
  TextEditingController searchInputController = TextEditingController();
  FocusNode focusNode = FocusNode();

  final GlobalKey<ScaffoldState> key = GlobalKey();

  List<IngredientModel> availableIngredients = [
    IngredientModel(
        title: 'Cucumber',
        image: 'assets/images/ingredients/1-removebg-preview.png'),
    IngredientModel(
        title: 'Onion',
        image: 'assets/images/ingredients/2-removebg-preview.png'),
    IngredientModel(
        title: 'Green peas',
        image: 'assets/images/ingredients/3-removebg-preview.png'),
    IngredientModel(
        title: 'Bell pepper',
        image: 'assets/images/ingredients/4-removebg-preview.png'),
    IngredientModel(
        title: 'Potato',
        image: 'assets/images/ingredients/5-removebg-preview.png'),
    IngredientModel(
        title: 'Red Cabbage',
        image: 'assets/images/ingredients/8-removebg-preview.png'),
    IngredientModel(
        title: 'Tomato',
        image: 'assets/images/ingredients/9-removebg-preview.png'),
    IngredientModel(
        title: 'Garlic',
        image: 'assets/images/ingredients/10-removebg-preview.png'),
    IngredientModel(
        title: 'Spinach',
        image: 'assets/images/ingredients/11-removebg-preview.png'),
    IngredientModel(
        title: 'Broccoli',
        image: 'assets/images/ingredients/12-removebg-preview.png'),
    IngredientModel(
        title: 'Cabbage',
        image: 'assets/images/ingredients/13-removebg-preview.png'),
    IngredientModel(
        title: 'Cauliflower',
        image: 'assets/images/ingredients/15-removebg-preview.png'),
    IngredientModel(
        title: 'Pumpkin',
        image: 'assets/images/ingredients/16-removebg-preview.png'),
    IngredientModel(
        title: 'Carrot',
        image: 'assets/images/ingredients/17-removebg-preview.png'),
    IngredientModel(
        title: 'Lettuce',
        image: 'assets/images/ingredients/19-removebg-preview.png'),
    IngredientModel(
        title: 'Chili pepper',
        image: 'assets/images/ingredients/20-removebg-preview.png'),
    IngredientModel(
        title: 'Black pepper', image: 'assets/images/black_pepper.png'),
    IngredientModel(title: 'Eggplant', image: 'assets/images/eggplant.png'),
    IngredientModel(title: 'Rice', image: 'assets/images/rice.png'),
    IngredientModel(title: 'Salt', image: 'assets/images/salt.png'),
    IngredientModel(
        title: 'Lemon Grass', image: 'assets/images/lemongrass.png'),
    IngredientModel(title: 'Ginger', image: 'assets/images/ginger.png')
  ];
  List<IngredientModel> liquidIngredients = [
    IngredientModel(title: 'Soy Sauce', image: 'assets/images/soy_sauce.png'),
    IngredientModel(title: 'Vinegar', image: 'assets/images/vinegar.png'),
    IngredientModel(
        title: 'Tomato Sauce', image: 'assets/images/tomato_sauce.png'),
    IngredientModel(
        title: 'Coconut Milk', image: 'assets/images/coconut_milk.png'),
    IngredientModel(title: 'Patis', image: 'assets/images/patis.png'),
    IngredientModel(title: 'Water', image: 'assets/images/water.png'),
    IngredientModel(title: 'Oil', image: 'assets/images/oil.png'),
    IngredientModel(
        title: 'Pineapple Juice', image: 'assets/images/pineapple_juice.png'),
  ];
  List<IngredientModel> meatIngredients = [
    IngredientModel(title: 'Chicken', image: 'assets/images/chicken.png'),
    IngredientModel(title: 'Beef', image: 'assets/images/beef.png'),
    IngredientModel(title: 'Pork', image: 'assets/images/pork.png'),
  ];

  List<String> ingredients = [];

  bool get addIngredientButtonIsDisable => searchInputController.text == "";

  bool get ingredientsEmpty => ingredients.isEmpty;

  void addAvailableIngredient(
      {required IngredientModel ingredient, required BuildContext context}) {
    final newIngredient = ingredient.title;
    add(newIngredient, context);
  }

  void addIngredient({required BuildContext context}) {
    final newIngredient = searchInputController.text.trim();
    add(newIngredient, context);
  }

  void add(newIngredient, context) {
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
    _navigationService.navigateToRecipeListView(
        ingredientsFromUser: ingredients);
  }

  void goToSaveRecipes(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => RecipeListView(
                  isSavePage: true,
                  ingredientsFromUser: [],
                )));
  }

  void clearAll() {
    ingredients = [];
    rebuildUi();
  }

  void viewIngredients() {
    key.currentState!.openDrawer();
    notifyListeners();
  }
}
