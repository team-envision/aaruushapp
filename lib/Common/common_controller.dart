import 'package:aarush/Screens/Home/home_screen.dart';
import 'package:aarush/Screens/OnBoard/on_boarding_screen.dart';
import 'package:aarush/amplifyconfiguration.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
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
    return user;
  }

  Future<Map<String, dynamic>> fetchCurrentUserAttributes() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      final data = {for (var e in attributes) e.userAttributeKey.key: e.value};
      debugPrint('User attributes: $attributes');
      return data;
    } on AuthException catch (e) {
      safePrint('Error fetching user attributes: ${e.message}');
      return {"error": e.message};
    }
  }

  @override
  void onInit() {
    // configureAmplify();
    super.onInit();
  }
}
