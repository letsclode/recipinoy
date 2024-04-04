// Create a Form widget.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flavorsph/adminweb/providers/image/image_provider.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class MyCustomForm extends ConsumerStatefulWidget {
  final RecipeModel? editableRecipe;
  const MyCustomForm({super.key, this.editableRecipe});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends ConsumerState<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController inputIngreController = TextEditingController();
  TextEditingController inputStepController = TextEditingController();
  TextEditingController timeTXController = TextEditingController();
  TextEditingController titleTXController = TextEditingController();

  List<String> ingredients = [];
  List<String> steps = [];
  bool loader = false;

  addIngredients() {
    print('click add here');
    setState(() {
      ingredients.add(inputIngreController.text);
      inputIngreController.clear();
    });
  }

  addStep() {
    setState(() {
      steps.add(inputStepController.text);
      inputStepController.clear();
    });
  }

  final dio = Dio();

  Future<List<dynamic>> sendPostRequest() async {
    try {
      var data = {"values": ingredients};

      // final body = jsonEncode(data); // Encode data as JSON

      var response = await dio.post(
          'https://cloderaldo.pythonanywhere.com/api/modify_array',
          data: data);

      print('RESPONSE : ${response.statusCode}');
      // print('RESPONSE : ${response.}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final json = (response.data as Map<String, dynamic>);

        print(json['message']);

        return json['message'] as List<dynamic>;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future save({String? recipeId}) async {
    setState(() {
      loader = true;
    });

    try {
      var uuid = Uuid();
      List<dynamic> filteredIngredients = [];

      filteredIngredients = await sendPostRequest();

      print('filteredIngredients');
      print(filteredIngredients);

      final image = ref.read(imageProvider).globalImage;

      String generatedId = uuid.v1();
      var url;

      print('generatedId');
      print(generatedId);

      if (image != null) {
        url = await ref.read(imageProvider).uploadImageToStorage(
            recipeId: recipeId != null ? recipeId : generatedId, image: image);
      }

      print("URL");
      print(url);

      RecipeModel newRecipe = RecipeModel(
          id: recipeId != null ? recipeId : generatedId,
          photo: url != null ? url : widget.editableRecipe!.photo,
          title: titleTXController.text,
          time: timeTXController.text,
          sliceIngre: ingredients,
          ingredients: filteredIngredients,
          sliceIns: steps);

      print(newRecipe);

      if (recipeId != null) {
        FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update(newRecipe.toJson());
      } else {
        FirebaseFirestore.instance
            .collection('recipes')
            .doc(generatedId)
            .set(newRecipe.toJson());
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    if (widget.editableRecipe != null) {
      timeTXController.text = widget.editableRecipe!.time!;
      titleTXController.text = widget.editableRecipe!.title!;
      steps = widget.editableRecipe!.sliceIns ?? [];
      ingredients = widget.editableRecipe!.sliceIngre ?? [];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imagePro = ref.watch(imageProvider);
    return SingleChildScrollView(
      child: loader
          ? Center(child: CircularProgressIndicator.adaptive())
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      children: [
                        if (imagePro.globalImage == null &&
                            widget.editableRecipe != null &&
                            widget.editableRecipe!.photo != null)
                          Stack(
                            children: [
                              Image.network(widget.editableRecipe!.photo!),
                              Positioned(
                                right: 5,
                                bottom: 5,
                                child: Card(
                                  color: Colors.white.withOpacity(0.4),
                                  child: IconButton(
                                      onPressed: () async {
                                        await ref
                                            .read(imageProvider)
                                            .chooseImage();
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        Icons.change_circle,
                                        color: Colors.white,
                                      )),
                                ),
                              )
                            ],
                          ),
                        imagePro.globalImage != null
                            ? Stack(
                                children: [
                                  Center(
                                    child: Image.memory(
                                      height: 200,
                                      imagePro.globalImage!,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Positioned(
                                    right: 5,
                                    bottom: 5,
                                    child: Card(
                                      color: Colors.white.withOpacity(0.4),
                                      child: IconButton(
                                          onPressed: () async {
                                            await ref
                                                .read(imageProvider)
                                                .chooseImage();
                                            setState(() {});
                                          },
                                          icon: Icon(
                                            Icons.change_circle,
                                            color: Colors.white,
                                          )),
                                    ),
                                  )
                                ],
                              )
                            : IconButton(
                                onPressed: () async {
                                  await ref.read(imageProvider).chooseImage();
                                  setState(() {});
                                },
                                icon: Container(
                                  height: 200,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Upload Image"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(Icons.upload)
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: titleTXController,
                    decoration: InputDecoration(hintText: "Title"),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: timeTXController,
                    decoration: InputDecoration(hintText: "Time"),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 20),
                    child: Text(
                      "Ingredients",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Card(
                    child: Container(
                      constraints: BoxConstraints(minHeight: 150),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 290,
                                  child: TextFormField(
                                    controller: inputIngreController,
                                    decoration: InputDecoration(
                                      hintText: "Ingredients as a sentence",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 2.0, horizontal: 10.0),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        borderSide: new BorderSide(),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      addIngredients();
                                    },
                                    icon: Icon(Icons.add)),
                              ],
                            ),
                          ),
                          Container(
                              height: 250,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: ListView(
                                children: ingredients
                                    .map((e) => Text(
                                        "${ingredients.indexOf(e) + 1}. $e"))
                                    .toList(),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 20),
                    child: Text(
                      "Steps",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Card(
                    child: Container(
                      constraints: BoxConstraints(minHeight: 150),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 290,
                                  child: TextFormField(
                                    controller: inputStepController,
                                    decoration: InputDecoration(
                                      hintText: "Steps #",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 2.0, horizontal: 10.0),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        borderSide: new BorderSide(),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: addStep, icon: Icon(Icons.add))
                              ],
                            ),
                          ),
                          Container(
                              height: 250,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: ListView(
                                children: steps
                                    .map((e) =>
                                        Text("${steps.indexOf(e) + 1}. $e"))
                                    .toList(),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.

                            if (widget.editableRecipe != null) {
                              await save(recipeId: widget.editableRecipe!.id!);
                            } else {
                              await save();
                            }

                            setState(() {
                              loader = false;
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
