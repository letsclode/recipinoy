import 'package:flavorsph/adminweb/controllers/auth_controller.dart';
import 'package:flavorsph/provider/user_ingredients/user_ingredients_provider.dart';
import 'package:flavorsph/ui/common/ui_helpers.dart';
import 'package:flavorsph/ui/models/ingredient/ingredient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/color.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({super.key});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  TextEditingController? menuController;

  bool isEnable = false;

  @override
  void initState() {
    menuController = TextEditingController();
    // TODO: implement initState
    menuController!.addListener(() {
      setState(() {
        isEnable = menuController!.text.isEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final myIngredientsController = ref.watch(userIngredientsProvider);

      return myIngredientsController.when(data: (data) {
        data.sort((a, b) => a.title.compareTo(b.title));
        return Row(
          children: [
            DropdownMenu<IngredientModel>(
              menuHeight: 200,
              leadingIcon: Icon(Icons.search),
              controller: menuController,
              width: MediaQuery.of(context).size.width - 16 - 80 - 10,
              hintText: "Search Ingredients",
              requestFocusOnTap: true,
              enableFilter: true,
              label: const Text('Search Ingredients'),
              dropdownMenuEntries: data.map<DropdownMenuEntry<IngredientModel>>(
                  (IngredientModel menu) {
                return DropdownMenuEntry<IngredientModel>(
                  value: menu,
                  label: menu.title,
                  trailingIcon: IconButton(
                      onPressed: () {
                        print(menu.id);
                        setState(() {
                          ref
                              .read(userIngredientsProvider.notifier)
                              .removeIngredient(ingredientId: menu.id!);
                        });
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.red,
                      )),
                );
              }).toList(),
            ),
            horizontalSpaceSmall,
            IconButton(
                onPressed: isEnable
                    ? null
                    : () async {
                        IngredientModel newIngredient = IngredientModel(
                            title: menuController!.text,
                            createdBy: ref.read(authControllerProvider)!.uid);

                        await ref
                            .read(userIngredientsProvider.notifier)
                            .addIngredient(ingredient: newIngredient);

                        menuController!.clear();
                      },
                icon: CircleAvatar(
                    backgroundColor: isEnable ? Colors.grey : color1,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    )))
          ],
        );
      }, error: (e, s) {
        return Text(e.toString());
      }, loading: () {
        return Center(
          child: CircularProgressIndicator(),
        );
      });
    });
  }
}
