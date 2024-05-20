import 'package:flavorsph/provider/mydish/dish_provider.dart';
import 'package:flavorsph/ui/widgets/title_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/recipe_tile_like.dart';

class ViewDish extends ConsumerStatefulWidget {
  const ViewDish({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewDishState();
}

class _ViewDishState extends ConsumerState<ViewDish> {
  @override
  Widget build(BuildContext context) {
    final dishController = ref.watch(dishProvider);
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              TitleButton(
                title: 'My Dish',
              )
            ],
          ),
          Expanded(
              child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: dishController.when(data: (data) {
                    if (data.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/empty.png',
                              width: 300,
                            ),
                            Text(
                              "No dish found.",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: data.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 5);
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RecipeTileLike(
                              updateData: () {},
                              availableIngredients: [],
                              data: data[index],
                            ),
                          );
                        },
                      );
                    }
                  }, error: (e, s) {
                    return Center(
                      child: Text(e.toString()),
                    );
                  }, loading: () {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }))),
        ],
      ),
    );
  }
}
