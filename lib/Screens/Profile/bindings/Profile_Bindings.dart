import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/controllers/profileController.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/state/Profile_State.dart';
import 'package:get/get.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController(
        commonController: Get.find<CommonController>(),
        state: Get.put(ProfileState())));
  }
}
