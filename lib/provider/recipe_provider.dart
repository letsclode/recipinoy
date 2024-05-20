import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_provider.g.dart';

@riverpod
class Recipe extends _$Recipe {
  @override
  Future<List<RecipeModel>> build() async {
    return await fetchRecipe();
  }

  Future fetchRecipe() async {
    try {
      List<RecipeModel> recipes = [];
      final data = await FirebaseFirestore.instance.collection('recipes').get();

      if (data.docs.isNotEmpty) {
        recipes = data.docs
            .map((e) => RecipeModel.fromJson(e.data()).copyWith(id: e.id))
            .where((element) => element.likes.isNotEmpty)
            .toList();
      }

      return recipes;
    } catch (e) {
      print(e);

      state =
          AsyncValue.error(e, StackTrace.fromString("fetching recipe error"));
    }
  }

  void toogleLike() {}
}
