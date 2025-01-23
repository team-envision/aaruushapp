import 'dart:convert';
import 'dart:io';
import 'package:AARUUSH_CONNECT/Data/api_data.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/auth_screen.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/registerView.dart';
import 'package:AARUUSH_CONNECT/Screens/OnBoard/on_boarding_screen.dart';
import 'package:AARUUSH_CONNECT/Utilities/AaruushBottomBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../Model/Events/event_list_model.dart';

class CommonController extends GetxController {
  static RxString profileUrl = ''.obs;
  static RxString userName = ''.obs;
  static RxString emailAddress = ''.obs;

  static RxString aaruushId = ''.obs;
  static RxString phoneNumber = ''.obs;
  static RxString RegNo = ''.obs;
  static RxString college = ''.obs;
  static RxString uID = ''.obs;
  static RxMap<String, dynamic> userDetails = <String, dynamic>{}.obs;
  static RxBool isLoading = false.obs;
  static RxBool isEventRegistered = false.obs;
  Future<void> refreshUserData() async {
    resetUserData();
    await fetchAndLoadDetails();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    // await fetchAndLoadDetails();
  }

  // Future<bool> isUserSignedIn() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     await user.reload();
  //   }
  //   return user != null;
  // }

  Future<bool> isUserSignedIn() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.reload();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error checking user sign in status: $e");
      return false;
    }
  }

  Future<Widget> getLandingPage() async {
    bool isSignedIn = await isUserSignedIn();
    String? googleUser = GetStorage().read('userEmail');

    print(googleUser);
    bool isUserAvailableinFirebase =
        await isUserAvailableInFirebase(googleUser ?? "tester@gmail.com");
    print("isUserAvailableinFirebase");
    print(isUserAvailableinFirebase);
    print(googleUser);
    print(isSignedIn);
    if (isSignedIn && isUserAvailableinFirebase) {
      debugPrint("User signed in");
      return AaruushBottomBar();
    } else if (isSignedIn && !isUserAvailableinFirebase) {
      debugPrint("User not registered in firebase");
      return registerView();
    } else {
      debugPrint("User not signed in");
      return const OnBoardingScreen();
    }
  }

  User? getCurrentUser() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        user.reload();
      }
      return user;
    } catch (e) {
      debugPrint("Error getting current user: $e");
      return null;
    }
  }

  Future<bool> isUserAvailableInFirebase(String email) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      DocumentReference userDoc = users.doc(email);

      DocumentSnapshot userSnapshot = await userDoc.get();

      if (userSnapshot.exists) {
        if (kDebugMode) {
          print('User details are available.');
        }
        return true;
      } else {
        if (kDebugMode) {
          print('User details are not available.');
        }
        return false;
      }
    } catch (error) {
      if (kDebugMode) {
        print('Failed to check user availability: $error');
      }
      return false;
    }
  }

  void resetUserData() {
    profileUrl.value = '';
    userName.value = '';
    emailAddress.value = '';
    aaruushId.value = '';
    phoneNumber.value = '';
    RegNo.value = '';
    college.value = '';
    uID.value = '';
    userDetails.clear();
  }


  Future<void> signOutCurrentUser() async {
    try {
      final GoogleSignInAccount? googleUser = GoogleSignIn().currentUser;
      await FirebaseAuth.instance.signOut();
      GoogleSignIn().disconnect();
      googleUser?.clearAuthCache();
      GetStorage().erase();
      resetUserData(); // Add this line to clear user data
    } on FirebaseAuthException catch (e) {
      debugPrint("Error $e");
    }
    Get.offAll(() => const AuthScreen());
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    try {
      final userSignedIn = await isUserSignedIn();
      if (!userSignedIn) {
        debugPrint("User not signed in");
        return {"error": "User not found"};
      }

      final attributes = getCurrentUser();
      if (attributes == null || attributes.email == null) {
        debugPrint("User attributes not found");
        return {"error": "User attributes not found"};
      }

      final response = await get(
          Uri.parse('https://api.aaruush.org/api/v1/users/${attributes.email}'),
          headers: {'Authorization': ApiData.accessToken});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["message"] == "Unauthorized") {
          debugPrint("unauthorized");
          await signOutCurrentUser();
          return {"error": "Unauthorized"};
        }

        // Safely set values with null checks
        profileUrl.value = data['image'] ?? "";
        userName.value = data['name'] ?? "";
        emailAddress.value = data['email'] ?? "";
        aaruushId.value = data['aaruushId'] ?? "";
        phoneNumber.value = data['phone'] ??
            data["whatsapp"] ??
            data["phone number"] ??
            data["Whatsapp Number"] ??
            data["whatsappnumber"] ??
            data["whatsapp number"] ??
            "";
        RegNo.value = data['registration number (na if not applicable)'] ??
            data['college_id'] ??
            data['Registration Number'] ??
            "";
        college.value = data['college'] ??
            data['college (na if not applicable)'] ??
            data['college_name'] ??
            "";

        debugPrint("User details fetched successfully: $data");
        return data;
      } else {
        var data = jsonDecode(response.body);
        debugPrint("Error fetching user details: $data");
        return {"error": data};
      }
    } catch (e) {
      debugPrint("Exception in getUserDetails: $e");
      return {"error": "An unexpected error occurred"};
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

  void checkRegistered(EventListModel e) {
    if (userDetails['events'] != null) {
      isEventRegistered.value = userDetails['events'].contains(e.id);
    }
  }

  Future<void> fetchAndLoadDetails() async {
    try {
      isLoading.value = true;
      userDetails.value = await getUserDetails();
    } catch (e) {
      debugPrint("Error in fetchAndLoadDetails: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
