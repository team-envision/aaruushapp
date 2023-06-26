import 'dart:convert';

import 'package:aarush/Common/common_controller.dart';
import 'package:aarush/Data/api_data.dart';
import 'package:aarush/Model/Events/event_list_model.dart';
import 'package:aarush/Model/User/attributes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class HomeController extends GetxController {
  var eventList = <EventListModel>[].obs;
  var userAttributes = <String, String>{}.obs;
  CommonController common = Get.find();

  
  Future<List<EventListModel>> fetchEventData() async {
    final response = await get(Uri.parse('${ApiData.API}/events'));
    if (response.statusCode == 200) {
      String data = utf8.decode(response.bodyBytes);
      List jsonResponse = json.decode(data);
      eventList.assignAll(jsonResponse.map((e) => EventListModel.fromMap(e)));
      // debugPrint("EVENT :LENGHT: ${eventList.length}");
    } else {
      debugPrint("Error banners: ${response.body} ${response.statusCode}");
      throw Exception('Failed to load events');
    }
    return eventList;
  }

  Future<void> loadAttributes() async {
    var data = await common.fetchCurrentUserAttributes();
    userAttributes.value = {
      "name": data['name'],
      "image": data['picture'],
      "email": data['email'],
    };
    // debugPrint("USER :LENGHT: ${userAttributes.value}");
  }

  @override
  void onInit() async {
    super.onInit();
  }
}
