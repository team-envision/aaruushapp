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
  return TextFormField(
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
      fillColor: const Color.fromRGBO(23, 20, 20, 1),
      filled: true,
      label: FittedBox(child: Text(label)),
      labelStyle: Get.theme.kVerySmallTextStyle.copyWith(color: Colors.white70,fontSize: 14),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color.fromRGBO(244, 93, 8, 1), width: 2)),

      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white60, width: 2)),

      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 2)),

      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2)),

      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2)),
    ),
  );
}
