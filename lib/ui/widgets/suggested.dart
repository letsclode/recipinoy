import 'package:flavorsph/constant/color.dart';
import 'package:flavorsph/provider/recipe_provider.dart';
import 'package:flavorsph/ui/widgets/recipe_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SuggestedDish extends ConsumerStatefulWidget {
  const SuggestedDish({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SuggestedDishState();
}

class _SuggestedDishState extends ConsumerState<SuggestedDish> {
  @override
  Widget build(BuildContext context) {
    final recipeWithLikes = ref.read(recipeProvider);
    return Column(
      children: [
        Container(
          width: 200,
          padding: EdgeInsets.all(10),
          child: Center(
              child: Text(
            'Suggested Dish',
            style: Theme.of(context).textTheme.titleLarge,
          )),
          decoration: BoxDecoration(
              color: color6, borderRadius: BorderRadius.circular(10)),
        ),
        Container(
            child: recipeWithLikes.when(data: (data) {
          if (data.length > 0) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: data.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 5);
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RecipeTile(
                    data: data[index],
                  ),
                );
              },
            );
          } else {}
        }, error: (e, s) {
          return Text(s.toString());
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }))
      ],
    );
  }
}
