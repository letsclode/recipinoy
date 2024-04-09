import 'package:flavorsph/adminweb/controllers/recipe/recipe_controller.dart';
import 'package:flavorsph/adminweb/dashboard/widgets/table.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecipePage extends ConsumerStatefulWidget {
  final bool isMobile;
  const RecipePage({super.key, this.isMobile = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecipePageState();
}

class _RecipePageState extends ConsumerState<RecipePage> {
  @override
  Widget build(BuildContext context) {
    final recipePro = ref.watch(recipesProvider);
    return switch (recipePro) {
      AsyncData(:final value) => Expanded(
          child: Container(
            width: double.infinity,
            child: RecipeTable(
                title: 'Recipe\'s',
                headers: widget.isMobile
                    ? ['Title', 'Actions']
                    : ['Title', 'Time', 'Actions'],
                data: value,
                isMobile: widget.isMobile),
          ),
        ),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
