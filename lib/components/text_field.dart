import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget textField(
    {required String? Function(String?) validator,
    TextEditingController? controller,
    TextInputType? keyboard,
    bool obscureText = false,
    bool enableSuggestions = true,
    bool autoCorrect = true,
    bool? enabled = true,
    String? initialValue,
    Function(String)? onChanged,
    required String label}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    child: TextFormField(
      scrollPhysics: const BouncingScrollPhysics(),
      keyboardType: keyboard,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      enabled: enabled,
      obscureText: obscureText,
      initialValue: initialValue,
      enableSuggestions: enableSuggestions,
      autocorrect: autoCorrect,
      controller: controller,
      onChanged: onChanged,
      style: Get.theme.kVerySmallTextStyle.copyWith(color: Colors.black),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        // prefixIcon: Icon(
        //   icon,
        //   // color: Get.theme.btnTextCol,
        // ),
        // icon: Icon(
        //   icon,
        //   color: Get.theme.btnTextCol,
        // ),
        labelText: label,
        labelStyle: Get.theme.kSmallTextStyle.copyWith(color: Colors.black),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Get.theme.colorPrimary, width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Get.theme.colorPrimary, width: 2)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Get.theme.colorPrimary, width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Get.theme.colorPrimary, width: 2)),
      ),
    ),
  );
}
