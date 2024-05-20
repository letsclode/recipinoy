import 'dart:async';

import 'package:flavorsph/adminweb/controllers/auth_controller.dart';
import 'package:flavorsph/adminweb/providers/image/image_provider.dart';
import 'package:flavorsph/constant/color.dart';
import 'package:flavorsph/provider/mydish/dish_provider.dart';
import 'package:flavorsph/provider/user_ingredients/user_ingredients_provider.dart';
import 'package:flavorsph/ui/common/ui_helpers.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flavorsph/ui/widgets/drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/title_button.dart';

class CreateDish extends StatefulWidget {
  const CreateDish({super.key});

  @override
  State<CreateDish> createState() => _CreateDishState();
}

class _CreateDishState extends State<CreateDish> {
  late StreamSubscription<bool> keyboardSubscription;
  bool keyboard = false;

  TextEditingController dishName = TextEditingController();
  TextEditingController dishTime = TextEditingController();
  TextEditingController stepController = TextEditingController();

  FocusNode stepFocus = FocusNode();
  final TextEditingController menuController = TextEditingController();

  List<String> ingredients = [];
  List<String> steps = [];

  @override
  void initState() {
    var keyboardVisibilityController = KeyboardVisibilityController();

    // Query
    print(
        'Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        keyboard = visible;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height - 200,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                Row(
                  children: [
                    TitleButton(
                      title: 'Adding Dish',
                    )
                  ],
                ),
                Column(
                  children: [
                    Consumer(builder: (context, ref, child) {
                      final chooseImage = ref.watch(imageProvider);
                      return Container(
                        height: 150,
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            image: chooseImage.globalImage != null
                                ? DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image:
                                        MemoryImage(chooseImage.globalImage!))
                                : null,
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: chooseImage.globalImage != null
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: chooseImage.globalImage != null
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    chooseImage
                                        .chooseImage()
                                        .whenComplete(() => setState(() {}));
                                    ;
                                  },
                                  child: Image.asset(
                                    'assets/images/upload-image.png',
                                    fit: BoxFit.fitHeight,
                                    height: 30,
                                  ),
                                ),
                                horizontalSpaceMedium,
                                IconButton(
                                    onPressed: () {
                                      chooseImage
                                          .chooseCameraImage()
                                          .whenComplete(() => setState(() {}));
                                    },
                                    icon: Icon(Icons.camera))
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                    verticalSpaceSmall,
                    TextField(
                      controller: dishName,
                      decoration: InputDecoration(
                        hintText: 'Name of dish',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    TextField(
                      controller: dishTime,
                      decoration: InputDecoration(
                        hintText: 'Time',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: DropDownMenu()),
                    verticalSpaceSmall,
                    Container(
                      height: 200,
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 150,
                                child: TextField(
                                  focusNode: stepFocus,
                                  controller: stepController,
                                  decoration: InputDecoration(
                                    hintText: 'Procedures',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      steps.add(stepController.text);
                                      stepController.clear();
                                      stepFocus.unfocus();
                                    });
                                  },
                                  icon: Icon(Icons.add))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: steps.map((e) => Text(e)).toList(),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                    )
                  ],
                )
              ],
            ),
            KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
              return keyboard
                  ? SizedBox()
                  : Consumer(builder: (context, ref, child) {
                      final dishController = ref.read(dishProvider.notifier);

                      final user = ref.read(authControllerProvider);

                      final selectedIngredients =
                          ref.read(userIngredientsProvider);

                      return Positioned(
                          bottom: 10,
                          right: 10,
                          child: MaterialButton(
                            color: color1,
                            onPressed: () async {
                              RecipeModel recipe = RecipeModel(
                                  createdBy: user!.uid,
                                  title: dishName.text,
                                  time: dishTime.text,
                                  sliceIns: steps,
                                  sliceIngre: selectedIngredients.value!
                                      .map((e) => e.title)
                                      .toList());

                              print(recipe);
                              await dishController
                                  .save(recipe: recipe)
                                  .whenComplete(() => Navigator.pop(context));
                            },
                            child: Text('Save'),
                          ));
                    });
            })
          ],
        ),
      ),
    );
  }
}
