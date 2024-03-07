// import 'package:flavorsph/ui/common/ui_helpers.dart';
// import 'package:flavorsph/ui/modal/register.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';

// import '../../common/app_colors.dart';
// import '../../modal/login.dart';
// import 'welcome_page_viewmodel.dart';

// class WelcomePageView extends StackedView<WelcomePageViewModel> {
//   const WelcomePageView({super.key});

//   @override
//   Widget builder(
//     BuildContext context,
//     WelcomePageViewModel viewModel,
//     Widget? child,
//   ) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Stack(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage('assets/images/bg.jpg'),
//                     fit: BoxFit.cover)),
//           ),
//           Positioned(
//             bottom: 0,
//             child: Container(
//               padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(gradient: AppColor.linearBlackBottom),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(bottom: 16),
//                         child: Text('FlavorsPH',
//                             style: TextStyle(
//                                 fontFamily: 'inter',
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 32,
//                                 color: Colors.white)),
//                       ),
//                       Text(
//                         "Ingredients in hand, let us craft the perfect recipe for your success!",
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodySmall!
//                             .copyWith(color: Colors.white),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                   verticalSpaceSmall,
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // Get Started Button
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width,
//                         height: 45,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             showModalBottomSheet(
//                               context: context,
//                               backgroundColor: Colors.white,
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(20),
//                                       topRight: Radius.circular(20))),
//                               isScrollControlled: true,
//                               builder: (context) {
//                                 return const RegisterModal();
//                               },
//                             );
//                             // viewModel.getStarted();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10)),
//                             backgroundColor: AppColor.primarySoft,
//                           ),
//                           child: Text('Register',
//                               style: TextStyle(
//                                   color: AppColor.secondary,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   fontFamily: 'inter')),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width,
//                         height: 45,
//                         child: OutlinedButton(
//                           onPressed: () {
//                             showModalBottomSheet(
//                               context: context,
//                               backgroundColor: Colors.white,
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(20),
//                                       topRight: Radius.circular(20))),
//                               isScrollControlled: true,
//                               builder: (context) {
//                                 return const LoginModal();
//                               },
//                             );
//                           },
//                           style: OutlinedButton.styleFrom(
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10)),
//                             side: BorderSide(
//                                 color: AppColor.secondary.withOpacity(0.5),
//                                 width: 1),
//                           ),
//                           child: Text('Log in',
//                               style: TextStyle(
//                                   color: AppColor.secondary,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   fontFamily: 'inter')),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ));
//   }

//   @override
//   WelcomePageViewModel viewModelBuilder(
//     BuildContext context,
//   ) =>
//       WelcomePageViewModel();
// }
