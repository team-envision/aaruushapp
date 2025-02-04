import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchState extends GetXState{
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController1 = ScrollController();
  final ScrollController scrollController2 = ScrollController();
  RxList searchResults = [].obs;
  RxList eventList = [].obs;

}