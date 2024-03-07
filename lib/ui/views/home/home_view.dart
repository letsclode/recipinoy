import 'package:firebase_ui_auth/firebase_ui_auth.dart';
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
                  ),
                ),
              );
            },
          ),
          // const SignOutButton(),
        ],
        backgroundColor: AppColor.primary,
        elevation: 0,
        centerTitle: true,
        title: Text('Generate Recipe',
            style: TextStyle(
                fontFamily: 'inter',
                color: AppColor.whiteSoft,
                fontWeight: FontWeight.w400,
                fontSize: 16)),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
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
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 17),
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
                child: viewModel.ingredients.length == 0
                    ? const Center(
                        child: Text("Ops no ingredients added"),
                      )
                    : ListView.builder(
                        itemCount: viewModel.ingredients.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
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
                              tileColor: Color.fromARGB(255, 255, 64, 0),
                              leading: Text('${index + 1}.'),
                              title: Text('${viewModel.ingredients[index]}'),
                            ),
                          );
                        }),
              ),
              ElevatedButton(
                  onPressed: viewModel.ingredientsEmpty
                      ? null
                      : viewModel.goToGeneratePage,
                  child: Text("Generate"))
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
