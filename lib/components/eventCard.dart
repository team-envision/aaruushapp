

import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/Events/event_list_model.dart';
import '../Screens/Home/home_controller.dart';

Widget eventCard(EventListModel event, VoidCallback onTap, HomeController controller) {

  return Container(
    padding: const EdgeInsets.all(16.0),
    height: 250,
    width: 250,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      border: Border.all(width: 2, color: Colors.white),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
    ),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GestureDetector(
          onTap: onTap,
          child: CachedNetworkImage(
            progressIndicatorBuilder: (ctx, url, progress) => CircularProgressIndicator(
              value: progress.progress,
              color: Get.theme.colorPrimary,
            ),
            imageUrl: event.image!,
            fit: BoxFit.fill,
            errorWidget: (context, url, error) => Image.asset("assets/images/error404.png"),
            width: 400,
            height: 250,
          ),
        ),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            backgroundColor: Get.theme.curveBG.withOpacity(0.7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            fixedSize: const Size.fromWidth(130),

          ),
          child: Text(
            event.live ?? false
                ? (controller.regEvents.contains(event.id) ? "Registered" : "Register Now")
                : "View Event",
            style: Get.theme.kVerySmallTextStyle,
          ),
        ),

      ],
    ),
  );
}