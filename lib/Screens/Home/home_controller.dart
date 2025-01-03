import 'dart:convert';
import 'package:AARUUSH_CONNECT/Common/common_controller.dart';
import 'package:AARUUSH_CONNECT/Data/api_data.dart';
import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:AARUUSH_CONNECT/Model/Events/gallery.dart';
import 'package:AARUUSH_CONNECT/Services/notificationServices.dart';
import 'package:AARUUSH_CONNECT/Services/appRating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  var eventList = <EventListModel>[].obs;
  var templiveEventList = <EventListModel>[].obs;

  var galleryList = [].obs;
  var tempGalleryList = [].obs;

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

  @override
  Future<void> onInit() async {
    super.onInit();
    print("GetStorage().read('accessToken')");
    print(GetStorage().read('accessToken'));
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

        DocumentReference userDoc =
            FirebaseFirestore.instance.collection('users').doc(email);

          await userDoc.update({'fcmToken': newToken});
          if (kDebugMode) {
            print('Token updated in Firestore');
          }

      } on FirebaseException catch (e) {
        if (kDebugMode) {
          print(
              "Firebase Exception occurred while updating new token: ${e.message}");
        }
      } catch (e) {
        if (kDebugMode) {
          printError(info: "Error occurred while updating new token: $e");
        }
      }
    });
    updateProfile();
    fetchGallery(year: "2023");
  }

  @override
  onReady() {
    final AppRating = appRating();
    AppRating.rateApp(Get.context!);
  }

  onDispose() {
    super.dispose();
  }

  Future<void> updateProfile() async {
    final attributes = common.getCurrentUser();
    final response = await get(
        Uri.parse('https://api.aaruush.org/api/v1/users/${attributes.email}'),
        headers: {'Authorization': ApiData.accessToken});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["message"] == "Unauthorized") {
        debugPrint("unauthorized");
        common.signOutCurrentUser();
      }

      var collection = FirebaseFirestore.instance.collection('users');
      collection
          .doc(attributes.email)
          .update({
            "aaruushId": data['aaruushId'] ?? "",
            "email": data['email'] ?? "",
            "name": data['name'] ?? "",
            "college": data['college'] ??
                data['college (na if not applicable)'] ??
                data['college_name'] ??
                "",
            "registerNumber":
                data['registration number (na if not applicable)'] ??
                    data['college_id'] ??
                    data['Registration Number'] ??
                    "",
            "phone": data['phone'] ??
                data["whatsapp"] ??
                data["phone number"] ??
                data["Whatsapp Number"] ??
                data["whatsappnumber"] ??
                data["whatsapp number"] ??
                ""
          })
          .then((_) => debugPrint(
              'from HomeController: Success in updating info from aws to firebase'))
          .catchError((error) {
            if (kDebugMode) {
              print(
                  'from HomeController: error in updating info from aws to firebase');
              print('Failed: $error');
            }
          });
    } else {
      if (kDebugMode) {
        print(
            'from HomeController: error in updating info from aws to firebase');
        print("ERROR : ${response.body}");
      }
    }
  }

  Future<void> fetchEventData() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('${ApiData.API}/events'));
      if (response.statusCode == 200) {
        String data = utf8.decode(response.bodyBytes);
        List jsonResponse = json.decode(data);
        List<dynamic> filteredLiveEvents =
            jsonResponse.where((event) => event['live'] == true).toList();
        eventList.assignAll(
            jsonResponse.map((e) => EventListModel.fromMap(e)).toList());
        templiveEventList.assignAll(
            filteredLiveEvents.map((e) => EventListModel.fromMap(e)).toList());

        LiveEventsList.value = templiveEventList.map((e) => e.id).toList();
      } else {
        debugPrint("Error banners: ${response.body} ${response.statusCode}");
        throw Exception('Failed to load events');
      }
    } catch (e) {
      printError(info: 'Error fetching events data: $e');
    } finally {
      isLoading.value = false;
      regEvents.value = common.registeredEvents();
    }
  }

  Future<void> fetchGallery({required String year}) async {
    isLoading.value = true;
    try {
      final response = await http
          .get(Uri.parse('${ApiData.API}/gallery/edition/$year/proshow'));

      if (response.statusCode == 200) {
        String data = utf8.decode(response.bodyBytes);
        List jsonResponse = json.decode(data);

        tempGalleryList
            .assignAll(jsonResponse.map((e) => Gallery.fromJson(e)).toList());

        tempGalleryList.forEach((gallery) {
          if (gallery.image != null) {
            galleryList.addAll(gallery.image!);
          }
        });
      } else {
        printError(
            info: "Error gallery: ${response.body} ${response.statusCode}");
        throw Exception('Failed to load gallery');
      }
    } catch (e) {
      printError(info: 'Error fetching gallery: $e');
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
          return event['sortCategory'] == category;
        }).toList();

        eventList.assignAll(
            filteredEvents.map((e) => EventListModel.fromMap(e)).toList());
      } else {
        debugPrint("Error banners: ${response.body} ${response.statusCode}");
        throw Exception('Failed to load events');
      }
    } catch (e) {
      printError(info: 'Error fetching events by category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getToURL({required String URL}) async {
    final mapUrl = Uri.parse(URL);

    if (await canLaunchUrl(mapUrl)) {
      await launchUrl(mapUrl);
    } else {
      debugPrint("Cannot launch map url");
    }
  }

  void setSortCategory(String name) {
    sortName.value = name;    if (name == "All") {
      fetchEventData();
    } else {
      fetchEventDataByCategory(name);
    }
  }
}
