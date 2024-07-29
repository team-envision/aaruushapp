import 'package:aarush/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class primaryButton extends StatelessWidget {
  const primaryButton({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,),
      child: TextButton(
          style: TextButton.styleFrom(
              elevation: 4,
              padding: const EdgeInsets.all(10),
              fixedSize: Size.fromWidth(Get.width),
              backgroundColor: Get.theme.colorPrimary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19))),
          onPressed: onTap,
          child: Text(
            text,
            style: Get.theme.kSmallTextStyle,
          )),
    );
  }
}
