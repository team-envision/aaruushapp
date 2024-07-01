import 'dart:convert';

import 'package:aarush/Common/common_controller.dart';
import 'package:aarush/Data/api_data.dart';
import 'package:aarush/Model/Events/event_list_model.dart';
import 'package:aarush/Screens/Home/home_screen.dart';
import 'package:aarush/Utilities/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsController extends GetxController {
  var userDetails = {}.obs;
  var registerFieldData = {}.obs;
  var chnageInDropDown = "ALL".obs;
  var isLoading = false.obs;
  var isEventRegistered = false.obs;
  var eventData = EventListModel().obs;

  CommonController common = Get.find();
  final registerFormKey = GlobalKey<FormState>();

  Future<void> getUser() async {
    try {
      userDetails.value = await common.getUserDetails();
    } catch (e) {
      debugPrint('Error fetching user details: $e');
      setSnackBar('Error:', 'Failed to fetch user details',
          icon: const Icon(Icons.warning_amber_rounded, color: Colors.red));
    }
  }

  Future<void> registerEvent({required EventListModel e}) async {
    isLoading.value = true;

    try {
      final response = await post(
        Uri.parse('${ApiData.API}/events/${e.category}/${e.id}/register'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': ApiData.accessToken
        },
        body: json.encode({
          ...registerFieldData,
          'email': userDetails['email'],
          'events': userDetails['events'] ?? [],
          'event': e.toMap()
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userRes = await put(Uri.parse('${ApiData.API}/users'),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': ApiData.accessToken
            },
            body: json.encode(<String, dynamic>{
              ...registerFieldData,
              "aaruushId": userDetails['aaruushId'],
              "email": userDetails['email'],
              "events": [...userDetails['events'] ?? [], e.id],
            }));

        if (userRes.statusCode == 200 ||
            userRes.statusCode == 201 ||
            userRes.statusCode == 202) {
          setSnackBar('SUCCESS:', 'Event registered successfully',
              icon: const Icon(Icons.check_circle_outline_rounded,
                  color: Colors.green));
        } else {
          setSnackBar('ERROR:', json.decode(userRes.body)['message'],
              icon: const Icon(Icons.warning_amber_rounded, color: Colors.red));
        }
      } else {
        setSnackBar('ERROR:', json.decode(response.body)['message'],
            icon: const Icon(Icons.warning_amber_rounded, color: Colors.red));
      }
    } catch (e) {
      debugPrint('Error registering event: $e');
      setSnackBar('ERROR:', 'Something went wrong',
          icon: const Icon(Icons.warning_amber_rounded, color: Colors.red));
    }

    registerFieldData.clear();
    isLoading.value = false;
    Get.offAll(() => const HomeScreen());
  }

  void openMapWithLocation(String latitude, String longitude) async {
    final mapUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");

    if (await canLaunch(mapUrl.toString())) {
      await launch(mapUrl.toString(), forceSafariVC: false);
    } else {
      debugPrint("Cannot launch map url");
    }
  }

  void checkRegistered(EventListModel e) {
    if (userDetails['events'] != null) {
      isEventRegistered.value = userDetails['events'].contains(e.id);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
