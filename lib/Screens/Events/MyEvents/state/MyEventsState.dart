import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyEventsState extends GetXState{
  RxList<EventListModel> registeredEvents = <EventListModel>[].obs;
  RxList<EventListModel>? eventList;
  final scrollController = ScrollController();
  RxBool isLoading = false.obs;
}