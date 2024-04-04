import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: OnBoardingSlider(
        onFinish: () async {
          //TODO save ref
          print("DONE");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          bool? firstTime = prefs.getBool('first_time');

          if (firstTime == null) {
            prefs.setBool('first_time', false);
          }

          printStatus(firstTime.toString());

          Navigator.popAndPushNamed(context, '/startup-view');
        },
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Register',
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: Colors.green,
        ),
        skipTextButton: Text('Skip'),
        centerBackground: true,
        background: [
          Image.asset('assets/images/slide_1.png'),
          Image.asset('assets/images/slide_2.png'),
          Image.asset('assets/images/slide_3.png'),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text(
                    'Recipinoy is a helpful app designed to generate recipes based on your available ingredients. It not only suggests recipes but also compiles a list of the nearest recipes you can cook with the ingredients you input.'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text(
                    'First, input or choose your ingredients. After that, this app generates a list of recipes and ranks them based on the nearest recipes to the inputted ingredients'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text(
                    'If you click on one of the recipes in the list, it will show you all the ingredients, indicating which ones match the available ingredients and what are the missing ingredients that need to be provided. Additionally, you can view the cooking instructions. You also have the option to save the recipe, which will be stored in your history of saved recipes'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
