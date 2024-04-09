import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flavorsph/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      key: viewModel.key,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Ingredients",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    children: viewModel.availableIngredients
                        .map((e) => GestureDetector(
                              onTap: () {
                                viewModel.addAvailableIngredient(
                                    ingredient: e, context: context);
                              },
                              child: Card(
                                elevation: 2,
                                color: viewModel.ingredients.contains(e.title)
                                    ? Colors.white38
                                    : Colors.white,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Image.asset(
                                      e.image,
                                      fit: BoxFit.fill,
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        e.title,
                                        style: TextStyle(
                                            color: viewModel.ingredients
                                                    .contains(e.title)
                                                ? Colors.grey
                                                : Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Liquid Ingredients",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    children: viewModel.liquidIngredients
                        .map((e) => GestureDetector(
                              onTap: () {
                                viewModel.addAvailableIngredient(
                                    ingredient: e, context: context);
                              },
                              child: Card(
                                elevation: 2,
                                color: viewModel.ingredients.contains(e.title)
                                    ? Colors.white38
                                    : Colors.white,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Image.asset(
                                      e.image,
                                      fit: BoxFit.fill,
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        e.title,
                                        style: TextStyle(
                                            color: viewModel.ingredients
                                                    .contains(e.title)
                                                ? Colors.grey
                                                : Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Meat",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    children: viewModel.meatIngredients
                        .map((e) => GestureDetector(
                              onTap: () {
                                viewModel.addAvailableIngredient(
                                    ingredient: e, context: context);
                              },
                              child: Card(
                                elevation: 2,
                                color: viewModel.ingredients.contains(e.title)
                                    ? Colors.white38
                                    : Colors.white,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Image.asset(
                                      e.image,
                                      fit: BoxFit.fill,
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        e.title,
                                        style: TextStyle(
                                            color: viewModel.ingredients
                                                    .contains(e.title)
                                                ? Colors.grey
                                                : Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => AuthGate()),
                            (route) => false);
                      })
                    ],
                  ),
                ),
              );
            },
          ),
        ],
        backgroundColor: AppColor.primary,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 145,
        leading: Container(
          height: 40,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  height: 25,
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                      viewModel.goToSaveRecipes(context);
                    },
                    child: Text(
                      "Saved Recipe's", //DARK ORANGE
                      style: TextStyle(color: Color.fromARGB(255, 255, 64, 0)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        title: Text('Generate Recipe',
            style: TextStyle(
                fontFamily: 'inter',
                color: AppColor.whiteSoft,
                fontWeight: FontWeight.w400,
                fontSize: 16)),
      ),
      body: Container(
        child: Column(
          children: [
            // Section 1 - Search
            Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              color: AppColor.primary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Search TextField
                        Expanded(
                          child: Container(
                            height: 45,
                            margin: const EdgeInsets.only(right: 15),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.primarySoft),
                            child: TextField(
                              focusNode: viewModel.focusNode,
                              controller: viewModel.searchInputController,
                              onChanged: (value) {
                                print(viewModel.searchInputController.text);
                              },
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                              maxLines: 1,
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                hintText: 'Available ingredient?',
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.2)),
                                prefixIconConstraints:
                                    const BoxConstraints(maxHeight: 20),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 17),
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Visibility(
                                  visible: (viewModel
                                          .searchInputController.text.isEmpty)
                                      ? true
                                      : false,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 12),
                                    child: SvgPicture.asset(
                                      'assets/icons/discover.svg',
                                      width: 20,
                                      height: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            if (viewModel
                                .searchInputController.text.isNotEmpty) {
                              viewModel.addIngredient(context: context);
                            }
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColor.secondary,
                            ),
                            child: const Icon(Icons.add),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [],
                ),
                Expanded(
                  child: viewModel.ingredients.length == 0
                      ? const Center(
                          child: Text(
                              "Select ingredients or type it at the top \n to add your available ingredients."),
                        )
                      : ListView.builder(
                          itemCount: viewModel.ingredients.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ListTile(
                                  trailing: IconButton(
                                      onPressed: () {
                                        viewModel.removeIngredient(
                                            ingredientToRemove:
                                                viewModel.ingredients[index]);
                                      },
                                      icon: Icon(
                                        Icons.remove_circle_outlined,
                                        color: Colors.white.withOpacity(0.8),
                                      )),
                                  textColor: Colors.white,
                                  visualDensity: VisualDensity.compact,

                                  tileColor: Color.fromARGB(255, 247, 104, 56),
                                  // leading: Checkbox(
                                  //     value: viewModel.selectedIngredients
                                  //         .contains(viewModel.ingredients[index]),
                                  //     onChanged: (value) {
                                  //       if (value!) {
                                  //         viewModel.selectIngredients(
                                  //             viewModel.ingredients[index]);
                                  //       } else {
                                  //         viewModel.unselect(
                                  //             viewModel.ingredients[index]);
                                  //       }
                                  //     }),
                                  title:
                                      Text('${viewModel.ingredients[index]}'),
                                ),
                              ),
                            );
                          }),
                )
              ],
            )),

            Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: viewModel.clearAll,
                          icon: Icon(
                            Icons.restart_alt_rounded,
                            color: Colors.red[900],
                          )),
                      Text('Clear')
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: viewModel.viewIngredients,
                          icon: Icon(
                            Icons.cookie_outlined,
                            color: Colors.green[900],
                          )),
                      Text('Ingredients')
                    ],
                  ),
                  ElevatedButton(
                      onPressed: viewModel.ingredientsEmpty
                          ? null
                          : viewModel.goToGeneratePage,
                      child: Text("Generate")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.popolateAllIngredients();
    super.onViewModelReady(viewModel);
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
