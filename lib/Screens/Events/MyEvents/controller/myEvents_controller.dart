import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Common/core/Utils/Logger/app_logger.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/MyEvents/state/MyEventsState.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyEventsController extends GetxController {

  final CommonController commonController;
  final HomeController homeController;
  final MyEventsState state;

  MyEventsController(
      {required this.commonController, required this.homeController,required this.state });



  @override
  Future<void> onInit() async {
    await fetchRegisteredEvents();
    super.onInit();
  }

  Future<void> fetchRegisteredEvents() async {
    try {
      state.isLoading.value = true;
      await homeController.fetchEventData();
      state.eventList ??= homeController.state.eventList;

      final List<String> eventIds = CommonController.getRegisteredEvents();
      Log.info(eventIds,["Registered event IDs"]);
      state.registeredEvents.clear();
      state.eventList?.forEach((element) {
        if (eventIds.contains(element.id)) {
          state.registeredEvents.add(element);
        }
      });
      state.registeredEvents.sort((a, b) {
        if (a.timestamp == null) return 1; // nulls last
        if (b.timestamp == null) return -1;
        return b.timestamp!.compareTo(a.timestamp!); // Descending order
      });
      state.isLoading.value = false;
    } catch (e) {
      state.isLoading.value = false;
      Log.error("Error fetching registered events: \$e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    state.scrollController.dispose();
  }
}
