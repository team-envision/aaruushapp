import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBox extends StatelessWidget {
  const CustomBox(
      {super.key,

        required this.margin,
        required this.child,
        this.bordersize=40});
  final double bordersize;
  final EdgeInsets margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    double borderSize = bordersize;
    return
      Container(

        margin: margin,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0,
            ),
          ],
          color: Colors.transparent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(borderSize),
        ),
        child: Container(
          // height: height!+100,
          // width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderSize),
            gradient: RadialGradient(

                center: const Alignment(0.7, -0.6),

                stops: [
                  0.298,
                  1,
                ],
                colors: [
                  Get.theme.colorPrimary.withOpacity(0.1),
                  Get.theme.colorPrimaryDark.withAlpha(0),
                ]),
          ),
          child: child,
        ),
      );
  }
}