import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/Events/event_list_model.dart';
import '../Screens/Home/controllers/home_controller.dart';

Widget eventCard(
    EventListModel event, VoidCallback onTap, HomeController homeController) {
  return Container(
    padding: const EdgeInsets.all(0),
    height: 250,
    width: 225,
    // margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(width: 2, color: Colors.white),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    ),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GestureDetector(
            onTap: onTap,
            child: CachedNetworkImage(
              alignment: Alignment.center,
              progressIndicatorBuilder: (ctx, url, progress) =>
                  Container(
                      height: Get.height,
                      width: Get.width,
                      color: Colors.black,),
              imageUrl: event.image!,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) =>
                  Image.asset("assets/images/error404.png"),
              width: 400,
              height: 250,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              backgroundColor: Color.fromRGBO(0, 0, 0, 0.777),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              fixedSize: const Size.fromWidth(130),
            ),
            child: Text(
              event.live ?? false
                  ? (homeController.state.regEvents.contains(event.id)
                      ? "Registered"
                      : "Register Now")
                  : "View Event",
              style: Get.theme.kVerySmallTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 255, 255, 0.85)),
            ),
          ),
        ),
      ],
    ),
  );
}
