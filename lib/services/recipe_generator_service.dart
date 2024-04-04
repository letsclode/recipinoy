import 'package:flavorsph/app/app.locator.dart';
import 'package:flavorsph/services/firestore_service.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';

class RecipeGeneratorService {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  Future fetchRecipes() async {
    return await _firestoreService.getRecipes();
  }

  Future fetchSavedRecipes() async {
    return await _firestoreService.savedRecipe();
  }

//   Future<List<RecipeModel>> generate(
//       {required List<String> inputIngredients}) async {
//     final cosineSimilarity = CosineSimilarity();
//     var rankings = <MapEntry<String, double>>[];

//     print("RECIPES ALL $filipinoCuisineData");

//     // Calculate similarity for each cuisine and store the results in rankings
//     for (RecipeModel cuisine in filipinoCuisineData) {
//       List<dynamic> cuisineIngredients = cuisine.ingredients!;
//       final similarity = cosineSimilarity.calculate(
//           inputIngredients, cuisineIngredients, filipinoCuisineData);
//       rankings.add(MapEntry(cuisine.title!, similarity));
//     }

//     rankings = rankings.where((element) => element.value > 0.0).toList();

//     // Rank cuisines based on similarity in descending order

//     print(
//         'Ranked list of Filipino cuisines based on similarity to input ingredients:');
//     for (final entry in rankings) {
//       print('${entry.key}: ${entry.value}');
//     }

//     // Get the most similar cuisine
//     final mostSimilarCuisine = rankings.isNotEmpty ? rankings.first.key : '';
//     print(
//         'The most similar Filipino cuisine to your input is: $mostSimilarCuisine');

//     print("RANKINGS: $rankings");

//     List<String> rankingKeys = rankings.map((e) => e.key).toList();
//     print("KEYS");
//     print(rankingKeys);

//     double getnormalizedValue(value) {
//       int decimalPlaces = 2;

// // Truncate to desired decimal places
//       double truncatedValue = (value * pow(10, decimalPlaces));

// // Divide by 10^decimalPlaces to get final value with desired precision
//       double finalValue = truncatedValue / pow(10, decimalPlaces);

// // Limit to 0.0 and 1.0 range
//       finalValue = min(1.0, max(0.0, finalValue));

//       return finalValue;
//     } // Assuming max value is 10

//     List<RecipeModel> finaldata = filipinoCuisineData
//         .where((element) => rankingKeys.contains(element.title))
//         .map((e) {
//       return e.copyWith(
//           similarity: getnormalizedValue((rankings
//               .firstWhere((element) => element.key == e.title!)
//               .value)));
//     }).toList();

//     finaldata.sort((b, a) => a.similarity!.compareTo(b.similarity!));

//     return finaldata;
//   }

  List<dynamic> _preprocessIngredients(List<dynamic> ingredients) {
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

  Future generate({required List<dynamic> inputIngredients}) async {
    try {
      var processInputIngre = _preprocessIngredients(inputIngredients);
      print("INPUT INGRE $processInputIngre");

      List<RecipeModel> filipinoCuisineData = await fetchRecipes();
      print("fil data $filipinoCuisineData");

      var cuisineWithIngredients = filipinoCuisineData
          .where((element) => element.ingredients!.length > 0)
          .toList();

      List<RecipeModel> finaldata = cuisineWithIngredients
          .map((e) {
            return e.copyWith(
                similarity: matchPercentage(processInputIngre,
                        _preprocessIngredients(e.ingredients!)) /
                    100);
          })
          .toList()
          .where((data) => data.similarity! > 0.0)
          .toList();

      finaldata.sort((b, a) => a.similarity!.compareTo(b.similarity!));

      print("FINAL DATA");
      print(finaldata);
      return finaldata;
    } catch (e) {}
    return [];
  }

  int matchPercentage(
      List<dynamic> userIngredients, List<dynamic> recipeIngredients) {
    int matchingIngredients = 0;
    for (String ingredient in recipeIngredients) {
      if (userIngredients.contains(ingredient)) {
        matchingIngredients++;
      }
    }
    return ((matchingIngredients / recipeIngredients.length) * 100).toInt();
  }
}
