import 'package:aarush/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget textField(
    {required String? Function(String?) validator,
    required TextEditingController controller,
    TextInputType? keyboard,
    bool obscureText = false,
    bool enableSuggestions = true,
    bool autoCorrect = true,
    required String label}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    child: TextFormField(
      scrollPhysics: const BouncingScrollPhysics(),
      keyboardType: keyboard,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autoCorrect,
      controller: controller,
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
        labelStyle: Get.theme.kSmallTextStyle
            .copyWith(color: Get.theme.curveBG.withOpacity(0.4)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Get.theme.colorPrimary, width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Get.theme.colorPrimary, width: 2)),
      ),
    ),
  );
}
