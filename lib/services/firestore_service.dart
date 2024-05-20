import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';

class FirestoreService {
  final CollectionReference _recipesCollectionReference =
      FirebaseFirestore.instance.collection('recipes');

  Future addPost(RecipeModel post) async {
    try {
      await _recipesCollectionReference.add(post.toJson());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<RecipeModel>> getRecipes() async {
    try {
      var recipeDocuments = await _recipesCollectionReference.get();
      if (recipeDocuments.docs.isNotEmpty) {
        var data = recipeDocuments.docs
            .map((snapshot) =>
                RecipeModel.fromJson(snapshot.data() as Map<String, Object?>)
                    .copyWith(id: snapshot.id))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
        print('RECIPE DATA');
        print(data.length);
        return data;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<RecipeModel>> getFavorites({required String userId}) async {
    try {
      var recipeDocuments = await _recipesCollectionReference
          .where('likes', arrayContains: userId)
          .get();
      if (recipeDocuments.docs.isNotEmpty) {
        var data = recipeDocuments.docs
            .map((snapshot) =>
                RecipeModel.fromJson(snapshot.data() as Map<String, Object?>)
                    .copyWith(id: snapshot.id))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
        print('RECIPE DATA');
        print(data.length);
        return data;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
