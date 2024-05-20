import 'package:flavorsph/adminweb/user/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'recipe/dashboard.dart';
import 'drawer/drawer.dart';
import 'drawer/drawer_index_provider.dart';
import 'feedbacks/feedback_screen.dart';
import 'responsive.dart';
import 'settings/settings_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final pages = [
    const DashboardScreen(),
    const FeedbackScreen(),
    const SettingsScreen(),
    const UserScreen()
  ];
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(drawerIndexProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leadingWidth: 200,
        // leading: Row(
        //   children: [
        //     SizedBox(
        //       width: 20,
        //     ),
        //     Container(
        //       width: 40,
        //       height: 40,
        //       child: Image.asset("assets/images/logo.png"),
        //     ),
        //   ],
        // ),
        title:
            Text(['Recipes', 'Feedbacks', 'Settings', 'Users'][currentIndex]),
        automaticallyImplyLeading: Responsive.isDesktop(context) ? false : true,
      ),
      drawer: const KDrawer(),
      body: Container(
        child: Row(
          children: [
            Visibility(
                visible: Responsive.isDesktop(context),
                child: const Expanded(child: KDrawer())),
            Expanded(flex: 4, child: pages[currentIndex])
          ],
        ),
      ),
    );
  }
}
