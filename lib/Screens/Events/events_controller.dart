import 'dart:convert';

import 'package:aarush/Common/common_controller.dart';
import 'package:aarush/Data/api_data.dart';
import 'package:aarush/Model/Events/event_list_model.dart';
import 'package:aarush/Screens/Home/home_screen.dart';
import 'package:aarush/Utilities/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class EventsController extends GetxController {
  var userAttributes = <String, String>{}.obs;
  var userDetails = <String, dynamic>{}.obs;
  var registerFieldData = <String, dynamic>{};
  var isLoading = false.obs;
  var isEventRegistered = false.obs;
  var eventData=EventListModel().obs;

  CommonController common = Get.find();
  final registerFormKey = GlobalKey<FormState>();

  Future<void> loadAttributes() async {
    var data = await common.fetchCurrentUserAttributes();
    userAttributes.value = {
      "name": data['name'],
      "image": data['picture'],
      "email": data['email'],
    };
  }

  Future<void> getUser() async {
    userDetails.value = await common.getUserDetails();
  }

  @override
  void onInit() async {
    getUser().then((value) => checkRegistered(eventData.value));
    super.onInit();
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
      final response = await post(
          Uri.parse('${ApiData.API}/test/events/${e.category}/${e.id}/register'),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': ApiData.accessToken
          },
          body: json.encode({
            ...registerFieldData,
            'user': userDetails['email'],
            'events': userDetails['events'] ?? [],
            'event': e.toMap()
          }));
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
              "events": [...userDetails['events'] ?? [], e.id],
            }));
        debugPrint("USER UPDATED: ${userRes.body}  ${userRes.statusCode}");
        // debugPrint("USER DET: ${{
        //   ...registerFieldData,
        //   "events": [...userDetails['events'] ?? [], e.id],
        // }}");
        setSnackBar('SUCCESS:', json.decode(response.body)['message'],
            icon: const Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.green,
            ));
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
      setSnackBar('ERROR:', "Something went wrong",
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
      debugPrint(e.toString());
    }
    registerFieldData.clear();
    isLoading.value = false;
    Get.offAll(() => const HomeScreen());
  }

  void checkRegistered(EventListModel e) {
    userDetails['events']?.forEach((element) {
      debugPrint("ELEMENT: $element");
      if (element == e.id) {
        isEventRegistered.value = true;
      } else {
        isEventRegistered.value = false;
      }
    });
  }
}
