import 'package:AARUUSH_CONNECT/Screens/Events/controllers/events_controller.dart';
import 'package:get/get.dart';

class EventBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(EventsController());
  }

}