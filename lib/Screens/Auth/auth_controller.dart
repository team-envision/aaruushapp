import 'dart:convert';

import 'package:aarush/Common/common_controller.dart';
import 'package:aarush/Data/api_data.dart';
import 'package:aarush/Model/User/attributes.dart';
import 'package:aarush/Screens/Auth/registerView.dart';
import 'package:aarush/Screens/Home/home_screen.dart';
import 'package:aarush/Utilities/AaruushBottomBar.dart';
import 'package:aarush/Utilities/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

class AuthController extends GetxController {
  final CommonController common = Get.find();

  Future<void> googleSignIn() async {
    print(common.emailAddress);
    print(common.phoneNumber);
    print(common.userName);
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User canceled sign-in

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Get user attributes
      final User user = userCredential.user!;
      final userAttributes = UserAttributes(
        name: user.displayName!,
        email: user.email!,
        image: user.photoURL!,
      );

      // Post user data to your API
      final response = await post(
        Uri.parse('${ApiData.API}/users'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: userAttributes.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        debugPrint('Access token: ${data['accessToken']}');

        await GetStorage().write('accessToken', data['accessToken']);
print("common.emailAddress.value");
print(common.emailAddress.value);
        if(await common.isUserAvailable(common.emailAddress.value)){
          Get.offAll(() => AaruushBottomBar());
        }
        else{
          Get.offAll(() => registerView());
        }

      } else {
        setSnackBar('Error:', response.body,
            icon: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
            ));
        throw Exception('Failed to register user');
      }
    } on FirebaseAuthException catch (e) {
      setSnackBar('Error:', e.message!,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    } catch (e) {
      setSnackBar('Error:', e.toString(),
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    }
  }

  @override
  void onClose() {
    super.onClose();
    // Dispose any resources here if necessary
  }

  @override
  void dispose() {
    // Dispose any resources here if necessary
    super.dispose();
  }
}
