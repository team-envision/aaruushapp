import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/Register/controllers/Register_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/Register/state/Register_State.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/controllers/home_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/state/Home_State.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController(
        homeController: Get.put(HomeController(
            commonController: Get.find<CommonController>(),
            state: HomeState())),
        state: Get.put(RegisterState())));
  }
}
