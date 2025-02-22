import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchState extends GetXState{
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController1 = ScrollController();
  final ScrollController scrollController2 = ScrollController();
  RxList<EventListModel> searchResults = <EventListModel>[].obs;
  RxList<EventListModel> eventList = <EventListModel>[].obs;
  RxString query = ''.obs;

}