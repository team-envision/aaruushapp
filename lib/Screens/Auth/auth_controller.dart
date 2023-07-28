import 'dart:convert';

import 'package:aarush/Common/common_controller.dart';
import 'package:aarush/Data/api_data.dart';
import 'package:aarush/Model/User/attributes.dart';
import 'package:aarush/Screens/Home/home_screen.dart';
import 'package:aarush/Utilities/snackbar.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class AuthController extends GetxController {
  CommonController common = Get.find();
  Future<void> googleSignIn() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI(
        provider: AuthProvider.google,
      );

      var attributes = await common.fetchCurrentUserAttributes();
      final userAttributes = UserAttributes(
          name: attributes['name'],
          email: attributes['email'],
          image: attributes['picture']);
      final response = await post(Uri.parse('${ApiData.API}/users'),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: userAttributes.toJson());
      // debugPrint('Response status: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        debugPrint('Access token: ${data['accessToken']}');
        GetStorage().write('accessToken', data['accessToken']).then((v) {
          Get.off(() => HomeScreen());
        });
      } else {
        setSnackBar('Error:', response.body,icon: const Icon(Icons.warning_amber_rounded,color: Colors.red,));
        throw Exception('Something went wrong');
      }

      safePrint('Sign in result: $result');
    } on AuthException catch (e) {
      setSnackBar('Error:', e.message,icon: const Icon(Icons.warning_amber_rounded,color: Colors.red,));
      safePrint('Error signing in: ${e.message}');
    }
  }

  @override
  void onClose() {
    // email.dispose();
    // password.dispose();
    // name.dispose();
    // college.dispose();
    // registerNumber.dispose();
    // phone.dispose();
    // emailAddress.dispose();
    // signupPassword.dispose();
    // confirmPassword.dispose();
    super.onClose();
  }
}
