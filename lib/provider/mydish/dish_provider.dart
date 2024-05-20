import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavorsph/adminweb/controllers/auth_controller.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../adminweb/providers/image/image_provider.dart';

part 'dish_provider.g.dart';

@riverpod
class Dish extends _$Dish {
  @override
  Future<List<RecipeModel>> build() async {
    print('DISH FETCH');

    final uid = ref.watch(authControllerProvider)!.uid;
    print('DISH FETCH');
    print('UID $uid');
    return await fetchMyDish(userId: uid);
  }

  Future fetchMyDish({required String userId}) async {
    try {
      List<RecipeModel> recipes = [];
      print('DISH FETCH');
      print(userId);

      final data = await FirebaseFirestore.instance
          .collection('recipes')
          .where('createdBy', isEqualTo: userId)
          .get();

      if (data.docs.isNotEmpty) {
        recipes = data.docs
            .map((e) => RecipeModel.fromJson(e.data()).copyWith(id: e.id))
            .toList();

        print(recipes);
      }

      return recipes;
    } catch (e) {
      state =
          AsyncValue.error(e, StackTrace.fromString("fetching recipe error"));
    }
  }

  Future save({required RecipeModel recipe}) async {
    try {
      var uuid = Uuid();
      final image = ref.read(imageProvider).globalImage;

      String generatedId = uuid.v1();
      var url;

      print('generatedId');
      print(generatedId);

      if (image != null) {
        url = await ref.read(imageProvider).uploadImageToStorage(
            recipeId: recipe.id != null ? recipe.id! : generatedId,
            image: image);
      }

      print("URL");
      print(url);

      if (url != null) {
        recipe = recipe.copyWith(photo: url);
      }

      print(recipe);
      if (recipe.id != null) {
        FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipe.id)
            .update(recipe.toJson());
      } else {
        FirebaseFirestore.instance
            .collection('recipes')
            .doc(generatedId)
            .set(recipe.toJson());
      }
      ref.invalidateSelf();
    } catch (e) {
      print(e);
    }

    await future;
  }
}
