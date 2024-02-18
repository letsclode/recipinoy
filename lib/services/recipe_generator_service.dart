import 'dart:math';

import 'package:flavorsph/ui/models/recipe/recipe_model.dart';

import '../ui/models/ingredient/ingredient_model.dart';
import '../ui/views/home/cosine_algo.dart';

class RecipeGeneratorService {
  final filipinoCuisineData = FilipinoCuisineData();
  Future<List<RecipeModel>> generate(
      {required List<String> inputIngredients}) async {
    final cosineSimilarity = CosineSimilarity();
    var rankings = <MapEntry<String, double>>[];

    // Calculate similarity for each cuisine and store the results in rankings
    for (RecipeModel cuisine in filipinoCuisineData.getAllRecipes()) {
      final List<IngredientModel> cuisineIngredients =
          filipinoCuisineData.getIngredients(recipeModel: cuisine);
      final similarity = cosineSimilarity.calculate(
          inputIngredients,
          cuisineIngredients.map((e) => e.name!).toList(),
          filipinoCuisineData.getAllRecipes());
      rankings.add(MapEntry(cuisine.title!, similarity));
    }

    rankings = rankings.where((element) => element.value > 0.0).toList();

    // Rank cuisines based on similarity in descending order

    print(
        'Ranked list of Filipino cuisines based on similarity to input ingredients:');
    for (final entry in rankings) {
      print('${entry.key}: ${entry.value}');
    }

    // Get the most similar cuisine
    final mostSimilarCuisine = rankings.isNotEmpty ? rankings.first.key : '';
    print(
        'The most similar Filipino cuisine to your input is: $mostSimilarCuisine');

    print("RANKINGS: $rankings");

    List<String> rankingKeys = rankings.map((e) => e.key).toList();

    double getnormalizedValue(value) {
      int decimalPlaces = 2;

// Truncate to desired decimal places
      double truncatedValue = (value * pow(10, decimalPlaces));

// Divide by 10^decimalPlaces to get final value with desired precision
      double finalValue = truncatedValue / pow(10, decimalPlaces);

// Limit to 0.0 and 1.0 range
      finalValue = min(1.0, max(0.0, finalValue));

      return finalValue;
    } // Assuming max value is 10

    List<RecipeModel> finaldata = filipinoCuisineData
        .getAllRecipes()
        .where((element) => rankingKeys.contains(element.title))
        .map((e) {
      return e.copyWith(
          similarity: getnormalizedValue((rankings
              .firstWhere((element) => element.key == e.title!)
              .value)));
    }).toList();

    finaldata.sort((b, a) => a.similarity!.compareTo(b.similarity!));

    return finaldata;
  }
}
