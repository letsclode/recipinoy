import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../common/app_colors.dart';
import 'recipe_detail_page.dart';

class RecipeTile extends StatefulWidget {
  final RecipeModel data;
  final List<String> availableIngredients;
  const RecipeTile(
      {super.key, required this.data, required this.availableIngredients});

  @override
  State<RecipeTile> createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  late Color percentColor;
  @override
  void initState() {
    setState(() {
      if (widget.data.similarity! > 0.5) {
        percentColor = Colors.green;
      } else if (widget.data.similarity! > 2.5) {
        percentColor = Colors.orange;
      } else {
        percentColor = Colors.red;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RecipeDetailPage(
                  data: widget.data,
                  availableIngredients: widget.availableIngredients,
                )));
      },
      child: Container(
        height: 90,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.whiteSoft,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Recipe Photo
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blueGrey,
                image: DecorationImage(
                    image: AssetImage(widget.data.photo!), fit: BoxFit.cover),
              ),
            ),
            // Recipe Info
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recipe title
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        widget.data.title!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontFamily: 'inter'),
                      ),
                    ),
                    // Recipe Calories and Time
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/fire-filled.svg',
                          width: 12,
                          height: 12,
                        ),
                        const Icon(
                          Icons.alarm,
                          size: 14,
                          color: Colors.black,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(
                            widget.data.time!,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: 60,
              child: CircularPercentIndicator(
                radius: 30.0,
                lineWidth: 5.0,
                animation: true,
                percent: widget.data.similarity ?? 0,
                center: Text(
                  "${(widget.data.similarity! * 100).toStringAsFixed(1) ?? 0}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: percentColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
