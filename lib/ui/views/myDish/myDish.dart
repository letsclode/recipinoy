import 'package:flavorsph/constant/color.dart';
import 'package:flavorsph/ui/views/myDish/widgets/createDIsh.dart';
import 'package:flavorsph/ui/views/myDish/widgets/viewDish.dart';
import 'package:flutter/material.dart';

class MyDish extends StatefulWidget {
  const MyDish({super.key});

  @override
  State<MyDish> createState() => _MyDishState();
}

class _MyDishState extends State<MyDish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              scrollControlDisabledMaxHeightRatio: 2,
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              builder: (context) => const CreateDish());
        },
        backgroundColor: color1,
        child: Icon(Icons.add),
      ),
      body: ViewDish(),
    );
  }
}
