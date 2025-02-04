import 'dart:convert';
import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Common/core/Utils/Logger/app_logger.dart';
import 'package:AARUUSH_CONNECT/Data/api_data.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/state/Profile_State.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import '../../../Utilities/snackbar.dart';

class ProfileController extends GetxController {
  final CommonController commonController;
  final ProfileState state;

  ProfileController({
    required this.commonController,
    required this.state
  });

  void resetProfileData() {
    CommonController.college = ''.obs;
    CommonController.phoneNumber = ''.obs;
    CommonController.RegNo = ''.obs;
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
        "aaruushId": CommonController.aaruushId.value,
        "email": CommonController.emailAddress.value,
        "name": state.nameController.text,
        "phone": state.phoneController.text
      }),
    );

    if (userRes.statusCode == 200 ||
        userRes.statusCode == 201 ||
        userRes.statusCode == 202) {
      // Update Firebase
      var collection = FirebaseFirestore.instance.collection('users');
      collection
          .doc(CommonController.emailAddress.value)
          .set({
            "aaruushId": CommonController.aaruushId.value,
            "email": CommonController.emailAddress.value,
            'name': state.nameController.text,
            "phone": state.phoneController.text
          })
          .then((_) => Log.highlight('Success'))
          .catchError((error) => Log.verbose('Failed: $error'));

      setSnackBar(
        'SUCCESS:',
        "Profile Updated Successfully",
        icon: const Icon(
          Icons.check_circle_outline_rounded,
          color: Colors.green,
        ),
      );
    } else {
      Log.verbose("ERROR : ${userRes.body}");
      setSnackBar(
        'ERROR:',
        json.decode(userRes.body)['message'],
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
    }

    // Fetch and reload details after updating profile
    await commonController.fetchAndLoadDetails();

    // Pop the current screen after updating profile
    Get.back();
  }

  // Future<void> loginWithEmail(String email) async {
  //   // Check if the email exists in the database before proceeding
  //   final userRes = await get(
  //     Uri.parse('${ApiData.API}/users/$email'),
  //     headers: {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': ApiData.accessToken
  //     },
  //   );
  //
  //   if (userRes.statusCode == 404) {
  //     Log.error("ERROR: Unregistered Email Address");
  //     setSnackBar(
  //       'ERROR:',
  //       'Unregistered Email Address',
  //       icon: const Icon(
  //         Icons.warning_amber_rounded,
  //         color: Colors.red,
  //       ),
  //     );
  //     return;
  //   }
  //
  //   // If email exists, continue with normal login process
  //   final userData = json.decode(userRes.body);
  //   CommonController.emailAddress.value = userData['email'];
  //   CommonController.userName.value = userData['name'];
  //   CommonController.phoneNumber.value = userData['phone'];
  //   CommonController.aaruushId.value = userData['aaruushId'];
  // }

  @override
  void onReady() {
Future.delayed(Duration(milliseconds: 300),(){
  // Initialize text controllers with current user data if logged in
  state.phoneController.text = CommonController.phoneNumber.value;
  state.nameController.text = CommonController.userName.value;
  state.emailController.text = CommonController.emailAddress.value;
});
    super.onReady();
  }



  @override
  void dispose() {
    // Dispose text controllers when the controller is closed
    state.phoneController.dispose();
    state.nameController.dispose();
    state.emailController.dispose();
    super.dispose();
  }
}
