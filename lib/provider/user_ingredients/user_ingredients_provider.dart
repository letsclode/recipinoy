import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavorsph/adminweb/controllers/auth_controller.dart';
import 'package:flavorsph/ui/models/ingredient/ingredient_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
part 'user_ingredients_provider.g.dart';

@riverpod
class UserIngredients extends _$UserIngredients {
  @override
  Future<List<IngredientModel>> build() async {
    print('DISH FETCH');

    final uid = ref.watch(authControllerProvider)!.uid;
    print('DISH FETCH');
    print('UID $uid');
    return await fetchMyIngredients(userId: uid);
  }

  Future fetchMyIngredients({required String userId}) async {
    try {
      List<IngredientModel> ingredient = [];

      print(userId);

      final data = await FirebaseFirestore.instance
          .collection('ingredients')
          .where('createdBy', isEqualTo: userId)
          .get();

      if (data.docs.isNotEmpty) {
        ingredient = data.docs
            .map((e) => IngredientModel.fromJson(e.data()).copyWith(id: e.id))
            .toList();
      }

      print('INGREDIENTS');
      print(ingredient);
      return ingredient;
    } catch (e) {
      state = AsyncValue.error(
          e, StackTrace.fromString("fetching ingredients error"));
    }
  }

  Future addIngredient({required IngredientModel ingredient}) async {
    try {
      var uuid = Uuid();

      if (ingredient.id != null) {
        FirebaseFirestore.instance
            .collection('ingredients')
            .doc(ingredient.id)
            .update(ingredient.toJson());
      } else {
        FirebaseFirestore.instance
            .collection('ingredients')
            .doc(uuid.v1())
            .set(ingredient.toJson());
      }
      ref.invalidateSelf();
    } catch (e) {
      print(e);
    }

    await future;
  }

  Future removeIngredient({required String ingredientId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('ingredients')
          .doc(ingredientId)
          .delete();

      ref.invalidateSelf();
    } catch (e) {
      print(e);
    }

    await future;
  }
}
