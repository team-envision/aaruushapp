import 'dart:convert';

import 'package:aarush/Common/common_controller.dart';
import 'package:aarush/Data/api_data.dart';
import 'package:aarush/Model/User/attributes.dart';
import 'package:aarush/Screens/Home/home_screen.dart';
import 'package:aarush/Utilities/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

class AuthController extends GetxController {
  CommonController common = Get.find();
  Future<void> googleSignIn() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        var attributes = common.getCurrentUser();
        final userAttributes = UserAttributes(
          name: attributes.displayName!,
          email: attributes.email!,
          image: attributes.photoURL!,
        );
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
          setSnackBar('Error:', response.body,
              icon: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
              ));
          throw Exception('Something went wrong');
        }
      });
    } on FirebaseAuthException catch (e) {
      setSnackBar('Error:', e.message!,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
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
