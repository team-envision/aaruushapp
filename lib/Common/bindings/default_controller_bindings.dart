import "package:AARUUSH_CONNECT/Common/controllers/common_controller.dart";
import 'package:get/get.dart';

class DefaultController extends Bindings {
  @override
  void dependencies() {
    Get.put(CommonController());

  }
}
