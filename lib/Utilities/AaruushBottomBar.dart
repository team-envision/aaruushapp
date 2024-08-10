import 'dart:ui';

import 'package:aarush/Common/common_controller.dart';
import 'package:aarush/Data/bottomIndexData.dart';
import 'package:aarush/Screens/Home/home_screen.dart';
import 'package:aarush/Screens/Profile/profilepage.dart';
import 'package:aarush/Screens/Tickets/myEvents.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class AaruushBottomBar extends StatelessWidget {
  AaruushBottomBar({
    super.key,

  });


  final RxInt _selectedIndex = 0.obs;

  final RxList<Widget> _screens = [HomeScreen(), MyEvents(),MyEvents(), ProfileScreen()].obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(extendBody: true,

      body: _screens[_selectedIndex.value],
      bottomNavigationBar:
          CurvedNavigationBar(
        color: Color.fromRGBO(239, 101, 34, 1),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color.fromRGBO(239, 101, 34, 1),
        height: 60,
        animationCurve: Curves.linear,
        animationDuration: Duration(milliseconds: 500),
        index: _selectedIndex.value,
        onTap: (index) {
          _selectedIndex.value = index;
        },
        items: [
          Image.asset("assets/AppBarIcons/home.png",scale: 2.2,),
          Image.asset("assets/AppBarIcons/map.png",scale: 2.2,),
          Image.asset("assets/AppBarIcons/calendar.png",scale: 2.2,),
          Image.asset("assets/AppBarIcons/user.png",scale: 2.2,)

        ],
      ),
      ),
    );
  }
}
