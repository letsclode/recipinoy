import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavorsph/adminweb/controllers/auth_controller.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_provider.g.dart';

@riverpod
class Favorite extends _$Favorite {
  @override
  Future<List<RecipeModel>> build() async {
    return await fetchFavorite(userId: ref.watch(authControllerProvider)!.uid);
  }

  Future fetchFavorite({required String userId}) async {
    try {
      List<RecipeModel> recipes = [];
      final data = await FirebaseFirestore.instance
          .collection('recipes')
          .where('likes', arrayContains: userId)
          .get();

      if (data.docs.isNotEmpty) {
        recipes = data.docs
            .map((e) => RecipeModel.fromJson(e.data()).copyWith(id: e.id))
            .toList();
      }

      return recipes;
    } catch (e) {
      print(e);

      state =
          AsyncValue.error(e, StackTrace.fromString("fetching recipe error"));
    }
  }
}
