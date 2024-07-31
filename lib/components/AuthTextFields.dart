
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class AuthTextFields extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final IconData? icon;
  final RxBool isPasswordObsecure;
  final  IconButton? suffixIcon;


  AuthTextFields({
    required this.hintText,
    this.controller,
    this.validator,
    this.obscureText = true,
    this.icon,
    this.suffixIcon,
    required this.isPasswordObsecure
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
    controller: controller,
    obscureText: isPasswordObsecure.value,


    decoration: InputDecoration(
      hintText: hintText,hintStyle: TextStyle(fontSize: 14),suffixIcon: suffixIcon,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.white),

      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
      ),

    ),
    validator: validator,
        );
  }
}
