import 'dart:convert';

import 'package:aarush/Data/api_data.dart';
import 'package:aarush/Screens/Auth/auth_screen.dart';
import 'package:aarush/Screens/Home/home_screen.dart';
import 'package:aarush/Screens/OnBoard/on_boarding_screen.dart';
import 'package:aarush/amplifyconfiguration.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonController extends GetxController {
  var bottomBarIndex = 0.obs;

  void changeBottomBarIndex(int index) {
    bottomBarIndex.value = index;
  }

  Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    return result.isSignedIn;
  }

  Future<Widget> getLandingPage() async {
    final isSignedIn = await isUserSignedIn();
    if (isSignedIn) {
      return const HomeScreen();
    } else {
      return const OnBoardingScreen();
    }
  }

  Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    // debugPrint("USER INFO $user");
    return user;
  }

  Future<Map<String, dynamic>> fetchCurrentUserAttributes() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      final data = {for (var e in attributes) e.userAttributeKey.key: e.value};
      // debugPrint('User attributes: $data');
      return data;
    } on AuthException catch (e) {
      safePrint('Error fetching user attributes: ${e.message}');
      return {"error": e.message};
    }
  }

  Future<void> signOutCurrentUser() async {
    final result = await Amplify.Auth.signOut();
    if (result is CognitoCompleteSignOut) {
      Get.offAll(() => const AuthScreen());
      safePrint('Sign out completed successfully');
    } else if (result is CognitoFailedSignOut) {
      safePrint('Error signing user out: ${result.exception.message}');
    }
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    final userSignedIn = await isUserSignedIn();
    if (!userSignedIn) {
      return {"error": "User not found"};
    } else {
      final attributes = await fetchCurrentUserAttributes();
      final response = await get(
          Uri.parse(
              'https://api.aaruush.org/api/v1/users/${attributes['email']}'),
          headers: {'Authorization': ApiData.accessToken});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["message"] == "Unauthorized") {
          debugPrint("unauthorized");
          signOutCurrentUser();
        }
        // debugPrint("User details: $data");
        return data;
      } else {
        var data = jsonDecode(response.body);
        debugPrint("Error data $data");
        return {"error": data};
      }
    }
  }

  @override
  void onInit() {
    // configureAmplify();
    // debugPrint("Access token: ${ApiData.accessToken}");
    super.onInit();
  }
}
