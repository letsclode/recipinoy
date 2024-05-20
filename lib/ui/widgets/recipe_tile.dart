import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../common/app_colors.dart';
import 'recipe_detail_page2.dart';

class RecipeTile extends StatefulWidget {
  final RecipeModel data;
  final List<String>? availableIngredients;

  const RecipeTile({
    super.key,
    this.availableIngredients,
    required this.data,
  });

  @override
  State<RecipeTile> createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  late Color percentColor;

  @override
  void initState() {
    print("DATA");
    print('availableIngredients ${widget.availableIngredients}');
    if (widget.data.similarity != null) {
      setState(() {
        if (widget.data.similarity! > 0.5) {
          percentColor = Colors.green;
        } else if (widget.data.similarity! > 2.5) {
          percentColor = Colors.orange;
        } else {
          percentColor = Colors.red;
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RecipeDetailPage2(
                  data: widget.data,
                  availableIngredients: widget.availableIngredients,
                )));
      },
      child: Card(
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColor.whiteSoft,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  // Recipe Photo
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blueGrey,
                      //TODO: image from database
                      image: widget.data.photo == null
                          ? const DecorationImage(
                              image: AssetImage('assets/images/no_image.png'),
                              fit: BoxFit.cover)
                          : DecorationImage(
                              image: NetworkImage(widget.data.photo!),
                              fit: BoxFit.cover),
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
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    softWrap: true,
                                    widget.data.title ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'inter'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 260,
                                child: Text(
                                  widget.data.time ?? '',
                                  style: const TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          // Recipe Calories and Time
                        ],
                      ),
                    ),
                  ),
                  widget.data.similarity != null
                      ? SizedBox(
                          height: 60,
                          width: 60,
                          child: CircularPercentIndicator(
                            radius: 30.0,
                            lineWidth: 5.0,
                            animation: true,
                            percent: widget.data.similarity ?? 0,
                            center: Text(
                              (widget.data.similarity! * 100)
                                  .toStringAsFixed(1),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10.0),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: percentColor,
                          ),
                        )
                      : Stack(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 50,
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Center(
                                child: Text(
                                  widget.data.likes.length.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
