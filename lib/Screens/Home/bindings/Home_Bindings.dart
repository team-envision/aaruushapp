import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/controllers/home_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/state/Home_State.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(
        commonController: Get.find<CommonController>(),
        state: Get.put(HomeState())));
  }
}
