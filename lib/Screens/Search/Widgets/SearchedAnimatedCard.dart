import 'package:AARUUSH_CONNECT/Screens/Events/views/events_screen.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/controllers/home_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Search/state/Search_State.dart';
import 'package:AARUUSH_CONNECT/components/eventCard.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final HomeController homeController = Get.find<HomeController>();
final SearchState state = Get.find<SearchState>();


Widget buildSearchedAnimatedCard(
    BuildContext context, int index, Animation<double> animation) {
  var event = state.searchResults[index];
  return FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          child: OpenContainer(
            middleColor: Colors.transparent,
            openColor: Colors.transparent,
            closedColor: Colors.transparent,
            closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            transitionDuration: const Duration(milliseconds: 400),
            transitionType: ContainerTransitionType.fadeThrough,
            openBuilder: (context, _) => EventsScreen(
              event: event,
              fromMyEvents: false.obs,
            ),
            closedBuilder: (context, openContainer) => eventCard(
              event,
              openContainer,
              homeController,
            ),
          )));
}
