import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavorsph/provider/mydish/dish_provider.dart';
import 'package:flavorsph/provider/myfavorite/favorite_provider.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SavedButton extends ConsumerStatefulWidget {
  final bool isSave;
  final String userId;
  final RecipeModel recipe;
  const SavedButton({
    super.key,
    required this.recipe,
    required this.isSave,
    required this.userId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedButtonState();
}

class _SavedButtonState extends ConsumerState<SavedButton> {
  late bool isSave;
  late String id;
  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      isSave = widget.isSave;
      id = widget.recipe.id!;

      print(id);
    });
    super.initState();
  }

  Future<void> updteSave() async {
    List<String> newLikes = [];

    if (widget.recipe.likes.contains(widget.userId)) {
      //remove

      newLikes = widget.recipe.likes
          .where((element) => element != widget.userId)
          .toList();
    } else {
      newLikes = [...widget.recipe.likes, widget.userId];
      // add
    }

    print("UPDATE IN VIEWMODEL");
    try {
      await FirebaseFirestore.instance
          .collection('recipes')
          .doc(id)
          .update({'likes': newLikes});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return IconButton(
          onPressed: () {
            updteSave().whenComplete(() => setState(() {
                  ref.refresh(dishProvider);
                  ref.refresh(favoriteProvider);
                  isSave = !widget.isSave;
                }));
          },
          icon: isSave
              ? Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 40,
                )
              : Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                  size: 40,
                ));
    });
  }
}
