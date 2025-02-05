import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/views/myEvents.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/controllers/home_controller.dart';
import 'package:get/get.dart';

class MyEventsBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(MyEventsController(commonController: Get.find<CommonController>(), homeController: Get.find<HomeController>()));
  }

}