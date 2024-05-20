import 'package:flavorsph/provider/user_ingredients/user_ingredients_provider.dart';
import 'package:flavorsph/ui/views/recipe_list/recipe_list_view.dart';
import 'package:flavorsph/ui/widgets/drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final selectedIngredients = ref.watch(userIngredientsProvider);
      return selectedIngredients.when(data: (data) {
        return RecipeListView(
            ingredientsFromUser: data.map((e) => e.title).toList());
      }, error: (e, s) {
        return Text(s.toString());
      }, loading: () {
        return Center(
          child: CircularProgressIndicator(),
        );
      });
    });
  }
}
