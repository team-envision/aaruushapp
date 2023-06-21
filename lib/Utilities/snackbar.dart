

import 'package:aarush/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void setSnackBar(String title, String message,
    {int seconds = 3,
    SnackPosition? position,
    bool? progressIndicator,
    bool? dismissible,
    Widget? icon,
    LinearGradient? gradient,
    bool? pulse}) {
  Get.snackbar(title, message,
      duration: Duration(seconds: seconds),
      snackPosition: position,
      shouldIconPulse: pulse,
      margin: const EdgeInsets.all(10),
      isDismissible: dismissible,
      backgroundGradient: gradient,
      colorText: Get.theme.btnTextCol,
      icon: icon,
      titleText: Text(
        title,
        style: Get.theme.kSmallTextStyle,
      ),
      messageText: Text(
        message,
        style: Get.theme.kVerySmallTextStyle,
      ),
      backgroundColor: Get.theme.curveBG.withOpacity(0.7),
      showProgressIndicator: progressIndicator,
      snackStyle: SnackStyle.FLOATING);
}
