import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget profileTextField(
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
    padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
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
      style: Get.theme.kVerySmallTextStyle,
      decoration: InputDecoration(
        fillColor: Color.fromRGBO(23, 20, 20, 1),
        filled: true,
        labelText: label,
        labelStyle: Get.theme.kVerySmallTextStyle.copyWith(color: Colors.white70,fontSize: 14),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color.fromRGBO(244, 93, 8, 1), width: 2)),

        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white60, width: 2)),

        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white, width: 2)),

        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red, width: 2)),

        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red, width: 2)),
      ),
    ),
  );
}
