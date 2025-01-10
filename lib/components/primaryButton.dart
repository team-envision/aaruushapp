import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class primaryButton extends StatelessWidget {
  primaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isDisabled = false,
    this.borderRadius = 19.0,
    this.buttonheight,

  });
  final String text;
  final VoidCallback onTap;
  bool? isDisabled;
  final double borderRadius;
  final buttonheight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonheight,
      child: TextButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(10),
              fixedSize: Size.fromWidth(Get.width),
              backgroundColor:
                  isDisabled! ? Colors.grey : Get.theme.colorPrimary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius))),
          onPressed: isDisabled! ? null : onTap,
          child: Text(
            text,
            style: Get.theme.kSmallTextStyle,
          )),
    );
  }
}
