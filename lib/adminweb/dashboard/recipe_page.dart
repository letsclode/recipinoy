import 'package:flavorsph/adminweb/color.dart';
import 'package:flavorsph/adminweb/controllers/recipe/recipe_controller.dart';
import 'package:flavorsph/adminweb/dashboard/widgets/recipe_form.dart';
import 'package:flavorsph/adminweb/dashboard/widgets/table.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecipePage extends ConsumerStatefulWidget {
  const RecipePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecipePageState();
}

class _RecipePageState extends ConsumerState<RecipePage> {
  @override
  Widget build(BuildContext context) {
    final recipePro = ref.watch(recipesProvider);
    return switch (recipePro) {
      AsyncData(:final value) => Stack(
          children: [
            RecipeTable(
              title: 'Recipe\'s',
              headers: const [
                'Title',
                'Time',
              ],
              data: value,
            ),
            Positioned(
              right: 100,
              top: 100,
              child: Container(
                width: 150,
                height: 40,
                child: MaterialButton(
                  color: kPrimaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Center(child: Text("Adding Recipe")),
                            content:
                                Container(width: 400, child: MyCustomForm()),
                          );
                        });
                  },
                  child: Text('Add recipe'),
                ),
              ),
            )
          ],
        ),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
