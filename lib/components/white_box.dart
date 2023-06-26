import 'dart:ui';

import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 10), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderSize),
      ),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderSize),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.center,
              stops: [
                0.245,
                0.8
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
