import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../models/recipe/recipe_model.dart';
import '../../widgets/recipe_tile.dart';
import 'recipe_list_viewmodel.dart';

class RecipeListView extends StackedView<RecipeListViewModel> {
  final List<String> ingredientsFromUser;
  const RecipeListView({super.key, required this.ingredientsFromUser});

  @override
  Widget builder(
    BuildContext context,
    RecipeListViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            margin: const EdgeInsets.only(bottom: 15),
            child: const Text(
              'This is the recommended recipe\'s',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Expanded(
              child: FutureBuilder<List<RecipeModel>>(
                  future: viewModel.fetchRecipes(),
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
                              data: snapshot.data![index],
                              availableIngredients: ingredientsFromUser,
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
  RecipeListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RecipeListViewModel();

  @override
  void onModelReady(RecipeListViewModel viewModel) {
    // TODO: implement onModelReady
    // viewModel.fetchPosts();
    super.onViewModelReady(viewModel);
  }
}
