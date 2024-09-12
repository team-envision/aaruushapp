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
    margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
    decoration: BoxDecoration(border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12), color: Color.fromRGBO(23, 20, 20, 1)),
    child: DropdownButton<dynamic>(
      isExpanded: true, padding: const EdgeInsets.only(left: 10, top: 5,bottom: 5),
      onChanged: enabled?onChanged:null,
      underline: const SizedBox(),iconSize: 40,
      hint: FittedBox(
        child: RichText(
            text: TextSpan(text: "$hint:",
          children: [
            TextSpan(
                text: value.isEmpty ? "" : " $value" ,
                style: TextStyle(color: Colors.white)
            )],
          style: Get.theme.kSmallTextStyle.copyWith(color: Colors.white54,fontSize: 16),
        )),
      ),

      items: list.map((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: Get.theme.kSubTitleTextStyle.copyWith(color: Colors.white,fontSize: 18),
          ),
        );
      }).toList(),
    ),
  );
}
