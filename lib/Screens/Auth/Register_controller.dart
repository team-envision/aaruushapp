import 'dart:convert';
import 'package:AARUUSH_CONNECT/Screens/Home/home_controller.dart';
import 'package:AARUUSH_CONNECT/Utilities/AaruushBottomBar.dart';
import 'package:AARUUSH_CONNECT/Utilities/removeBracketsIfExist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import '../../Common/common_controller.dart';
import '../../Data/api_data.dart';
import '../../Utilities/snackbar.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxDouble height = (Get.height * 0.55).obs;
  TextEditingController NameTextEditingController = TextEditingController();
  TextEditingController CollgeTextEditingController = TextEditingController();
  TextEditingController RegNoTextEditingController = TextEditingController();
  TextEditingController PhNoTextEditingController = TextEditingController();
  TextEditingController EmailTextEditingController = TextEditingController();
  final common = Get.put(CommonController());
  final homeController = Get.put(HomeController());
  String? googleUserEmail;


  @override
  Future<void> onInit()  async {
    // TODO: implement onInit
    super.onInit();
    Rx<User?> currentUser = (await common.getCurrentUser()).obs;
    print('hhhhhhh');
    print(currentUser.value?.email);
    print(currentUser.value?.displayName);
    googleUserEmail = currentUser.value?.email;
    EmailTextEditingController.text = currentUser.value?.email ?? "";
    NameTextEditingController.text =
        toRemoveTextInBracketsIfExists(currentUser.value?.displayName ?? "");
    PhNoTextEditingController.text = CommonController.phoneNumber.value;
    RegNoTextEditingController.text = CommonController.RegNo.value;
    CollgeTextEditingController.text = CommonController.college.value;
    update();
  }

  Future<void> updateProfile() async {
    final userRes = await put(
      Uri.parse('${ApiData.API}/users'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': ApiData.accessToken
      },
      body: json.encode(<String, dynamic>{
        "email": googleUserEmail,
        "aaruushId": CommonController.aaruushId.value,
        "name": NameTextEditingController.text.toString(),
        "phone": PhNoTextEditingController.text.toString(),
        "college_name": CollgeTextEditingController.text.toString(),
        "Registration Number": RegNoTextEditingController.text.toString()
      }),
    );

    if (userRes.statusCode == 200 ||
        userRes.statusCode == 201 ||
        userRes.statusCode == 202) {
      setSnackBar(
        'SUCCESS:',
        "Profile Updated Successfully",
        icon: const Icon(
          Icons.check_circle_outline_rounded,
          color: Colors.green,
        ),
      );
      Get.to(() => AaruushBottomBar());
    } else {
      setSnackBar(
        'ERROR:',
        json.decode(userRes.body)['message'],
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
      debugPrint("ERROR : ${userRes.body}");
      debugPrint("ERROR : ${userRes.reasonPhrase}");
    }

    await homeController.common.fetchAndLoadDetails();
  }

  Future<void> saveUserToFirestore() async {
    if (kDebugMode) {
      print(FirebaseAuth.instance.currentUser!.getIdToken());
    }
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcmToken = await messaging.getToken();

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    String name = NameTextEditingController.text;
    String college = CollgeTextEditingController.text;
    String registerNumber = RegNoTextEditingController.text;
    String phoneNumber = PhNoTextEditingController.text;
    String email = EmailTextEditingController.text;

    Map<String, dynamic> userData = {
      'name': name,
      'college': college,
      'registerNumber': registerNumber,
      'phoneNumber': phoneNumber,
      'email': email,
      'fcmToken': fcmToken,
      'createdAt': FieldValue.serverTimestamp(),
      "Uid": FirebaseAuth.instance.currentUser!.uid
    };

    Future<bool> isAvailable = common.isUserAvailableInFirebase(email);
    if (!await isAvailable) {
      kDebugMode ? print('User data saved successfully!') : null;
      try {
        await users.doc(email).set(userData);
        Get.offAll(() => AaruushBottomBar());
      } on FirebaseException catch (e) {
        kDebugMode ? print(e.message) : null;
        setSnackBar(e.code, e.message!);
      } catch (error) {
        printError(info: error.toString());
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    NameTextEditingController.dispose();
    CollgeTextEditingController.dispose();
    PhNoTextEditingController.dispose();
    EmailTextEditingController.dispose();
    RegNoTextEditingController.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
