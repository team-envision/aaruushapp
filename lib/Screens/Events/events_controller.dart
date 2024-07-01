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
  var userDetails = <String, dynamic>{}.obs;
  var registerFieldData = <String, dynamic>{}.obs;
  var chnageInDropDown = "ALL".obs;
  var isLoading = false.obs;
  var isEventRegistered = false.obs;
  var eventData = EventListModel().obs;

  CommonController common = Get.find();
  final registerFormKey = GlobalKey<FormState>();

  Future<void> getUser() async {
    userDetails.value = await common.getUserDetails();
  }

  Future<void> registerEvent({required EventListModel e}) async {
    isLoading.value = true;
    // debugPrint("%%%%%%%%%%%%%%%%%%%%% ${{
    //   ...registerFieldData,
    //   'user': userDetails['email'],
    //   'events': userDetails['events'] ?? [],
    //   'event': e.toJson()
    // }} %%%%%%%%%%%%%%%%%%%%");
    try {
      // debugPrint("Token: ${ApiData.accessToken}");
      // debugPrint("Email: ${userDetails['email']}");
      // debugPrint("Events: ${userDetails['events']}");
      // debugPrint("Events: ${userDetails['aaruushId']}");
      debugPrint("Entered and ${e.id} ${e.category}");
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
          }));
      debugPrint("response created ${response.body} ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("EVENT REGISTERED");
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
          debugPrint("USER UPDATED: ${userRes.body}  ${userRes.statusCode}");
          setSnackBar('SUCCESS:', "Event registered successfully",
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
      } else {
        setSnackBar('ERROR:', json.decode(response.body)['message'],
            icon: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
            ));
        debugPrint("ERROR : " + response.body);
        // throw Exception('Failed to register event ${response.body}');
      }
    } catch (e) {
      debugPrint(e.toString());
      setSnackBar('ERROR:', "Something went wrong",
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    }
    registerFieldData.clear();
    isLoading.value = false;
    Get.offAll(() => const HomeScreen());
  }

  void openMapWithLocation(String latitude, String longitude) async {
    final mapUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");

    if (await canLaunchUrl(mapUrl)) {
      await launchUrl(mapUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Cannot launch map url");
    }
  }

  void checkRegistered(EventListModel e) {
    // Compare the userDetails["events"] array and if id matches make isEventRegistered true
    if (userDetails['events'] != null) {
      for (var event in userDetails['events']) {
        if (event == e.id) {
          isEventRegistered.value = true;
          break;
        }
      }
    }
  }
}
