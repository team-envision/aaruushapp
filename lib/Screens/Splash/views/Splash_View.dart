import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Get.theme.colorPrimary,
        ),
      ),
    );
  }
}
