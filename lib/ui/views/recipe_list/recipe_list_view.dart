import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback/feedback.dart';
import 'package:flavorsph/adminweb/providers/image/image_provider.dart';
import 'package:flavorsph/adminweb/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

import '../../models/recipe/recipe_model.dart';
import '../../widgets/recipe_tile.dart';
import 'recipe_list_viewmodel.dart';

class RecipeListView extends StackedView<RecipeListViewModel> {
  final List<String> ingredientsFromUser;
  final bool isSavePage;

  const RecipeListView(
      {super.key, required this.ingredientsFromUser, this.isSavePage = false});

  @override
  Widget builder(
    BuildContext context,
    RecipeListViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        actions: [
          Consumer(
            builder: (_, ref, child) {
              final imagePro = ref.read(imageProvider);
              final userPro = ref.read(authRepositoryProvider).getCurrentUser();
              var uuid = Uuid();
              return TextButton(
                  onPressed: () async {
                    BetterFeedback.of(context)
                        .show((UserFeedback feedback) async {
                      print("FEEDBACK");
                      print(feedback);

                      final url = await imagePro.uploadImageToStorage(
                          recipeId: uuid.v1(), image: feedback.screenshot);

                      FirebaseFirestore.instance.collection('feedbacks').add({
                        "text": feedback.text,
                        "screenshot": url,
                        "user": userPro!.displayName
                      });
                    });
                  },
                  child: Text("Send a feedback"));
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.only(bottom: 15),
            child: const Text(
              'This is the recommended recipe\'s',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Expanded(
              child: FutureBuilder<List<RecipeModel>>(
                  future: isSavePage
                      ? viewModel.recipe()
                      : viewModel.generateRecipe(
                          ingredients: ingredientsFromUser),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }

                    if (snapshot.data != null) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 5);
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RecipeTile(
                              updateData: viewModel.updateData,
                              data: snapshot.data![index],
                              availableIngredients: ingredientsFromUser
                                  .map((e) => e.toLowerCase())
                                  .toList(),
                            ),
                          );
                        },
                      );
                    }

                    return const Center(
                      child: Text("Empty"),
                    );
                  }))
        ],
      ),
    );
  }

  @override
  void onModelReady(RecipeListViewModel viewModel) {
    print("ONMODELREADY");
  }

  @override
  RecipeListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RecipeListViewModel();
}
