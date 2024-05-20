import 'package:flavorsph/adminweb/controllers/auth_controller.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flavorsph/ui/views/recipe_list/save_button.dart';
import 'package:flavorsph/ui/widgets/full_screen_image.dart';
import 'package:flavorsph/ui/widgets/step_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constant/color.dart';
import '../common/app_colors.dart';
import 'ingredient_tile.dart';

class RecipeDetailPage2 extends StatefulWidget {
  final RecipeModel data;
  final List<String>? availableIngredients;
  const RecipeDetailPage2(
      {super.key, required this.data, this.availableIngredients});

  @override
  _RecipeDetailPage2State createState() => _RecipeDetailPage2State();
}

class _RecipeDetailPage2State extends State<RecipeDetailPage2>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  late RecipeModel currentData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    currentData = widget.data;
    _scrollController.addListener(() {
      changeAppBarColor(_scrollController);
    });
  }

  Color appBarColor = Colors.transparent;

  changeAppBarColor(ScrollController scrollController) {
    if (scrollController.position.hasPixels) {
      if (scrollController.position.pixels > 2.0) {
        setState(() {
          appBarColor = AppColor.primary;
        });
      }
      if (scrollController.position.pixels <= 2.0) {
        setState(() {
          appBarColor = Colors.transparent;
        });
      }
    } else {
      setState(() {
        appBarColor = Colors.transparent;
      });
    }
  }

  // fab to write review
  showFAB(TabController tabController) {
    int reviewTabIndex = 2;
    if (tabController.index == reviewTabIndex) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: color1,
        title: Image.asset('assets/images/title.png'),
      ),
      // Post Review FAB

      body: ListView(
        controller: _scrollController,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          Stack(
            children: [
              currentData.photo == null
                  ? Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/no_image.png'),
                              fit: BoxFit.fitHeight)),
                      child: Container(
                        decoration:
                            BoxDecoration(gradient: AppColor.linearBlackTop),
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FullScreenImage(
                                image: Image.network(currentData.photo!,
                                    fit: BoxFit.cover))));
                      },
                      child: Container(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(currentData.photo!),
                                fit: BoxFit.cover)),
                        child: Container(
                          decoration:
                              BoxDecoration(gradient: AppColor.linearBlackTop),
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
              Consumer(builder: (context, ref, child) {
                final user = ref.watch(authControllerProvider);

                return Positioned(
                  bottom: 10,
                  right: 10,
                  child: SavedButton(
                    userId: user!.uid,
                    recipe: currentData,
                    isSave: currentData.likes.contains(user.uid),
                  ),
                );
              })
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
              color: color1,
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  currentData.title ?? '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'inter'),
                ),
              ),
            ),
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: AppColor.secondary,
            child: TabBar(
              controller: _tabController,
              onTap: (index) {
                setState(() {
                  _tabController.index = index;
                });
              },
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black.withOpacity(0.6),
              labelStyle: const TextStyle(
                  fontFamily: 'inter', fontWeight: FontWeight.w500),
              indicatorColor: Colors.black,
              tabs: const [
                Tab(
                  text: 'Ingredients',
                ),
                Tab(
                  text: 'Procedures',
                ),
              ],
            ),
          ),
          // IndexedStack based on TabBar index
          IndexedStack(
            index: _tabController.index,
            children: [
              // Ingridients
              Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: currentData.sliceIngre!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return IngridientTile(
                        userIngredients: widget.availableIngredients ?? [],
                        data: currentData.sliceIngre![index],
                      );
                    },
                  ),
                ],
              ),
              // Procedures
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: currentData.sliceIns!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return StepTile(
                    data: currentData.sliceIns![index],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
