import 'dart:convert';

import 'package:aarush/Common/common_controller.dart';
import 'package:aarush/Data/api_data.dart';
import 'package:aarush/Model/Events/event_list_model.dart';
import 'package:aarush/Model/User/attributes.dart';
import 'package:aarush/Services/notificationServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class HomeController extends GetxController {
  var eventList = <EventListModel>[].obs;
  CommonController common = Get.find();
  var isLoading = false.obs;

  var sortName = "All".obs;

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

  Future<List<EventListModel>> fetchEventDataByCategory(
      {required String category}) async {
    final response = await get(Uri.parse('${ApiData.API}/events/$category'));
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

  void setSortCategory(String name) {
    sortName.value = name;
  }

  @override
  void onInit() async {
    await common.fetchAndLoadDetails();
    final notificationServices = NotificationServices();
    notificationServices.requestNotificationPermission();
    super.onInit();
  }
}
