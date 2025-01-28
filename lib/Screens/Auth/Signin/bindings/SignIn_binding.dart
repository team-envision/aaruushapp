import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/Signin/controllers/signin_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/Signin/state/SignIn_state.dart';
import 'package:get/get.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController(
        commonController: Get.find<CommonController>(),
        state: Get.put(SignInState())));
  }
}
