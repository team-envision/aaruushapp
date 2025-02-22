import 'dart:convert';
import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Common/core/Utils/Logger/app_logger.dart';
import 'package:AARUUSH_CONNECT/Data/api_data.dart';
import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:AARUUSH_CONNECT/Model/Events/gallery.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/state/Home_State.dart';
import 'package:AARUUSH_CONNECT/Services/notificationServices.dart';
import 'package:AARUUSH_CONNECT/Services/appRating.dart';
import 'package:AARUUSH_CONNECT/Utilities/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final CommonController commonController;
  final HomeState state;

  HomeController({required this.commonController, required this.state});

  @override
  Future<void> onInit() async {
    super.onInit();
    commonController.fetchAndLoadDetails();
    fetchEventData();
    NotificationServices notificationServices = NotificationServices();
    notificationServices.setupInteractMessage(Get.context!);
    notificationServices.firebaseInit(Get.context!);
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    notificationServices.getDeviceToken().then((newToken) async {
      Log.highlight('device token $newToken');

      try {
        User? user = await CommonController.getCurrentUser();

        DocumentReference userDoc =
            FirebaseFirestore.instance.collection('users').doc(user?.email);

        await userDoc.update({'fcmToken': newToken});

          Log.highlight('Token updated in Firestore');

      } on FirebaseException catch (e,stacktrace) {

          Log.verbose(
              "Firebase Exception occurred while updating new token:",[e,stacktrace]);

      } catch (e,stacktrace) {

          Log.verbose("Error occurred while updating new token: ",[e,stacktrace]);

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
    User? attributes = await CommonController.getCurrentUser();
    final response = await get(
        Uri.parse('https://api.aaruush.org/api/v1/users/${attributes?.email}'),
        headers: {'Authorization': ApiData.accessToken});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["message"] == "Unauthorized") {
        Log.warning("unauthorized");
        commonController.signOutCurrentUser();
      }

      var collection = FirebaseFirestore.instance.collection('users');
      collection
          .doc(attributes?.email)
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
          .then((_) => Log.highlight(
              'from HomeController: Success in updating info from aws to firebase'))
          .catchError((error,stacktrace) {
            if (kDebugMode) {
              Log.verbose(
                  'from HomeController: error in updating info from aws to firebase',[error,stacktrace]);
            }
          });
    } else {
        Log.verbose(
            'from HomeController: ${response.statusCode} error in updating info from aws to firebase',[response.reasonPhrase,]);
       
      
    }
  }

   Future<void> fetchEventData() async {
    state.isLoading.value = true;
    try {
      List<EventListModel>? jsonResponse;
      jsonResponse = await commonController.fetchEventData();
      if(jsonResponse == null){
        state.isLoading.value = false;
        setSnackBar("Message", "Data Not Found");
        return;
      }

        List<EventListModel> filteredLiveEvents =
            jsonResponse.where((event) => event.live == true).toList();
        state.eventList.assignAll(
            jsonResponse.map((e) => e).toList());
        state.eventList.sort((a, b) {
          if (a.timestamp == null) return 1; // nulls last
          if (b.timestamp == null) return -1;
          return b.timestamp!.compareTo(a.timestamp!); // Descending order
        });
        state.templiveEventList.assignAll(
            filteredLiveEvents.map((e) => e).toList());

        state.LiveEventsList.value =
            state.templiveEventList.map((e) => e.id).toList();

        update();

    } catch (e,stacktrace) {
      Log.verbose('Error fetching events data:' ,[e,stacktrace]);
    } finally {
      state.isLoading.value = false;
      state.regEvents.value = CommonController.getRegisteredEvents();
      refresh();
    }
  }

  Future<void> fetchGallery({required String year}) async {
    state.isLoading.value = true;
    try {
      final response = await http
          .get(Uri.parse('${ApiData.API}/gallery/edition/$year/proshow'));

      if (response.statusCode == 200) {
        String data = utf8.decode(response.bodyBytes);
        List jsonResponse = json.decode(data);

        state.tempGalleryList
            .assignAll(jsonResponse.map((e) => Gallery.fromJson(e)).toList());

        state.tempGalleryList.forEach((gallery) {
          if (gallery.image != null) {
            state.galleryList.addAll(gallery.image!);
          }
        });
      } else {
        Log.error(
            "Error gallery: ${response.body} ${response.statusCode}");
        throw Exception('Failed to load gallery');
      }
    } catch (e,stacktrace) {
      Log.verbose( 'Error fetching gallery:',[e,stacktrace]);
    } finally {
      state.isLoading.value = false;
    }
  }

  Future<void> fetchEventDataByCategory(String category) async {
    state.isLoading.value = true;
    try {

      List<dynamic>? jsonResponse;
      jsonResponse = await commonController.fetchEventData();
      if(jsonResponse == null){
        state.isLoading.value = false;
        setSnackBar("Message", "Data Not Found");
        return;
      }

        var filteredEvents = jsonResponse.where((event) {
          return event['sortCategory'] == category;
        }).toList();

        state.eventList.assignAll(
            filteredEvents.map((e) => EventListModel.fromMap(e)).toList());
        state.eventList.sort((a, b) {
          if (a.timestamp == null) return 1; // nulls last
          if (b.timestamp == null) return -1;
          return b.timestamp!.compareTo(a.timestamp!); // Descending order
        });
        update();

    } catch (e,stackTrace) {
      Log.verbose('Error fetching events by category:',[e,stackTrace]);
    } finally {
      state.isLoading.value = false;
    }
  }

  Future<void> getToURL({required String URL}) async {
    final mapUrl = Uri.parse(URL);

    if (await canLaunchUrl(mapUrl)) {
      await launchUrl(mapUrl);
    } else {
     setSnackBar("Error","Cannot launch map url");
      Log.error("Cannot launch map url");
    }
  }

  void setSortCategory(String name) {
    state.sortName.value = name;
    if (name == "All") {
      fetchEventData();
    } else {
      fetchEventDataByCategory(name);
    }
  }
}
