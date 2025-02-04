
import 'package:AARUUSH_CONNECT/Screens/Stage/controllers/Stage_Controller.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
Widget AaruushBottomBar(){
 final StageController stageController = Get.find<StageController>();
  return CurvedNavigationBar(
    color: Get.theme.colorPrimary,
    backgroundColor: Colors.transparent,
    // buttonBackgroundColor: Get.theme.colorPrimary,
    height: 60,
    animationCurve: Curves.linear,
    animationDuration: const Duration(milliseconds: 350),
    index: stageController.index.value,
    onTap: (index) {
      stageController.updateBottomNavBarIndex(index);
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
  );
}