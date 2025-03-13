import 'dart:convert';
import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Common/core/Routes/app_routes.dart';
import 'package:AARUUSH_CONNECT/Common/core/Utils/Logger/app_logger.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/Register/state/Register_State.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/controllers/home_controller.dart';
import 'package:AARUUSH_CONNECT/Utilities/removeBracketsIfExist.dart';
import 'package:AARUUSH_CONNECT/Utilities/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../../Data/api_data.dart';


class RegisterController extends GetxController {

  final HomeController homeController;
  final RegisterState state;

  RegisterController({
    required this.homeController,
    required this.state,

});

  @override
  Future<void> onInit()  async {
    // TODO: implement onInit
    super.onInit();
    Rx<User?> currentUser = (await CommonController.getCurrentUser()).obs;
    state.googleUserEmail = currentUser.value?.email;
    state.EmailTextEditingController.text = currentUser.value?.email ?? "";
    state.NameTextEditingController.text =
        toRemoveTextInBracketsIfExists(currentUser.value?.displayName ?? "");
    state.PhNoTextEditingController.text = CommonController.phoneNumber.value;
    state.RegNoTextEditingController.text = CommonController.RegNo.value;
    state.CollgeTextEditingController.text = CommonController.college.value;
    update();
  }


  // TODO: homecontroller remove krna hai registercontroller se
  Future<void> updateProfile() async {
    final userRes = await put(
      Uri.parse('${ApiData.API}/users'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': ApiData.accessToken
      },
      body: json.encode(<String, dynamic>{
        "email": state.googleUserEmail,
        "aaruushId": CommonController.aaruushId.value,
        "name": state.NameTextEditingController.text.toString(),
        "phone": state.PhNoTextEditingController.text.toString(),
        "college_name": state.CollgeTextEditingController.text.toString(),
        "Registration Number": state.RegNoTextEditingController.text.toString()
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
      await homeController.commonController.fetchAndLoadDetails();
    } else {
      setSnackBar(
        'ERROR:',
        json.decode(userRes.body)['message'],
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
      Log.error("ERROR : ${userRes.body}");
      Log.error("ERROR : ${userRes.reasonPhrase}");
    }


  }

  Future<void> saveUserToFirestore() async {

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcmToken = await messaging.getToken();

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    String name = state.NameTextEditingController.text;
    String college = state.CollgeTextEditingController.text;
    String registerNumber = state.RegNoTextEditingController.text;
    String phoneNumber = state.PhNoTextEditingController.text;
    String email = state.EmailTextEditingController.text;

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


      try {
        await users.doc(email).set(userData);
        Get.offAllNamed(AppRoutes.stage);
      } on FirebaseException catch (e) {
        Log.verbose(e.message,[e,e.stackTrace]);
        setSnackBar(e.code, e.message!);
      } catch (stackTrace,error) {
        Log.verbose(error,[error,stackTrace]);
        setSnackBar("Oops!", "Something Went Wrong");
      }

  }

  @override
  void dispose() {
    super.dispose();
    state.NameTextEditingController.dispose();
    state.CollgeTextEditingController.dispose();
    state.PhNoTextEditingController.dispose();
    state.EmailTextEditingController.dispose();
    state.RegNoTextEditingController.dispose();
  }
}
