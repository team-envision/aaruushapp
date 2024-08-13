
import 'dart:convert';

import 'package:aarush/Screens/Home/home_controller.dart';
import 'package:aarush/Utilities/AaruushBottomBar.dart';
import 'package:aarush/Utilities/capitalize.dart';
import 'package:aarush/Utilities/removeBracketsIfExist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  // final authController = Get.put(AuthController());
 @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
print("common.emailAddress.value");
print("common.userName.value");
print("common.phoneNumber.value");
print(googleUser!.email);
print(googleUser.displayName);
print(googleUser!.id);
    EmailTextEditingController.text = googleUser!.email;
    NameTextEditingController.text =  toRemoveTextInBracketsIfExists(googleUser.displayName!).toString();
    PhNoTextEditingController.text = common.phoneNumber.value;
    RegNoTextEditingController.text = common.RegNo.value;
    CollgeTextEditingController.text = common.college.value;



  }



  Future<void> updateProfile() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final userRes = await put(
      Uri.parse('${ApiData.API}/users'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': ApiData.accessToken
      },

      body: json.encode(<String, dynamic>{

        "email": googleUser!.email,
        "aaruushId": homeController.common.aaruushId.value,
        "name": NameTextEditingController.text.toString(),
        "phone": PhNoTextEditingController.text.toString(),
        "college_name" : CollgeTextEditingController.text.toString(),
        "Registration Number" : RegNoTextEditingController.text.toString()
      }),
    );

    if (userRes.statusCode == 200 || userRes.statusCode == 201 || userRes.statusCode == 202) {
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
      debugPrint("ERROR : ${userRes.reasonPhrase}");
      // Consider throwing an exception or logging the error here.
    }

    // Fetch and reload details after updating profile
    homeController.common.fetchAndLoadDetails();
  }



  Future<void> saveUserToFirestore({
    required String name,
    required String college,
    required String registerNumber,
    required String phoneNumber,
    required String email,
  }) async {
    print(FirebaseAuth.instance.currentUser!.getIdToken());
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcmToken = await messaging.getToken();

    // Reference to Firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Data to store
    Map<String, dynamic> userData = {
      'name': name,
      'college': college,
      'registerNumber': registerNumber,
      'phoneNumber': phoneNumber,
      'email': email,
      'fcmToken': fcmToken,
      'createdAt': FieldValue.serverTimestamp(),
      "Uid" : FirebaseAuth.instance.currentUser!.uid
    };

    // Store the data



     print(common.isUserAvailable(email).toString());
     Future<bool> isAvailable = common.isUserAvailable(email);
     if(!await isAvailable){
       kDebugMode ? print('User data saved successfully!'):null;
       try{
       await users.doc(email).set(userData);
       Get.offAll(()=>AaruushBottomBar());
     }
   catch(error){
     printError(info: error.toString());
   }

     }




  }
  @override
  void dispose() {
    // Dispose any resources here if necessary
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
    // Dispose any resources here if necessary
  }


}
