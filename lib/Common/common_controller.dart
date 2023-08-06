import 'dart:convert';

import 'package:aarush/Data/api_data.dart';
import 'package:aarush/Screens/Auth/auth_screen.dart';
import 'package:aarush/Screens/Home/home_screen.dart';
import 'package:aarush/Screens/OnBoard/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonController extends GetxController {
  var bottomBarIndex = 0.obs;
  var userName = ''.obs;
  var emailAddress = ''.obs;
  var profileUrl = ''.obs;
  var uID = ''.obs;

  void changeBottomBarIndex(int index) {
    bottomBarIndex.value = index;
  }

  Future<bool> isUserSignedIn() async {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<Widget> getLandingPage() async {
    final isSignedIn = await isUserSignedIn();
    if (isSignedIn) {
      return const HomeScreen();
    } else {
      return const OnBoardingScreen();
    }
  }

  User getCurrentUser() {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    return user!;
  }

  Future<void> signOutCurrentUser() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().disconnect();
    await FirebaseAuth.instance.signOut();
    googleUser?.clearAuthCache();
    Get.offAll(() => const AuthScreen());
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    final userSignedIn = await isUserSignedIn();
    if (!userSignedIn) {
      return {"error": "User not found"};
    } else {
      final attributes = getCurrentUser();
      final response = await get(
          Uri.parse('https://api.aaruush.org/api/v1/users/${attributes.email}'),
          headers: {'Authorization': ApiData.accessToken});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["message"] == "Unauthorized") {
          debugPrint("unauthorized");
          signOutCurrentUser();
        }
        userName.value = data['name'];
        emailAddress.value = data['email'];
        profileUrl.value = data['image'];
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
  void onInit() async {
    await getUserDetails();
    super.onInit();
  }
}
