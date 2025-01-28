import 'dart:convert';
import 'package:AARUUSH_CONNECT/Common/core/Routes/app_routes.dart';
import 'package:AARUUSH_CONNECT/Common/core/Storage_Resources/local_client.dart';
import 'package:AARUUSH_CONNECT/Data/api_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Model/Events/event_list_model.dart';
import '../../Screens/Auth/OnBoard/views/on_boarding_screen.dart';

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
  // void resetProfileData() {
  //   final profileController = Get.put(ProfileController());
  //   profileController.resetProfileData();
  // }

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


  static Future<bool> isUserSignedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
    }
    return user != null;
  }


  // Future<Widget> getLandingPage() async {
  //   bool isSignedIn = await isUserSignedIn();
  //   String? googleUser = GetStorage().read('userEmail');
  //
  //   print(googleUser);
  //   bool isUserAvailableinFirebase =
  //       await isUserAvailableInFirebase(googleUser ?? "tester@gmail.com");
  //   print("isUserAvailableinFirebase");
  //   print(isUserAvailableinFirebase);
  //   print(googleUser);
  //   print(isSignedIn);
  //   if (isSignedIn && isUserAvailableinFirebase) {
  //     debugPrint("User signed in");
  //     return AaruushBottomBar();
  //   } else if (isSignedIn && !isUserAvailableinFirebase) {
  //     debugPrint("User not registered in firebase");
  //     return RegisterView();
  //   } else {
  //     debugPrint("User not signed in");
  //     return const OnBoardingScreen();
  //   }
  // }

  static Future<User?> getCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user; // Directly return the current user if not null
      }
      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase Signin Error: ${e.message}");
      return null;
    }
  }

  static Future<bool> isUserAvailableInFirebase(String email) async {
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

  Future<void> signOutCurrentUser() async {
    try {
      final GoogleSignInAccount? googleUser = GoogleSignIn().currentUser;
      await googleUser?.clearAuthCache();
      await FirebaseAuth.instance.signOut();
      await LocalClient.clearAll();
      await GoogleSignIn().disconnect();
      await GoogleSignIn().signOut();

      // await _deleteCacheDir();
      // await _deleteAppDir();
    } on FirebaseAuthException catch (e) {
      debugPrint("Errr $e");
    }
    Get.offAllNamed(AppRoutes.onBoarding);
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    RxBool userSignedIn = (await isUserSignedIn()).obs;
    if (!(userSignedIn.value)) {
      debugPrint("User not signed in");
      return {"error": "User not found"};
    } else {
      debugPrint("User signed in");
      Rx<User?> attributes = (await getCurrentUser()).obs;
      final response = await get(
          Uri.parse(
              'https://api.aaruush.org/api/v1/users/${attributes.value?.email}'),
          headers: {'Authorization': ApiData.accessToken});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["message"] == "Unauthorized") {
          debugPrint("unauthorized");
          signOutCurrentUser();
        }
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
        debugPrint("User details: $data");
        update();
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
    update();
    // isEventRegistered.value = userDetails['events'].contains(e.id);
  }


}
