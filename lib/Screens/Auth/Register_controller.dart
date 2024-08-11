
import 'package:aarush/Utilities/AaruushBottomBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Common/common_controller.dart';


class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxDouble height = (Get.height * 0.55).obs;
  TextEditingController NameTextEditingController = TextEditingController();
  TextEditingController CollgeTextEditingController = TextEditingController();
  TextEditingController RegNoTextEditingController = TextEditingController();
  TextEditingController PhNoTextEditingController = TextEditingController();
  TextEditingController EmailTextEditingController = TextEditingController();
  final common = Get.put(CommonController());
 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    EmailTextEditingController.text = common.emailAddress.value;
    NameTextEditingController.text =  common.userName.value;
    PhNoTextEditingController.text = common.phoneNumber.value;
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
