import 'package:flavorsph/constant/basic_ingredients.dart';
import 'package:flutter/material.dart';

class IngridientTile extends StatelessWidget {
  final String data;
  final bool isMissing;
  final List<String> userIngredients;
  const IngridientTile(
      {super.key,
      required this.data,
      this.isMissing = false,
      required this.userIngredients});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
          color: isMissing
              ? lowercaseBasicIngredients.contains(data.toLowerCase())
                  ? Colors.white
                  : Colors.red[50]
              : Colors.white,
          border:
              Border(bottom: BorderSide(color: Colors.grey[350]!, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 9,
            child: Text(
              data,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, height: 150 / 100),
            ),
          ),
          if (userIngredients.isNotEmpty)
            userIngredients.contains(data.toLowerCase())
                ? Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.close,
                    color: Colors.red,
                  )
        ],
      ),
    );
  }
}
