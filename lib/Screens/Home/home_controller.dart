import 'dart:convert';
import 'package:AARUUSH_CONNECT/Common/common_controller.dart';
import 'package:AARUUSH_CONNECT/Data/api_data.dart';
import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:AARUUSH_CONNECT/Services/notificationServices.dart';
import 'package:AARUUSH_CONNECT/Utilities/appRating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;





class HomeController extends GetxController{
  var eventList = <EventListModel>[].obs;
  var templiveEventList = <EventListModel>[].obs;
  RxList LiveEventsList = [].obs;
  RxList regEvents = [].obs;
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
    "events",
  ];

  AppLifecycleState appLifecycleState = AppLifecycleState.detached;

  @override
  Future<void> onInit() async {
    super.onInit();
    common.isEventRegistered;
    common.fetchAndLoadDetails();
    fetchEventData();
    NotificationServices notificationServices = NotificationServices();
    notificationServices.setupInteractMessage(Get.context!);
    notificationServices.firebaseInit(Get.context!);
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();

    notificationServices.getDeviceToken().then((newToken) async {
      if (kDebugMode) {
        print('device token');
        print(newToken);
      }
      try {

        String? email = common.getCurrentUser().email;

        DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(email);

        DocumentSnapshot userSnapshot = await userDoc.get();
        String? currentToken = userSnapshot.get("fcmToken");
        if (kDebugMode) {
          print("saved token ${currentToken!}");
        }

        if (currentToken != newToken) {
          await userDoc.update({'fcmToken': newToken});
          if (kDebugMode) {
            print('Token updated in Firestore');
          }
        } else {
          if (kDebugMode) {
            print('Token is the same. No update required.');
          }
        }
      } on FirebaseException catch (e) {
        if (kDebugMode) {
          print("Firebase Exception occurred while updating new token: ${e.message}");
        }
      } catch (e) {
        if (kDebugMode) {
          print("Error occurred while updating new token: $e");
        }
      }
    });



  }



  @override
  onReady(){
    final AppRating = appRating();
    AppRating.rateApp(Get.context!);

  }
  onDispose(){
  super.dispose();
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

         LiveEventsList.value = templiveEventList.map((e) => e.id).toList();

      } else {
        debugPrint("Error banners: ${response.body} ${response.statusCode}");
        throw Exception('Failed to load events');
      }
    } catch (e) {
      debugPrint('Error fetching events: $e');
    } finally {
      isLoading.value = false;
      regEvents.value = common.registeredEvents();
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

