import 'dart:ui';

import 'package:aarush/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class WhiteBox extends StatelessWidget {
  const WhiteBox(
      {super.key,
       this.height,
      required this.width,
      required this.margin,
      required this.child});
  final double? height;
  final double width;
  final EdgeInsets margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const double borderSize = 40;
    return
      Container(
      height: height,
      width: width,
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
        height: height!+100,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderSize),
          gradient: RadialGradient(

              center: Alignment(0.7, -0.6),

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
