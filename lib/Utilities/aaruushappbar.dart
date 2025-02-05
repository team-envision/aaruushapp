import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

AppBar AaruushAppBar(
    {required String title, List<Widget>? actions, double? fontsize}) {
  return AppBar(
    systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
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
    centerTitle: true,
    leadingWidth: 90,
    titleSpacing: 1,
    clipBehavior: Clip.none,
    titleTextStyle: TextStyle(fontSize: fontsize),
    leading: Padding(
      padding: const EdgeInsets.only(
        left: 0.0,
        bottom: 10,
      ),
      child: Image.asset(
        'assets/images/spinner.gif',
        fit: BoxFit.contain,
        alignment: Alignment.center,
      ),
    ),
    actions: actions?.asMap().entries.map((entry) {
      int index = entry.key;
      Widget action = entry.value;
      if (index == actions.length - 1) {
        return action;
      }
      return action;
    }).toList(),
    title: Text(
      title,
      style: Get.theme.kSubTitleTextStyle
          .copyWith(fontFamily: 'Xirod', fontSize: Get.width * 0.04),
    ),
  );
}
