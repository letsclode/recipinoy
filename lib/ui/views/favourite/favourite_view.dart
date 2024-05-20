import 'package:flavorsph/provider/myfavorite/favorite_provider.dart';
import 'package:flavorsph/ui/widgets/recipe_tile_like.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../widgets/title_button.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends ConsumerState<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    final favoriteController = ref.watch(favoriteProvider);
    return Column(
      children: [
        Row(
          children: [
            TitleButton(
              title: 'My Favorite',
            )
          ],
        ),
        Expanded(
          child: Container(
              height: MediaQuery.of(context).size.height / 3,
              child: favoriteController.when(data: (data) {
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
                        child: RecipeTileLike(
                          updateData: () {},
                          data: data[index],
                          availableIngredients: [],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/empty.png',
                          width: 300,
                        ),
                        Text(
                          "No favorites yet.",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  );
                }
              }, error: (e, s) {
                return Text(s.toString());
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              })),
        )
      ],
    );
  }
}
