import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

final searchTermProvider = StateProvider<String>((ref) => '');

@riverpod
Stream<List<RecipeModel>> recipe(RecipeRef ref) async* {
  String searchText = ref.watch(searchTermProvider);

  if (searchText.isNotEmpty) {
    print('SEACHDATA');
    print(searchText);
    final stream = FirebaseFirestore.instance
        .collection('recipes')
        .orderBy('title')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .where((element) =>
              (element['title'] as String).toLowerCase().contains(searchText))
          .map((doc) {
        return RecipeModel.fromJson(doc.data()).copyWith(id: doc.id);
      }).toList();
    });

    await for (final event in stream) {
      yield event;
    }
  } else {
    final stream = FirebaseFirestore.instance
        .collection('recipes')
        .orderBy('title')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return RecipeModel.fromJson(doc.data()).copyWith(id: doc.id);
      }).toList();
    });

    await for (final event in stream) {
      yield event;
    }
  }
}
