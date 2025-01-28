import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Certificates/controllers/CertificateController.dart';
import 'package:AARUUSH_CONNECT/Screens/Certificates/state/Certificate_State.dart';
import 'package:get/get.dart';

class CertificateBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CertificateController(
        commonController: Get.find<CommonController>(),
        state: Get.put(CertificateState())));
  }
}
