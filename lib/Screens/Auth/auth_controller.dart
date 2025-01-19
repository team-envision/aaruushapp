import 'dart:convert';

import 'package:AARUUSH_CONNECT/Common/common_controller.dart';
import 'package:AARUUSH_CONNECT/Data/api_data.dart';
import 'package:AARUUSH_CONNECT/Model/User/attributes.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/registerView.dart';
import 'package:AARUUSH_CONNECT/Utilities/AaruushBottomBar.dart';
import 'package:AARUUSH_CONNECT/Utilities/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';


class AuthController extends GetxController {
  final CommonController common = Get.find();


  bool isSigningIn = false;

  Future<void> googleSignIn() async {
    if (isSigningIn) return; // Prevent multiple sign-in attempts
    isSigningIn = true;

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;


      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;


      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );


      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);


      final User user = userCredential.user!;
      final userAttributes = UserAttributes(
        name: user.displayName!,
        email: user.email!,
        image: user.photoURL!,
      );


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
        print(googleUser.email);
        print(googleUser.displayName);
        await GetStorage().write('userEmail', googleUser.email);
        await GetStorage().write('userName', googleUser.displayName);
        if (await common.isUserAvailableInFirebase(googleUser.email)) {
          Get.offAll(() => AaruushBottomBar());
        } else {
          Get.to(() => registerView());
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
    } finally {
      isSigningIn = false; // Reset the flag
    }
  }

  Future<void> appleSignIn() async {
    try {
      final AuthorizationCredentialAppleID appleCredential =
      await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      final User user = userCredential.user!;

      final String name = (user.displayName ??
          '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}')
          .trim()
          .isEmpty
          ? 'Name'
          : (user.displayName ??
          '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}')
          .trim();

      if (user.displayName == null || user.displayName!.isEmpty) {
        await user.updateDisplayName(name);
        await user.reload(); // Refresh the user object to reflect changes
      }

      final String email = user.email ?? appleCredential.email ?? '';

      if (email.isNotEmpty) {
        final response = await post(
          Uri.parse('${ApiData.API}/users'),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode({'name': name, 'email': email}),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final data = json.decode(response.body);
          await GetStorage().write('accessToken', data['accessToken']);
          await GetStorage().write('userEmail', email);
          await GetStorage().write('userName', name);

          if (await common.isUserAvailableInFirebase(email)) {
            Get.offAll(() => AaruushBottomBar());
          } else {
            Get.to(() => registerView());
          }
        } else {
          throw Exception('Failed to register user: ${response.body}');
        }
      } else {
        throw Exception('Email is required but not provided.');
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
  }  @override
  void onClose() {
    super.onClose();

  }

  @override
  void dispose() {

    super.dispose();
  }
}
