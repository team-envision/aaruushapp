// import 'dart:convert';
// import 'package:AARUUSH_CONNECT/Data/api_data.dart';
// import 'package:AARUUSH_CONNECT/Screens/Home/home_controller.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:get/get.dart';
//
// import '../../Utilities/snackbar.dart';
//
// class ProfileController extends GetxController {
//   final phoneController = TextEditingController();
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   HomeController homeController = Get.find();
//   final formkey = GlobalKey<FormState>();
//
//   Future<void> updateProfile() async {
//     final userRes = await put(
//       Uri.parse('${ApiData.API}/users'),
//       headers: {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': ApiData.accessToken
//       },
//       body: json.encode(<String, dynamic>{
//         "aaruushId": homeController.common.aaruushId.value,
//         "email": homeController.common.emailAddress.value,
//         "name": nameController.text,
//         "phone": phoneController.text
//       }),
//     );
//
//     if (userRes.statusCode == 200 || userRes.statusCode == 201 || userRes.statusCode == 202) {
//       //update in firebase also
//       var collection = FirebaseFirestore.instance.collection('users');
//       collection
//           .doc(homeController.common.emailAddress.value)
//           .set({
//         "aaruushId": homeController.common.aaruushId.value,
//         "email": homeController.common.emailAddress.value,
//         'name' : 'nameController.text',
//         "phone": phoneController.text
//           })
//           .then((_) => print('Success'))
//           .catchError((error) => print('Failed: $error'));
//
//       setSnackBar(
//         'SUCCESS:',
//         "Profile Updated Successfully",
//         icon: const Icon(
//           Icons.check_circle_outline_rounded,
//           color: Colors.green,
//         ),
//       );
//     } else {
//       setSnackBar(
//         'ERROR:',
//         json.decode(userRes.body)['message'],
//         icon: const Icon(
//           Icons.warning_amber_rounded,
//           color: Colors.red,
//         ),
//       );
//       debugPrint("ERROR : ${userRes.body}");
//       // Consider throwing an exception or logging the error here.
//     }
//
//     // Fetch and reload details after updating profile
//     homeController.common.fetchAndLoadDetails();
//
//     // Pop the current screen after updating profile
//     Navigator.pop(Get.context!);
//   }
//
//   @override
//   void onInit() {
//     // Initialize text controllers with current user data
//     phoneController.text = homeController.common.phoneNumber.value;
//     nameController.text = homeController.common.userName.value;
//     emailController.text = homeController.common.emailAddress.value;
//     super.onInit();
//   }
//
//   @override
//   void onClose() {
//     // Dispose text controllers when the controller is closed
//     phoneController.dispose();
//     nameController.dispose();
//     emailController.dispose();
//     super.onClose();
//   }
//
//   @override
//   void dispose() {
//     // Implement if additional disposal is needed
//     super.dispose();
//   }
// }

import 'dart:convert';
import 'package:AARUUSH_CONNECT/Common/common_controller.dart';
import 'package:AARUUSH_CONNECT/Data/api_data.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import '../../Utilities/snackbar.dart';
import '../Auth/Register_controller.dart';

class ProfileController extends GetxController {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  HomeController homeController = Get.put(HomeController());
  final common = Get.find<CommonController>();
  final formkey = GlobalKey<FormState>();

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
        "name": nameController.text,
        "phone": phoneController.text
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
            'name': nameController.text,
            "phone": phoneController.text
          })
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));

      setSnackBar(
        'SUCCESS:',
        "Profile Updated Successfully",
        icon: const Icon(
          Icons.check_circle_outline_rounded,
          color: Colors.green,
        ),
      );
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
    }

    // Fetch and reload details after updating profile
    homeController.common.fetchAndLoadDetails();

    // Pop the current screen after updating profile
    Navigator.pop(Get.context!);
  }

  Future<void> loginWithEmail(String email) async {
    // Check if the email exists in the database before proceeding
    final userRes = await get(
      Uri.parse('${ApiData.API}/users/$email'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': ApiData.accessToken
      },
    );

    if (userRes.statusCode == 404) {
      setSnackBar(
        'ERROR:',
        'Unregistered Email Address',
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
      return;
    }

    // If email exists, continue with normal login process
    final userData = json.decode(userRes.body);
    CommonController.emailAddress.value = userData['email'];
    CommonController.userName.value = userData['name'];
    CommonController.phoneNumber.value = userData['phone'];
    CommonController.aaruushId.value = userData['aaruushId'];
  }


  @override
  Future<void> onReady() async {
    // TODO: implement onReady
    // Initialize text controllers with current user data if logged in
    super.onReady();
    await common.fetchAndLoadDetails();
    phoneController.text = CommonController.phoneNumber.value;
    nameController.text = CommonController.userName.value;
    emailController.text = CommonController.emailAddress.value;
    update();
  }


  @override
  void dispose() {
    // Dispose text controllers when the controller is closed
    phoneController.dispose();
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
