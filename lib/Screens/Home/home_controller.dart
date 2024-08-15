import 'dart:convert';
import 'package:aarush/Common/common_controller.dart';
import 'package:aarush/Data/api_data.dart';
import 'package:aarush/Model/Events/event_list_model.dart';
import 'package:aarush/Services/notificationServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;


class HomeController extends GetxController {
  var eventList = <EventListModel>[].obs;
  var templiveEventList = <EventListModel>[].obs;
  RxList LiveEventsList = [].obs;
  final common = Get.find<CommonController>();
  var isLoading = false.obs;
  var sortName = "All".obs;
  RxString userName = "".obs;
  final List<String> catList = [
    "workshops",
    "hackathons",
    "initiatives",
    "panel-discussions",
    "domain-events",
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    NotificationServices notificationServices = NotificationServices();
    // common = Get.find<CommonController>();
    common.fetchAndLoadDetails();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().currentUser;
    fetchEventData();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(Get.context!);
    notificationServices.setupInteractMessage(Get.context!);

    notificationServices.getDeviceToken().then((value){
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      if (kDebugMode) {
        print('device token updated');
        print(newToken);
      }
      try{
        FirebaseFirestore.instance
            .collection('users')
            .doc(common.emailAddress.value)
            .update({'fcmToken': newToken});
      } on FirebaseException catch(e){
        print("Firebase Exception occured while updating new token: ${e.message}");
      }
      catch(e){
        print("Error occured while updating new token: ${e}");
      }
    });


  }

  Future<void> fetchEventData() async {
    isLoading.value = true;

    try {
      final response = await http.get(Uri.parse('${ApiData.API}/events'));
      if (response.statusCode == 200) {
        String data = utf8.decode(response.bodyBytes);
        List jsonResponse = json.decode(data);
        List<dynamic> filteredLiveEvents = jsonResponse.where((event) => event['live'] == true).toList();
        eventList.assignAll(jsonResponse.map((e) => EventListModel.fromMap(e)).toList());
        templiveEventList.assignAll(filteredLiveEvents.map((e) => EventListModel.fromMap(e)).toList());

         LiveEventsList.value = templiveEventList.map((e) => e.name).toList();

      } else {
        debugPrint("Error banners: ${response.body} ${response.statusCode}");
        throw Exception('Failed to load events');
      }
    } catch (e) {
      debugPrint('Error fetching events: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchEventDataByCategory(String category) async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('${ApiData.API}/events/'));

      if (response.statusCode == 200) {
        String data = utf8.decode(response.bodyBytes);
        List<dynamic> jsonResponse = json.decode(data);

        var filteredEvents = jsonResponse.where((event) {
          return event['sortCategory'] == category ;
        }).toList();


        eventList.assignAll(filteredEvents.map((e) => EventListModel.fromMap(e)).toList());




      } else {
        debugPrint("Error banners: ${response.body} ${response.statusCode}");
        throw Exception('Failed to load events');
      }
    } catch (e) {
      debugPrint('Error fetching events by category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setSortCategory(String name) {
    sortName.value = name;
    if (name == "All") {
      fetchEventData();
    } else {
      fetchEventDataByCategory(name);
    }
  }

}
