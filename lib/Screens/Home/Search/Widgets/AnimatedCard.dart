import 'package:AARUUSH_CONNECT/Common/core/Routes/app_routes.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/controllers/home_controller.dart';
import 'package:AARUUSH_CONNECT/components/eventCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../state/Search_State.dart';

final HomeController homeController = Get.find<HomeController>();
final SearchState state = Get.find<SearchState>();

Widget buildAnimatedCard(
    BuildContext context, int index, Animation<double> animation) {
  var event = state.eventList[index];
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
          child: eventCard(
            event:  event,
            onTap: ()=>Get.toNamed(AppRoutes.eventScreen),
            homeController:  homeController,
          )));
}
