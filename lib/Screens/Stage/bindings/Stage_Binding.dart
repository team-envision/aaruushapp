
import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/MyEvents/controller/myEvents_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/MyEvents/state/MyEventsState.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/MyEvents/view/myEvents.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/controllers/home_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/state/Home_State.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/controllers/profileController.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/state/Profile_State.dart';
import 'package:AARUUSH_CONNECT/Screens/Stage/controllers/Stage_Controller.dart';
import 'package:AARUUSH_CONNECT/Screens/TimeLine/controllers/timeline_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/TimeLine/state/Timeline_State.dart';

import 'package:get/get.dart';

class StageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(
      state: Get.put(HomeState()),
      commonController: Get.find<CommonController>(),
    ));

    Get.lazyPut(()=>TimelineController(
      state: Get.put(TimelineState()),
    ));

    Get.lazyPut(()=>ProfileController(
        commonController: Get.find<CommonController>(),
        state: Get.put(ProfileState())
    ));
    Get.lazyPut(()=>MyEventsController(
        commonController: Get.find<CommonController>(), homeController: Get.find<HomeController>(), state: Get.put(MyEventsState()),
      
    ));

    Get.put(
      StageController(),
    );
  }
}
