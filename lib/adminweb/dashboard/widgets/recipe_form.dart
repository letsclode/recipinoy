// Create a Form widget.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
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

  Future<List<String>> sendPostRequest() async {
    var response = await http.post(
        Uri(path: 'https://cloderaldo.pythonanywhere.com/api/modify_array'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"values": ingredients}));

    if (response.statusCode == 201 || response.statusCode == 200) {
      final json = (jsonDecode(response.body) as Map<String, dynamic>);

      return json['message'] as List<String>;
    }
    return [];
  }

  Future save() async {
    setState(() {
      loader = true;
    });
    try {
      //TODO: add photo description ingredients
      final data = sendPostRequest();
      print(data);
      // RecipeModel newRecipe = RecipeModel(titleTXController.text, null, null,
      //     timeTXController.text, null, ingredients, steps, []);
      // FirebaseFirestore.instance
      //     .collection('recipes')
      //     .doc()
      //     .set(newRecipe.toJson());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SingleChildScrollView(
      child: loader
          ? Center(child: CircularProgressIndicator.adaptive())
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            await save();
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
