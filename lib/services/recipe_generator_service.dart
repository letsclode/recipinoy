import 'package:flavorsph/app/app.locator.dart';
import 'package:flavorsph/services/firestore_service.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';

import '../constant/basic_ingredients.dart';

class RecipeGeneratorService {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  Future fetchRecipes() async {
    return await _firestoreService.getRecipes();
  }

  // Future fetchFavorite() async {
  //   return await _firestoreService.getFavorites();
  // }

  List<dynamic> _preprocessIngredients(List<dynamic> ingredients) {
    var processedIngredients = ingredients.toSet().toList();
    processedIngredients = processedIngredients
        .map((ingredient) => ingredient.toLowerCase())
        .toList();
    return processedIngredients;
  }

  Future generate({required List<dynamic> inputIngredients}) async {
    try {
      var processInputIngre = _preprocessIngredients(inputIngredients);
      print("INPUT INGRE $processInputIngre");

      List<RecipeModel> filipinoCuisineData = await fetchRecipes();
      print("fil data $filipinoCuisineData");

      var cuisineWithIngredients = filipinoCuisineData
          .where((element) => element.sliceIngre!.length > 0)
          .toList();

      print("cuisineWithIngredients : $cuisineWithIngredients");

      List<RecipeModel> finaldata = cuisineWithIngredients
          .map((e) {
            return e.copyWith(
                similarity: matchPercentage(processInputIngre,
                        _preprocessIngredients(e.sliceIngre!)) /
                    100);
          })
          .toList()
          .where((data) => data.similarity! > 80 / 100)
          .toList();

      finaldata.sort((b, a) => a.similarity!.compareTo(b.similarity!));

      print("FINAL DATA");
      print(finaldata);
      return finaldata;
    } catch (e) {}
    return [];
  }

  Future generateSuggested({required List<dynamic> inputIngredients}) async {
    try {
      var processInputIngre = _preprocessIngredients(inputIngredients);
      print("INPUT INGRE $processInputIngre");

      List<RecipeModel> filipinoCuisineData = await fetchRecipes();
      print("fil data $filipinoCuisineData");

      var cuisineWithIngredients = filipinoCuisineData
          .where((element) => element.sliceIngre!.length > 0)
          .toList();

      print("cuisineWithIngredients : $cuisineWithIngredients");

      List<RecipeModel> finaldata = cuisineWithIngredients
          .map((e) {
            return e.copyWith(
                similarity: matchPercentage(processInputIngre,
                        _preprocessIngredients(e.sliceIngre!)) /
                    100);
          })
          .toList()
          .where((data) => data.similarity! > 0 && data.similarity! < 80 / 100)
          .toList();

      finaldata.sort((b, a) => a.similarity!.compareTo(b.similarity!));

      print("FINAL DATA");
      print(finaldata);
      return finaldata;
    } catch (e) {}
    return [];
  }

  double matchPercentage(
      List<dynamic> userIngredients, List<dynamic> recipeIngredients) {
    print('recipeIngredients $recipeIngredients');

    int matchingIngredients = 0;
    int missingmatch = 0;

    List userRareIngredients = userIngredients
        .where((element) => !lowercaseBasicIngredients.contains(element))
        .toList();

    print('userRareIngredients : $userRareIngredients');

    bool isAccepted =
        userIngredients.every((element) => recipeIngredients.contains(element));

    List foundIngredient = [];

    if (isAccepted) {
      for (String ingredient in recipeIngredients) {
        if (userRareIngredients.contains(ingredient)) {
          foundIngredient.add(ingredient);
          if (matchingIngredients == 0) {
            matchingIngredients = 100;
          }
        }
      }

      recipeIngredients
          .removeWhere((element) => foundIngredient.contains(element));

      for (String ingredient in recipeIngredients) {
        if (!userIngredients.contains(ingredient)) {
          if (matchingIngredients != 0) {
            missingmatch += 2;
            print('MINUS HERE  $missingmatch');
            print('INGREDIENT IS $ingredient');
          }
        }
      }
    }

    print('matchingIngredients $matchingIngredients');
    print('missingmatch $missingmatch');

    double value =
        double.parse((matchingIngredients - missingmatch).toString());

    return value;
  }
}
