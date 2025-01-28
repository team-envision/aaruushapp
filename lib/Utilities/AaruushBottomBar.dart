import 'package:AARUUSH_CONNECT/Screens/Home/views/home_screen.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/views/profilepage.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/views/myEvents.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/TimeLine/timeline_view.dart';

// Controller to manage bottom navigation bar state
class BottomNavController extends GetxController {
  int selectedIndex = 0;

  void updateIndex(int index) {
    selectedIndex = index;
    update(); // Notify GetBuilder to rebuild widgets
  }
}

class AaruushBottomBar extends StatelessWidget {
  AaruushBottomBar({super.key});

  final List<Widget> screens = [
     HomeScreen(),
    MyEvents(fromProfile: false),
    const TimelineView(),
     ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          body: screens[controller.selectedIndex],
          bottomNavigationBar: CurvedNavigationBar(
            color: Get.theme.colorPrimary,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Get.theme.colorPrimary,
            height: 60,
            animationCurve: Curves.linear,
            animationDuration: const Duration(milliseconds: 350),
            index: controller.selectedIndex,
            onTap: (index) {
              controller.updateIndex(index);
            },
            items: [
              Image.asset(
                "assets/AppBarIcons/home.png",
                scale: 2.2,
              ),
              Image.asset(
                "assets/AppBarIcons/map.png",
                scale: 2.2,
              ),
              Image.asset(
                "assets/AppBarIcons/calendar.png",
                scale: 2.2,
              ),
              Image.asset(
                "assets/AppBarIcons/user.png",
                scale: 2.2,
              ),
            ],
          ),
        );
      },
    );
  }
}