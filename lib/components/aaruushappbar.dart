import 'package:aarush/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Utilities/appBarBlur.dart';

AppBar AaruushAppBar({required String title, List<Widget>? actions}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.transparent,
    flexibleSpace: appBarBlur(),
    elevation: 0,
    centerTitle: true,
    leading: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SvgPicture.asset(
        'assets/images/aaruush.svg',
      ),
    ),
    actions: actions,
    title: Text(
      title,
      style: Get.theme.kSubTitleTextStyle.copyWith(fontFamily: 'Xirod'),
    ),
  );
}
