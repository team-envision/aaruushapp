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

import '../Model/Events/event_list_model.dart';

class CommonController extends GetxController {
  var bottomBarIndex = 0.obs;
  var userName = ''.obs;
  var emailAddress = ''.obs;
  var profileUrl = ''.obs;
  var aaruushId = ''.obs;
  var phoneNumber = ''.obs;
  var uID = ''.obs;
  var userDetails = <String, dynamic>{}.obs;
  var isLoading = false.obs;

  void changeBottomBarIndex(int index) {
    bottomBarIndex.value = index;
  }

  Future<bool> isUserSignedIn() async {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<Widget> getLandingPage() async {
    final isSignedIn = await isUserSignedIn();
    if (isSignedIn) {
      debugPrint("User signed in");
      return const HomeScreen();
    } else {
      debugPrint("User not signed in");
      return const OnBoardingScreen();
    }
  }

  User getCurrentUser() {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    return user!;
  }

  Future<void> signOutCurrentUser() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().currentUser;
      await FirebaseAuth.instance.signOut();
      googleUser?.clearAuthCache();
    } on FirebaseAuthException catch (e) {
      debugPrint("Errr ${e}");
    }
    Get.offAll(() => const AuthScreen());
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    final userSignedIn = await isUserSignedIn();
    if (!userSignedIn) {
      debugPrint("User not signed in");
      return {"error": "User not found"};
    } else {
      debugPrint("User signed in");
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
        userName.value = data['name'] ?? "";
        emailAddress.value = data['email'] ?? "";
        profileUrl.value = data['image'] ?? "";
        aaruushId.value = data['aaruushId'] ?? "";
        phoneNumber.value = data['phone'] ?? "";
        debugPrint("User details: $data");
        return data;
      } else {
        var data = jsonDecode(response.body);
        debugPrint("Error data $data");
        return {"error": data};
      }
    }
  }

  List<String> registeredEvents() {
    List<String> events = [];
    if (userDetails['events'] != null) {
      for (var event in userDetails['events']) {
        events.add(event);
      }
    }
    return events;
  }

  Future<void> fetchAndLoadDetails() async {
    userDetails.value = await getUserDetails();
  }

  @override
  void onInit() async {
    super.onInit();
  }
}
