
import 'package:AARUUSH_CONNECT/Screens/Home/home_screen.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/profilepage.dart';
import 'package:AARUUSH_CONNECT/Screens/Tickets/myEvents.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/TimeLine/timeline_view.dart';

class AaruushBottomBar extends StatelessWidget {
  AaruushBottomBar({
    super.key,

  });


  final RxInt _selectedIndex = 0.obs;

  final RxList<Widget> _screens = [const HomeScreen(), MyEvents(),TimelineView(), const ProfileScreen()].obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(extendBody: true,
      body: _screens[_selectedIndex.value],
      bottomNavigationBar:
          CurvedNavigationBar(
        color: const Color.fromRGBO(239, 101, 34, 1),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: const Color.fromRGBO(239, 101, 34, 1),
        height: 60,
        animationCurve: Curves.linear,
        animationDuration: const Duration(milliseconds: 350),
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
