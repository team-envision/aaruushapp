import 'dart:convert';
import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Common/core/Routes/app_routes.dart';
import 'package:AARUUSH_CONNECT/Common/core/Storage_Resources/local_client.dart';
import 'package:AARUUSH_CONNECT/Common/core/Storage_Resources/local_key.dart';
import 'package:AARUUSH_CONNECT/Common/core/Utils/Logger/app_logger.dart';
import 'package:AARUUSH_CONNECT/Data/api_data.dart';
import 'package:AARUUSH_CONNECT/Model/User/attributes.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/Register/views/Register_View.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/Signin/state/SignIn_state.dart';
import 'package:AARUUSH_CONNECT/Screens/Stage/Widget/AaruushBottomBar.dart';
import 'package:AARUUSH_CONNECT/Utilities/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInController extends GetxController {
  final CommonController commonController;
  final SignInState state;

  SignInController({
    required this.commonController,
    required this.state
});



  Future<void> googleSignIn() async {
    if (state.isSigningIn) return; // Prevent multiple sign-in attempts
    state.isSigningIn = true;

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

        await LocalClient.saveString(key: 'accessToken', value: data['accessToken']);
        Log.highlight("Access Token: " + data['accessToken']);
        Log.highlight("googleUserName: ${googleUser.displayName}. googleUserEmail: ${googleUser.email}");
        await LocalClient.saveString(key: 'userEmail',value:  googleUser.email);
        await LocalClient.saveString(key: 'userName',value:  googleUser.displayName ?? "");
        if (await CommonController.isUserAvailableInFirebase(googleUser.email)) {
          Get.offAllNamed(AppRoutes.stage);
        } else {
          Get.toNamed(AppRoutes.registerView);
        }
      } else {
        setSnackBar('Error:', response.body,
            icon: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
            ));
        throw Exception('Failed to register user');
      }
    } on FirebaseAuthException catch (e,stackTrace) {
      Log.verbose("Error in SignIn Controller(google): ",[e,stackTrace]);
      setSnackBar('Error:', e.message ?? "Something Went Wrong",
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    } catch (stackTrace,e) {
      Log.verbose("Error in SignIn Controller(google) : ",[e,stackTrace]);
      setSnackBar('Error:', "Something Went Wrong",
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    } finally {
      state.isSigningIn = false; // Reset the flag
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
          await LocalClient.saveString(key: LocalKeys.accessToken,value: data['accessToken']);

          await LocalClient.saveString(key: LocalKeys.userEmail, value: email);
          await LocalClient.saveString(key: LocalKeys.userName, value: name);
          Log.highlight("Access Token: ${data['accessToken']}");
          Log.highlight("appleUserName: $name. appleUserEmail: $email");
          if (await CommonController.isUserAvailableInFirebase(email)) {
            Get.offAllNamed(AppRoutes.aaruushBottomBar);
          } else {
            Get.toNamed(AppRoutes.registerView);
          }
        } else {
          throw Exception('Failed to register user: ${response.body}');
        }
      } else {
        throw Exception('Email is required but not provided.');
      }
    } on FirebaseAuthException catch (e,stackTrace) {
      Log.verbose("Error in SignIn Controller(apple): ",[e,stackTrace]);
      setSnackBar('Error:', e.message!,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    } catch (e,stackTrace) {
      Log.verbose("Error in SignIn Controller(apple): ",[e,stackTrace]);
      setSnackBar('Error:', e.toString(),
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    }
  }

}
