import 'dart:convert';
import 'package:AARUUSH_CONNECT/Common/core/Routes/app_routes.dart';
import 'package:AARUUSH_CONNECT/Common/core/Storage_Resources/local_client.dart';
import 'package:AARUUSH_CONNECT/Common/core/Utils/Logger/app_logger.dart';
import 'package:AARUUSH_CONNECT/Data/api_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import '../../Model/Events/event_list_model.dart';

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
    await fetchAndLoadDetails();
    super.onInit();
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
        return user;
      }
      return null;
    } on FirebaseAuthException catch (e, stacktrace) {
      Log.verbose("Firebase Signing Error:", [e, stacktrace]);
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
        Log.info('User details are available.');

        return true;
      } else {
        Log.info('User details are not available.');
        return false;
      }
    } catch (error, stacktrace) {
      Log.verbose('Failed to check user availability:', [error, stacktrace]);

      return false;
    }
  }

  Future<void> signOutCurrentUser() async {
    try {
      final GoogleSignInAccount? googleUser = GoogleSignIn().currentUser;
      googleUser?.clearAuthCache();
      FirebaseAuth.instance.signOut();
      LocalClient.clearAll();
      GoogleSignIn().disconnect();
      GoogleSignIn().signOut();
    } on FirebaseAuthException catch (e, stacktrace) {
      Log.verbose("Error in signing out user ", [e, stacktrace]);
    }
    Get.offAllNamed(AppRoutes.onBoarding);
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    RxBool userSignedIn = (await isUserSignedIn()).obs;
    if (!(userSignedIn.value)) {
      Log.warning("User not signed in");
      return {"error": "User not found"};
    } else {
      Log.info("User signed in");
      Rx<User?> attributes = (await getCurrentUser()).obs;
      final response = await get(
          Uri.parse('${ApiData.API}/users/${attributes.value?.email}'),
          headers: {'Authorization': ApiData.accessToken});
      Log.logPrettyJson(response,"User Details");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["message"] == "Unauthorized") {
          Log.warning("unauthorized");
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
        update();
        refresh();
        return data;
      } else {
        var data = jsonDecode(response.body);
        Log.error("Error data $data");
        return {"error": data};
      }
    }
  }

  static List<String> getRegisteredEvents() {
    List<String> events = [];
    if (userDetails['events'] != null) {
      for (var event in userDetails['events']) {
        events.add(event);
      }
    }
    return events;
  }

  Future<List<EventListModel>?> fetchEventData() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('${ApiData.API}/events/'));
      Log.logPrettyJson(response,"Event Data");
      if (response.statusCode == 200) {
        String data = utf8.decode(response.bodyBytes);

        final jsonResponse = json.decode(data);

        if (jsonResponse is List) {
          // Check if the decoded data is a list
          List<EventListModel> events = jsonResponse.map((item) {
            return EventListModel.fromMap(item);
          }).toList();
          return events;
        } else {
          Log.error("Error banners: ${response.body} ${response.statusCode}");
          throw Exception('Failed to load events');
        }
      }
    } catch (e, stackTrace) {
      Log.verbose('Error fetching events by category:', [e, stackTrace]);
      return null;
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  void checkRegistered(EventListModel e) {
    if (userDetails['events'] != null) {
      isEventRegistered.value = userDetails['events'].contains(e.id);
    }
  }

  Future<void> fetchAndLoadDetails() async {
    userDetails.value = await getUserDetails();
    update();
  }
}
