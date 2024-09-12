import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBox extends StatelessWidget {
  const CustomBox(
      {super.key,
      required this.margin,
      required this.child,
      this.bordersize = 40,
      this.boxShadowOpacity = 0.4,
      this.colourOpacity = 0.2});
  final double bordersize;
  final EdgeInsets margin;
  final double? boxShadowOpacity;
  final double? colourOpacity;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    double borderSize = bordersize;
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(boxShadowOpacity!),
            spreadRadius: 0,
          ),
        ],
        color: Colors.transparent.withOpacity(colourOpacity!),
        borderRadius: BorderRadius.circular(borderSize),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderSize),
          gradient: RadialGradient(
              radius: 1.1,
              focalRadius: 8,
              center: const Alignment(0.7, -0.1),
              stops: const [
                0.298,
                1,
              ],
              colors: [
                Get.theme.colorPrimary.withOpacity(0.2),
                Get.theme.colorPrimaryDark.withAlpha(0),
              ]),
        ),
        child: child,
      ),
    );
  }
}
