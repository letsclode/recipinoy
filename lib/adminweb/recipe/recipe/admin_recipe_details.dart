import 'package:flavorsph/ui/common/app_colors.dart';
import 'package:flavorsph/ui/common/ui_helpers.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flavorsph/ui/widgets/ingredient_tile.dart';
import 'package:flavorsph/ui/widgets/step_tile.dart';
import 'package:flutter/material.dart';

class AdminRecipeDetails extends StatefulWidget {
  final RecipeModel data;
  const AdminRecipeDetails({super.key, required this.data});

  @override
  _AdminRecipeDetailsState createState() => _AdminRecipeDetailsState();
}

class _AdminRecipeDetailsState extends State<AdminRecipeDetails>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0.0);
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
          //TODO: ADD PHOTO
          // Section 1 - Recipe Image
          if (widget.data.photo != null)
            GestureDetector(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => FullScreenImage(
                //         image: Image.network(widget.data.photo!,
                //             fit: BoxFit.cover))));
              },
              child: Column(
                children: [
                  Container(
                    height: 280,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.data.photo!),
                            fit: BoxFit.cover)),
                    child: Container(
                      decoration:
                          BoxDecoration(gradient: AppColor.linearBlackTop),
                      height: 280,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
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
                // Recipe Title
                Container(
                  margin: const EdgeInsets.only(bottom: 12, top: 16, left: 30),
                  child: Center(
                    child: Text(
                      widget.data.title!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'inter'),
                    ),
                  ),
                ),

                //TODO: add description
                // Recipe Description
                // Text(
                //   widget.data.description!,
                //   style: TextStyle(
                //       color: Colors.white.withOpacity(0.9),
                //       fontSize: 14,
                //       height: 150 / 100),
                // ),
              ],
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
                    itemCount: widget.data.sliceIngre!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return IngridientTile(
                        userIngredients: [],
                        data: widget.data.sliceIngre![index],
                      );
                    },
                  ),
                  verticalSpaceMedium,
                ],
              ),
              // Tutorials
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.data.sliceIns!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return StepTile(
                    data: widget.data.sliceIns![index],
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
