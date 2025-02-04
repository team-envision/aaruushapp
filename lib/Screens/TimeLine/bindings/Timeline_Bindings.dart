import 'package:AARUUSH_CONNECT/Screens/TimeLine/controllers/timeline_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/TimeLine/state/Timeline_State.dart';
import 'package:get/get.dart';

class TimelineBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(TimelineController(state: Get.put(TimelineState())));
  }

}