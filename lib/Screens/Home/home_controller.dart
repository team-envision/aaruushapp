import 'dart:convert';

import 'package:aarush/Common/common_controller.dart';
import 'package:aarush/Model/Events/event_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class HomeController extends GetxController {
  var eventList = <EventListModel>[].obs;
  CommonController common = Get.find();
  Future<List<EventListModel>> fetchEventData() async {
    final response =
        await get(Uri.parse('https://api.aaruush.org/api/v1/events'));
    if (response.statusCode == 200) {
      String data = utf8.decode(response.bodyBytes);
      List jsonResponse = json.decode(data);
      eventList.assignAll(jsonResponse.map((e) => EventListModel.fromMap(e)));
      debugPrint("EVENT :LENGHT: ${eventList.length}");
    } else {
      throw Exception('Failed to load events');
    }
    return eventList;
  }
}
