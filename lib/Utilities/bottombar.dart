import 'dart:ui';

import 'package:aarush/Common/common_controller.dart';
import 'package:aarush/Data/bottomIndexData.dart';
import 'package:aarush/Model/Events/event_list_model.dart';
import 'package:aarush/Screens/Events/events_screen.dart';
import 'package:aarush/Screens/Home/home_screen.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AaruushBottomBar extends GetView<CommonController> {
  const AaruushBottomBar({
    super.key,
    required this.bottomIndex,
  });
  final int bottomIndex;
  @override
  Widget build(BuildContext context) {
    controller.changeBottomBarIndex(bottomIndex);
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          elevation: 0,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              controller.bottomBarIndex.value == BottomIndexData.HOME
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Get.theme.curveBG.withOpacity(0.5),
                      ),
                      child: _bottomIcons(
                          onTap: () => {Get.to(() => const HomeScreen())},
                          icon: Icons.home_rounded))
                  : _bottomIcons(
                      onTap: () => {Get.to(() => const HomeScreen())},
                      icon: Icons.home_rounded),
              controller.bottomBarIndex.value == BottomIndexData.FILES
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Get.theme.curveBG.withOpacity(0.5),
                      ),
                      child: _bottomIcons(
                          onTap: () => {Get.to(() => HomeScreen())},
                          icon: Icons.confirmation_number_rounded))
                  : _bottomIcons(
                      onTap: () => {Get.to(() => HomeScreen())},
                      icon: Icons.confirmation_number_rounded),
              controller.bottomBarIndex.value == BottomIndexData.SEARCH
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Get.theme.curveBG.withOpacity(0.5),
                      ),
                      child: _bottomIcons(
                          onTap: () => {
                                // Get.to(() => EventsScreen(event: EventListModel(),))
                              },
                          icon: Icons.person_rounded))
                  : _bottomIcons(
                      onTap: () => {
                            // Get.to(() =>  EventsScreen(event: EventListModel()))
                          },
                      icon: Icons.person_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomIcons({required VoidCallback onTap, required IconData icon}) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon),
      color: Colors.white,
      iconSize: 25,
    );
  }
}
