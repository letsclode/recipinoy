import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_controller.g.dart';

@riverpod
Stream<List<RecipeModel>> recipes(RecipesRef ref) async* {
  final stream = FirebaseFirestore.instance
      .collection('recipes')
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs
        .map((doc) => RecipeModel.fromJson(doc.data()))
        .toList();
  });

  await for (final event in stream) {
    yield event;
  }
}
