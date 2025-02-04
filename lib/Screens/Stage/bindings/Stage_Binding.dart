
import 'package:AARUUSH_CONNECT/Screens/Stage/controllers/Stage_Controller.dart';

import 'package:get/get.dart';

class StageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      StageController(),
    );
  }
}
