import 'dart:convert';
import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Common/core/Routes/app_routes.dart';
import 'package:AARUUSH_CONNECT/Data/api_data.dart';
import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:AARUUSH_CONNECT/Utilities/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class EventsController extends GetxController {
  var userDetails = {}.obs;
  var registerFieldData = {}.obs;
  var chnageInDropDown = "ALL".obs;
  var isLoading = false.obs;
  var isEventRegistered = false.obs;
  var eventData = EventListModel().obs;
  RxList locations = [].obs;

  CommonController commonController = Get.find<CommonController>();
  final registerFormKey = GlobalKey<FormState>();
  
  @override
  Future<void> onInit() async {
    super.onInit();
    getUser();
  }




  Future<void> getUser() async {
    try {
      userDetails.value = await commonController.getUserDetails() ?? {};
    } catch (e) {
      debugPrint('Error fetching user details: $e');
      setSnackBar(
        'Error:',
        'Failed to fetch user details',
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.red),
      );
    }
    print("userDetails.values");
    print(userDetails.keys.toList());
    userDetails.keys.map((val) {
      print(val);
    });
    print('userDetails.value.containsKey("Name")');
    print(userDetails.value.containsKey("College (NA if not applicable)"));
  }

  Future<void> registerEvent({required EventListModel e}) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('${ApiData.API}/events/${e.category}/${e.id}/register'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': ApiData.accessToken,
        },
        body: json.encode({
          ...?registerFieldData.value,
          "aaruushId": userDetails["aaruushId"] ?? '',
          'email': userDetails['email'] ?? '',
          'events': userDetails['events'] ?? [],
          'event': e.toMap(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userRes = await http.put(
          Uri.parse('${ApiData.API}/users'),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': ApiData.accessToken,
          },
          body: json.encode({
            ...?registerFieldData.value,
            "aaruushId": userDetails['aaruushId'] ?? '',
            "email": userDetails['email'] ?? '',
            "events": [...?userDetails['events'] ?? [], e.id],
          }),
        );

        if (userRes.statusCode == 200 ||
            userRes.statusCode == 201 ||
            userRes.statusCode == 202) {
          setSnackBar(
            'SUCCESS:',
            'Event registered successfully',
            icon: const Icon(Icons.check_circle_outline_rounded,
                color: Colors.green),
          );
        } else {
          setSnackBar(
            'ERROR:',
            json.decode(userRes.body)['message'] ?? 'Unknown error',
            icon: const Icon(Icons.warning_amber_rounded, color: Colors.red),
          );
        }
      } else {
        setSnackBar(
          'ERROR:',
          json.decode(response.body)['message'] ?? 'Unknown error',
          icon: const Icon(Icons.warning_amber_rounded, color: Colors.red),
        );
      }
    } catch (e) {
      debugPrint('Error registering event: $e');
      setSnackBar(
        'ERROR:',
        'Something went wrong',
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.red),
      );
    } finally {
      registerFieldData.clear();
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.stage);
    }
  }

  void openMapWithLocation(String latitude, String longitude) async {
    final mapUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");

    if (await canLaunchUrl(mapUrl)) {
      await launchUrl(mapUrl);
    } else {
      debugPrint("Cannot launch map url");
    }
  }

  void checkRegistered(EventListModel e) {
    isEventRegistered.value = userDetails['events']?.contains(e.id) ?? false;
  }

  Future<void> fetchEventData(String eventId) async {
    isLoading.value = true;

    try {
      final response = await http.get(Uri.parse('${ApiData.API}/events'));
      if (response.statusCode == 200) {
        String data = utf8.decode(response.bodyBytes);
        List jsonResponse = json.decode(data);
        List<dynamic> filteredLiveEvents =
            jsonResponse.where((event) => event['id'] == eventId).toList();
        eventData.value =
            filteredLiveEvents.map((e) => EventListModel.fromMap(e)).first;
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

  @override
  void dispose() {
    super.dispose();
  }
}
