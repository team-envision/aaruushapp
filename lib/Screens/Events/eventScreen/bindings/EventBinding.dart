
import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/eventScreen/controllers/events_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/eventScreen/state/Events_State.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/controllers/home_controller.dart';
import 'package:get/get.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EventsController(
        state: Get.put(EventsState()),
        homeController: Get.find<HomeController>(), commonController: Get.find<CommonController>()));
  }
}
