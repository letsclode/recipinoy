// import 'package:flavorsph/adminweb/controllers/auth_controller.dart';
// import 'package:flavorsph/ui/common/ui_helpers.dart';
// import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
// import 'package:flavorsph/ui/widgets/full_screen_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../common/app_colors.dart';
// import '../views/recipe_list/save_button.dart';
// import 'ingredient_tile.dart';
// import 'step_tile.dart';

// class RecipeDetailPage extends StatefulWidget {
//   final RecipeModel data;
//   final List<String> availableIngredients;
//   final Function() updateData;
//   const RecipeDetailPage(
//       {super.key,
//       required this.data,
//       required this.availableIngredients,
//       required this.updateData});

//   @override
//   _RecipeDetailPageState createState() => _RecipeDetailPageState();
// }

// class _RecipeDetailPageState extends State<RecipeDetailPage>
//     with TickerProviderStateMixin {
//   late TabController _tabController;
//   late ScrollController _scrollController;
//   late RecipeModel currentData;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _scrollController = ScrollController(initialScrollOffset: 0.0);
//     currentData = widget.data;
//     _scrollController.addListener(() {
//       changeAppBarColor(_scrollController);
//     });
//   }

//   Color appBarColor = Colors.transparent;

//   changeAppBarColor(ScrollController scrollController) {
//     if (scrollController.position.hasPixels) {
//       if (scrollController.position.pixels > 2.0) {
//         setState(() {
//           appBarColor = AppColor.primary;
//         });
//       }
//       if (scrollController.position.pixels <= 2.0) {
//         setState(() {
//           appBarColor = Colors.transparent;
//         });
//       }
//     } else {
//       setState(() {
//         appBarColor = Colors.transparent;
//       });
//     }
//   }

//   // fab to write review
//   showFAB(TabController tabController) {
//     int reviewTabIndex = 2;
//     if (tabController.index == reviewTabIndex) {
//       return true;
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AnimatedContainer(
//           color: appBarColor,
//           duration: const Duration(milliseconds: 200),
//           child: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             centerTitle: true,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             systemOverlayStyle: SystemUiOverlayStyle.light,
//           ),
//         ),
//       ),
//       // Post Review FAB
//       floatingActionButton: Visibility(
//         visible: showFAB(_tabController),
//         child: FloatingActionButton(
//           onPressed: () {
//             showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     content: Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: 150,
//                       color: Colors.white,
//                       child: const TextField(
//                         keyboardType: TextInputType.multiline,
//                         minLines: 6,
//                         decoration: InputDecoration(
//                           hintText: 'Write your review here...',
//                         ),
//                         maxLines: null,
//                       ),
//                     ),
//                     actions: [
//                       Row(
//                         children: [
//                           SizedBox(
//                             width: 120,
//                             child: TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               style: TextButton.styleFrom(
//                                 foregroundColor: Colors.grey[600],
//                               ),
//                               child: const Text('cancel'),
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               child: ElevatedButton(
//                                 onPressed: () {},
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: AppColor.primary,
//                                 ),
//                                 child: const Text('Post Review'),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   );
//                 });
//           },
//           backgroundColor: AppColor.primary,
//           child: const Icon(Icons.edit),
//         ),
//       ),
//       body: ListView(
//         controller: _scrollController,
//         shrinkWrap: true,
//         padding: EdgeInsets.zero,
//         physics: const BouncingScrollPhysics(),
//         children: [
//           currentData.photo == null
//               ? Container(
//                   height: 280,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/images/no_image.png'),
//                           fit: BoxFit.fitHeight)),
//                   child: Container(
//                     decoration:
//                         BoxDecoration(gradient: AppColor.linearBlackTop),
//                     height: 280,
//                     width: MediaQuery.of(context).size.width,
//                   ),
//                 )
//               : GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => FullScreenImage(
//                             image: Image.network(currentData.photo!,
//                                 fit: BoxFit.cover))));
//                   },
//                   child: Container(
//                     height: 280,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: NetworkImage(currentData.photo!),
//                             fit: BoxFit.cover)),
//                     child: Container(
//                       decoration:
//                           BoxDecoration(gradient: AppColor.linearBlackTop),
//                       height: 280,
//                       width: MediaQuery.of(context).size.width,
//                     ),
//                   ),
//                 ),

//           // Section 2 - Recipe Info
//           Container(
//             width: MediaQuery.of(context).size.width,
//             padding:
//                 const EdgeInsets.only(top: 20, bottom: 30, left: 16, right: 16),
//             color: AppColor.primary,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Recipe Title
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 12, top: 16, left: 30),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         currentData.title!,
//                         style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'inter'),
//                       ),
//                       Consumer(builder: (context, ref, child) {
//                         final user = ref.read(authControllerProvider);
//                         return SavedButton(
//                           recipe: currentData,
//                           userId: user!.uid,
//                           isSave: currentData.likes.contains(user.uid),
//                         );
//                       })
//                     ],
//                   ),
//                 ),

//                 //TODO: add description
//                 // Recipe Description
//                 Text(
//                   currentData.description ?? '',
//                   style: TextStyle(
//                       color: Colors.white.withOpacity(0.9),
//                       fontSize: 14,
//                       height: 150 / 100),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: 60,
//             width: MediaQuery.of(context).size.width,
//             color: AppColor.secondary,
//             child: TabBar(
//               controller: _tabController,
//               onTap: (index) {
//                 setState(() {
//                   _tabController.index = index;
//                 });
//               },
//               labelColor: Colors.black,
//               unselectedLabelColor: Colors.black.withOpacity(0.6),
//               labelStyle: const TextStyle(
//                   fontFamily: 'inter', fontWeight: FontWeight.w500),
//               indicatorColor: Colors.black,
//               tabs: const [
//                 Tab(
//                   text: 'Ingredients',
//                 ),
//                 Tab(
//                   text: 'Tutorial',
//                 ),
//               ],
//             ),
//           ),
//           // IndexedStack based on TabBar index
//           IndexedStack(
//             index: _tabController.index,
//             children: [
//               // Ingridients
//               Column(
//                 children: [
//                   ListView.builder(
//                     shrinkWrap: true,
//                     padding: EdgeInsets.zero,
//                     itemCount: currentData.sliceIngre!.length,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return IngridientTile(
//                         userIngredients: widget.availableIngredients,
//                         data: currentData.sliceIngre![index],
//                       );
//                     },
//                   ),
//                   verticalSpaceMedium,
//                   Column(
//                     children: [
//                       Container(
//                         height: 60,
//                         width: double.infinity,
//                         color: Colors.grey[200],
//                         child: Center(
//                           child: Text(
//                             "Available Ingredients",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleSmall!
//                                 .copyWith(
//                                     color: AppColor.primary, fontSize: 15),
//                           ),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         padding: EdgeInsets.zero,
//                         itemCount: currentData.sliceIngre!
//                             .where((element) => widget.availableIngredients
//                                 .contains(element.toLowerCase()))
//                             .toList()
//                             .length,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return IngridientTile(
//                             userIngredients: widget.availableIngredients,
//                             data: currentData.sliceIngre!
//                                 .where((element) => widget.availableIngredients
//                                     .contains(element.toLowerCase()))
//                                 .toList()[index],
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                   verticalSpaceMedium,
//                   Column(
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         height: 60,
//                         color: Colors.grey[200],
//                         child: Center(
//                           child: Text(
//                             "Missing Ingredients",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleSmall!
//                                 .copyWith(
//                                     color: AppColor.primary, fontSize: 15),
//                           ),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         padding: EdgeInsets.zero,
//                         itemCount: currentData.sliceIngre!
//                             .where((element) => !widget.availableIngredients
//                                 .contains(element.toLowerCase()))
//                             .toList()
//                             .length,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return IngridientTile(
//                             userIngredients: widget.availableIngredients,
//                             isMissing: true,
//                             data: currentData.sliceIngre!
//                                 .where((element) => !widget.availableIngredients
//                                     .contains(element.toLowerCase()))
//                                 .toList()[index],
//                           );
//                         },
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               // Tutorials
//               ListView.builder(
//                 shrinkWrap: true,
//                 padding: EdgeInsets.zero,
//                 itemCount: currentData.sliceIns!.length,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return StepTile(
//                     data: currentData.sliceIns![index],
//                   );
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
