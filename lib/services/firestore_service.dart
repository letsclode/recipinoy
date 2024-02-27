import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flutter/services.dart';

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

  Future getRecipes() async {
    try {
      var recipeDocuments = await _recipesCollectionReference.get();
      if (recipeDocuments.docs.isNotEmpty) {
        return recipeDocuments.docs
            .map((snapshot) =>
                RecipeModel.fromJson(snapshot.data() as Map<String, Object?>))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
