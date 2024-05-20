import 'package:flavorsph/ui/views/favourite/favourite_view.dart';
import 'package:flavorsph/ui/views/home/home_view.dart';
import 'package:flavorsph/ui/views/myDish/myDish.dart';
import 'package:flutter/material.dart';

import '../../../constant/color.dart';
import '../profile/profile.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: color1,
        title: Image.asset('assets/images/title.png'),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          backgroundColor: color1,
          currentIndex: _selectedIndex,
          onTap: (index) {
            print("TAP");
            setState(() {
              _selectedIndex = index;
              _pageController.jumpToPage(_selectedIndex);
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu), label: 'Food'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border), label: 'favourite'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Profile')
          ]),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          HomeView(),
          MyDish(),
          FavoriteView(),
          Profile(),
        ],
        onPageChanged: (page) {
          print('Page change');
          setState(() {
            _selectedIndex = page;
          });
        },
      ),
    );
  }
}
