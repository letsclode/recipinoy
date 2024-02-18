import 'package:flavorsph/ui/common/ui_helpers.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../common/app_colors.dart';
import 'full_screen_image.dart';
import 'ingredient_tile.dart';
import 'step_tile.dart';

class RecipeDetailPage extends StatefulWidget {
  final RecipeModel data;
  final List<String> availableIngredients;
  const RecipeDetailPage(
      {super.key, required this.data, required this.availableIngredients});

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0.0);
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AnimatedContainer(
          color: appBarColor,
          duration: const Duration(milliseconds: 200),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text('Recipe Details',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 16)),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
      ),
      // Post Review FAB
      floatingActionButton: Visibility(
        visible: showFAB(_tabController),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      color: Colors.white,
                      child: const TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 6,
                        decoration: InputDecoration(
                          hintText: 'Write your review here...',
                        ),
                        maxLines: null,
                      ),
                    ),
                    actions: [
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.grey[600],
                              ),
                              child: const Text('cancel'),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                ),
                                child: const Text('Post Review'),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                });
          },
          backgroundColor: AppColor.primary,
          child: const Icon(Icons.edit),
        ),
      ),
      body: ListView(
        controller: _scrollController,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          // Section 1 - Recipe Image
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FullScreenImage(
                      image:
                          Image.asset(widget.data.photo!, fit: BoxFit.cover))));
            },
            child: Container(
              height: 280,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.data.photo!),
                      fit: BoxFit.cover)),
              child: Container(
                decoration: BoxDecoration(gradient: AppColor.linearBlackTop),
                height: 280,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          // Section 2 - Recipe Info
          Container(
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.only(top: 20, bottom: 30, left: 16, right: 16),
            color: AppColor.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recipe Calories and Time
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/fire-filled.svg',
                      color: Colors.white,
                      width: 16,
                      height: 16,
                    ),
                    const Icon(Icons.alarm, size: 16, color: Colors.white),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        widget.data.time!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                // Recipe Title
                Container(
                  margin: const EdgeInsets.only(bottom: 12, top: 16),
                  child: Text(
                    widget.data.title!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'inter'),
                  ),
                ),
                // Recipe Description
                Text(
                  widget.data.description!,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      height: 150 / 100),
                ),
              ],
            ),
          ),
          // Tabbar ( Ingridients, Tutorial, Reviews )
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
                  text: 'Tutorial',
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
                    itemCount: widget.data.ingridients!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return IngridientTile(
                        data: widget.data.ingridients![index],
                      );
                    },
                  ),
                  verticalSpaceMedium,
                  Column(
                    children: [
                      Text(
                        "Available Ingredients",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: widget.data.ingridients!
                            .where((element) => widget.availableIngredients
                                .contains(element.name))
                            .toList()
                            .length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return IngridientTile(
                            data: widget.data.ingridients!
                                .where((element) => widget.availableIngredients
                                    .contains(element.name))
                                .toList()[index],
                          );
                        },
                      ),
                    ],
                  ),
                  verticalSpaceMedium,
                  Column(
                    children: [
                      Text(
                        "Missing Ingredients",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: widget.data.ingridients!
                            .where((element) => !widget.availableIngredients
                                .contains(element.name))
                            .toList()
                            .length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return IngridientTile(
                            data: widget.data.ingridients!
                                .where((element) => !widget.availableIngredients
                                    .contains(element.name))
                                .toList()[index],
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
              // Tutorials
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.data.tutorial!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return StepTile(
                    data: widget.data.tutorial![index],
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
