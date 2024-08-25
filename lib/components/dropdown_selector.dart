import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget dropDownSelector(
    {required String hint,
    required dynamic Function(dynamic) onChanged,
    required String value,
    bool enabled=true,
    required List<dynamic> list}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
    margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Get.theme.curveBG),
    child: DropdownButton<dynamic>(
      isExpanded: true,
      onChanged: enabled?onChanged:null,
      underline: const SizedBox(),
      hint: Text(
        value.isEmpty ? hint : "$hint: $value",
        style: Get.theme.kSubTitleTextStyle,
      ),
      items: list.map((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: Get.theme.kSubTitleTextStyle,
          ),
        );
      }).toList(),
    ),
  );
}
