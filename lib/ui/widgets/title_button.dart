import 'package:flavorsph/constant/color.dart';
import 'package:flutter/material.dart';

class TitleButton extends StatefulWidget {
  final String title;
  const TitleButton({super.key, required this.title});

  @override
  State<TitleButton> createState() => _TitleButtonState();
}

class _TitleButtonState extends State<TitleButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: MaterialButton(
          color: color1,
          onPressed: () {},
          child: Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
