// import 'package:flutter/material.dart';
// import 'package:flutter_gif/flutter_gif.dart';

// class FoodLoader extends StatefulWidget {
//   const FoodLoader({super.key});

//   @override
//   State<FoodLoader> createState() => _FoodLoaderState();
// }

// class _FoodLoaderState extends State<FoodLoader> with TickerProviderStateMixin {
//   late FlutterGifController controller;
//   @override
//   void initState() {
//     controller = FlutterGifController(vsync: this);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GifImage(
//       controller: controller,
//       image: const AssetImage("assets/images/animate.gif"),
//     );
//   }
// }
