import 'package:flavorsph/constant/color.dart';
import 'package:flavorsph/ui/widgets/recipe_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked/stacked.dart';
import '../../../provider/user_ingredients/user_ingredients_provider.dart';
import '../../models/recipe/recipe_model.dart';
import '../../widgets/drop_down_menu.dart';
import '../../widgets/generate_button.dart';
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
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 10,
            foregroundColor: Colors.transparent,
            backgroundColor: color1,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Text("Match Dish")),
                Tab(icon: Text("Suggested Dish")),
              ],
            ),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropDownMenu(),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        FutureBuilder<List<RecipeModel>>(
                            future: viewModel.getRecipe(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              }
                              if (snapshot.data != null) {
                                if (snapshot.data!.length > 0) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: const EdgeInsets.all(8.0),
                                        margin: EdgeInsets.only(
                                            bottom: snapshot.data!.length - 1 ==
                                                    index
                                                ? 70
                                                : 0),
                                        child: RecipeTile(
                                          data: snapshot.data![index],
                                          availableIngredients:
                                              ingredientsFromUser
                                                  .map((e) => e.toLowerCase())
                                                  .toList(),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Consumer(
                                      builder: (context, ref, child) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/empty.png',
                                            width: 300,
                                          ),
                                          Text(
                                            ingredientsFromUser.isEmpty
                                                ? "Please input  ingredients above."
                                                : "Sorry it seems no recipe is matched.",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                }
                              }
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/empty.png',
                                      width: 300,
                                    ),
                                    Text(
                                      "Please input  ingredients above.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    SizedBox(
                                      height: 100,
                                    )
                                  ],
                                ),
                              );
                            }),
                        FutureBuilder<List<RecipeModel>>(
                            future: viewModel.getSuggested(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              }

                              if (snapshot.data != null) {
                                if (snapshot.data!.length > 0) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: const EdgeInsets.all(8.0),
                                        margin: EdgeInsets.only(
                                            bottom: snapshot.data!.length - 1 ==
                                                    index
                                                ? 70
                                                : 0),
                                        child: RecipeTile(
                                          data: snapshot.data![index],
                                          availableIngredients:
                                              ingredientsFromUser
                                                  .map((e) => e.toLowerCase())
                                                  .toList(),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Consumer(
                                      builder: (context, ref, child) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/empty.png',
                                            width: 300,
                                          ),
                                          Text(
                                            ingredientsFromUser.isEmpty
                                                ? "Please input  ingredients above."
                                                : "No suggested dish found!",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                }
                              }

                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/empty.png',
                                      width: 300,
                                    ),
                                    Text(
                                      "Please input  ingredients above.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    SizedBox(
                                      height: 100,
                                    )
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
              Consumer(builder: (context, ref, child) {
                return Positioned(
                    bottom: 10,
                    right: 10,
                    left: 10,
                    child: GenerateButton(
                      generate: (() {
                        final selectedIngredients =
                            ref.watch(userIngredientsProvider);

                        viewModel.generateRecipe(
                            ingredients: selectedIngredients.value!
                                .map((e) => e.title)
                                .toList());

                        viewModel.generateSuggestedRecipe(
                            ingredients: selectedIngredients.value!
                                .map((e) => e.title)
                                .toList());
                      }),
                    ));
              })
            ],
          ),
        ));
  }

  @override
  RecipeListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RecipeListViewModel();
}
