import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constant/color.dart';
import '../../provider/user_ingredients/user_ingredients_provider.dart';

class GenerateButton extends ConsumerStatefulWidget {
  final Function() generate;
  const GenerateButton({super.key, required this.generate});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GenerateButtonState();
}

class _GenerateButtonState extends ConsumerState<GenerateButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Center(
        child: MaterialButton(
          color: color1,
          onPressed: () {
            widget.generate();
          },
          child: Container(
            height: 50,
            width: 300,
            child: Center(
              child: Text(
                "Generate",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ),
      );
    });
  }
}
