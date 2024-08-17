import 'dart:convert';
import 'package:aarush/Data/api_data.dart';
import 'package:aarush/Screens/Auth/auth_screen.dart';
import 'package:aarush/Screens/OnBoard/on_boarding_screen.dart';
import 'package:aarush/Utilities/AaruushBottomBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/Events/event_list_model.dart';
import '../Services/notificationServices.dart';

class CommonController extends GetxController {
  var bottomBarIndex = 0.obs;
  var userName = ''.obs;
  var emailAddress = ''.obs;
  var profileUrl = ''.obs;
  var aaruushId = ''.obs;
  var phoneNumber = ''.obs;
  var RegNo = ''.obs;
  var college = ''.obs;
  var uID = ''.obs;
  var userDetails = <String, dynamic>{}.obs;
  var isLoading = false.obs;
  var isEventRegistered = false.obs;

@override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


  }



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
      return  AaruushBottomBar();
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

  Future<bool> isUserAvailable(String email) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');

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





  Future<void> signOutCurrentUser() async {
    try {
      final GoogleSignInAccount? googleUser = GoogleSignIn().currentUser;
      await FirebaseAuth.instance.signOut();
      googleUser?.clearAuthCache();
      GetStorage().erase();
    } on FirebaseAuthException catch (e) {
      debugPrint("Errr $e");
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
        phoneNumber.value = data['phone'] ?? data["whatsapp"] ?? data["phone number"] ?? data["Whatsapp Number"] ?? data["whatsappnumber"] ?? data["whatsapp number"] ?? "";
        RegNo.value = data['registration number (na if not applicable)'] ?? data['college_id'] ?? data['Registration Number'] ?? "";
        college.value = data['college'] ?? data['college (na if not applicable)'] ?? data['college_name'] ?? "";
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

  void checkRegistered(EventListModel e) {
    if (userDetails['events'] != null) {
      isEventRegistered.value = userDetails['events'].contains(e.id);
    }
  }

  Future<void> fetchAndLoadDetails() async {
    userDetails.value = await getUserDetails();
    // isEventRegistered.value = userDetails['events'].contains(e.id);
  }



}
