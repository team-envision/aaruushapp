import 'dart:convert';

import 'package:aarush/Common/common_controller.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class AuthController extends GetxController {
  //login crendetials
  final email = TextEditingController();
  final password = TextEditingController();

  //signup crendetials
  final name = TextEditingController();
  final college = TextEditingController();
  final registerNumber = TextEditingController();
  final phone = TextEditingController();
  final emailAddress = TextEditingController();
  final signupPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();

CommonController common=Get.find();
  Future<void> googleSignIn() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI(
        provider: AuthProvider.google,
      );

      common.fetchCurrentUserAttributes();

      // final response = await post(
      //     Uri.parse('https://api.aaruush.org/api/v1/users'),
      //     body: {
      //       name: ,
      //     });
      // if (response.statusCode == 200) {
      //   String data = utf8.decode(response.bodyBytes);
      //   List jsonResponse = json.decode(data);
      // } else {
      //   throw Exception('Failed to load events');
      // }
      safePrint('Sign in result: $result');
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    name.dispose();
    college.dispose();
    registerNumber.dispose();
    phone.dispose();
    emailAddress.dispose();
    signupPassword.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}
