import 'package:aarush/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Utilities/appBarBlur.dart';

AppBar AaruushAppBar({required String title, List<Widget>? actions,double? fontsize}) {
  return AppBar(
    backgroundColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.scrolledUnder)) {
        return Colors.black87;
      } else {
        return Colors.transparent;
      }
    }),
    foregroundColor: Colors.transparent,
    // flexibleSpace: appBarBlur(),
    elevation: 0,
    centerTitle: true,leadingWidth: 90,titleSpacing: 1,clipBehavior: Clip.none,
    titleTextStyle: TextStyle(fontSize: fontsize),
    leading: Image.asset(
      'assets/images/aaruush.png',fit: BoxFit.contain,alignment: Alignment.center,
    ),
    actions: actions,
    title: Text(
      title,
      style: Get.theme.kSubTitleTextStyle.copyWith(fontFamily: 'Xirod'),
    ),
  );
}
