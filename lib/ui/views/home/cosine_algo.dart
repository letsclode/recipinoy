import 'dart:math';

import 'package:flavorsph/ui/models/recipe/recipe_model.dart';

import '../../../app/app.locator.dart';
import '../../../services/firestore_service.dart';

class CosineSimilarity {
  double calculate(List<String> userIngredients, List<String> recipeIngredients,
      List<RecipeModel> allRecipes) {
    if (userIngredients.isEmpty || recipeIngredients.isEmpty) {
      throw ArgumentError('Input vectors cannot be empty');
    }

    // // Calculate similarity using weighted TF-IDF scores
    var numerator = 0.0;
    var denominator1 = 0.0;
    var denominator2 = 0.0;

    // // Preprocess ingredients by removing duplicates and applying stemming/lemmatization (optional)
    var processedUserIngredients = _preprocessIngredients(userIngredients);
    var processedRecipeIngredients = _preprocessIngredients(recipeIngredients);

    // // Calculate term frequencies (TF)
    var userIngredientFrequencies =
        _calculateTermFrequencies(processedUserIngredients);
    var recipeIngredientFrequencies =
        _calculateTermFrequencies(processedRecipeIngredients);

    // // Calculate inverse document frequencies (IDF) based on your recipe data
    var inverseDocumentFrequencies = _calculateInverseDocumentFrequencies(
        ingredients: processedRecipeIngredients, allRecipes: allRecipes);

    print('userIngredientFrequencies: $userIngredientFrequencies');
    print('process: $processedUserIngredients');
    print('recipeIngredientFrequencies: $recipeIngredientFrequencies');
    print('frequencies: $inverseDocumentFrequencies');

    for (String ingredient in processedUserIngredients) {
      if (!processedRecipeIngredients.contains(ingredient)) {
        continue;
      }
      var tfUser = userIngredientFrequencies[ingredient]!;
      var tfRecipe = recipeIngredientFrequencies[ingredient]!;
      var idf = inverseDocumentFrequencies[ingredient]!;
      numerator += tfUser * tfRecipe * idf;
      denominator1 += pow(tfUser * idf, 2);
      denominator2 += pow(tfRecipe * idf, 2);
    }

    denominator1 = sqrt(denominator1);
    denominator2 = sqrt(denominator2);

    if (denominator1 == 0 || denominator2 == 0) {
      // Handle cases where no common ingredients or identical ingredients exist
      // You can return a default similarity value (e.g., 0), throw a custom exception, or log a warning
      return 0.0;
    }

    return numerator / (denominator1 * denominator2);
  }

  Map<String, int> _calculateTermFrequencies(List<String> ingredients) {
    var frequencies = <String, int>{};
    for (var ingredient in ingredients) {
      frequencies[ingredient] = frequencies.containsKey(ingredient)
          ? frequencies[ingredient]! + 1
          : 1;
    }

    return frequencies;
  }

  // Helper methods for TF-IDF calculations (implement or customize based on your data)
  Map<String, double> _calculateInverseDocumentFrequencies(
      {required List<String> ingredients,
      required List<RecipeModel> allRecipes}) {
    // Assuming you have a list of all recipes (or a representative sample)

    int totalRecipes = allRecipes.length;
    Map<String, double> idf = {};

    for (RecipeModel recipe in allRecipes) {
      List<String> processeduniqueIngredients =
          _preprocessIngredients(recipe.ingredients!.map((e) => e).toList());

      Set<String> uniqueIngredients = processeduniqueIngredients.toSet();

      for (String ingredient in uniqueIngredients) {
        idf[ingredient] = idf.containsKey(ingredient)
            ? idf[ingredient]! + 1
            : 1; // Count occurrences in recipes
      }
    }

    for (String ingredient in idf.keys) {
      idf[ingredient] = log(totalRecipes / idf[ingredient]!); // Calculate IDF
    }

    print("IDF $idf");

    return idf;
  }

  List<String> _preprocessIngredients(List<String> ingredients) {
    // Example preprocessing: Remove duplicates and lowercase ingredients
    var processedIngredients = ingredients.toSet().toList();
    processedIngredients = processedIngredients
        .map((ingredient) => ingredient.toLowerCase())
        .toList();

    // You can add more preprocessing steps here, such as:
    // - Stemming or lemmatization to normalize variations (e.g., "potatoes" -> "potato")
    // - Handling misspellings or variations (e.g., using a dictionary or fuzzy matching)
    // - Handling measurements or units (e.g., extracting only ingredient names)
    return processedIngredients;
  }
}

class FilipinoCuisineData {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  Future<List<RecipeModel>> getAllRecipes() async {
    return await _firestoreService.getRecipes();
  }

  Future<List<String>> getIngredients({required RecipeModel recipeModel}) {
    return getAllRecipes().then((value) =>
        value.firstWhere((element) => element == recipeModel).ingredients!);
  }
}
