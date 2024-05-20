import 'package:flavorsph/adminweb/controllers/recipe/recipe_controller.dart';
import 'package:flavorsph/adminweb/recipe/widgets/table.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/search/search_provider.dart';

class RecipePage extends ConsumerStatefulWidget {
  final bool isMobile;
  const RecipePage({super.key, this.isMobile = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecipePageState();
}

class _RecipePageState extends ConsumerState<RecipePage> {
  TextEditingController seachController = TextEditingController();
  String searchText = '';
  void search() {
    ref.read(searchTermProvider.notifier).state = searchText;
  }

  @override
  Widget build(BuildContext context) {
    final recipePro = ref.watch(recipeProvider);
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 250,
                  child: TextField(
                    controller: seachController,
                    decoration: InputDecoration(
                      labelText: 'Search Text',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: search,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                        search();
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          switch (recipePro) {
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
          },
        ],
      ),
    );
  }
}
