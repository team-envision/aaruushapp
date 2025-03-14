import 'dart:io';

import 'package:AARUUSH_CONNECT/Common/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';



class AaruushAppScreen extends GetView<CommonController> {
  const AaruushAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getLandingPage(),
      builder: (context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!;
        } else {
          return    Scaffold(
            body: Center(
              child: Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.black,),
            ),

          );
        }
      },
    );
  }
}