import 'dart:convert';

import 'package:aarush/Data/api_data.dart';
import 'package:aarush/Screens/Home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Utilities/snackbar.dart';

class ProfileController extends GetxController {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  HomeController homeController = Get.find();
  final formkey = GlobalKey<FormState>();

  Future<void> updateProfile() async {
    final userRes = await put(Uri.parse('${ApiData.API}/users'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': ApiData.accessToken
        },
        body: json.encode(<String, dynamic>{
          "aaruushId": homeController.common.aaruushId.value,
          "email": homeController.common.emailAddress.value,
          "name": nameController.text,
          "phone": phoneController.text
        }));

    if (userRes.statusCode == 200 ||
        userRes.statusCode == 201 ||
        userRes.statusCode == 202) {
      setSnackBar('SUCCESS:', "Profile Updated Successfully",
          icon: const Icon(
            Icons.check_circle_outline_rounded,
            color: Colors.green,
          ));
    } else {
      setSnackBar('ERROR:', json.decode(userRes.body)['message'],
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
      debugPrint("ERROR : ${userRes.body}");
      // throw Exception('Failed to register event ${response.body}');
    }
    homeController.common.fetchAndLoadDetails();
    Navigator.pop(Get.context!);
  }

  @override
  void onInit() {
    phoneController.text = homeController.common.phoneNumber.value;
    nameController.text = homeController.common.userName.value;
    emailController.text = homeController.common.emailAddress.value;
    super.onInit();
  }

  @override
  void onClose() {
    phoneController.dispose();
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
