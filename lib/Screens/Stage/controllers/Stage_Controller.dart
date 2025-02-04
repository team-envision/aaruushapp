import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/views/myEvents.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/state/Home_State.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/views/home_screen.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/controllers/profileController.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/state/Profile_State.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/views/profilepage.dart';
import 'package:AARUUSH_CONNECT/Screens/TimeLine/controllers/timeline_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/TimeLine/state/Timeline_State.dart';
import 'package:AARUUSH_CONNECT/Screens/TimeLine/views/timeline_view.dart';
import 'package:get/get.dart';

import '../../Home/controllers/home_controller.dart';

class StageController extends GetxController
    with GetSingleTickerProviderStateMixin {
RxInt index = 0.obs;
  final pagesList = [
    GetBuilder<HomeController>(
      builder: (controller) => HomeScreen(),
      init: HomeController(
        state: Get.put(HomeState()),
        commonController: Get.find<CommonController>(),
      ),
    ),

    GetBuilder<HomeController>(
      builder: (controller) => MyEvents(),

      init: Get.put(HomeController(commonController: Get.find<CommonController>(), state: HomeState())),
    ),

    GetBuilder<TimelineController>(
      builder: (controller) => TimelineView(),
      init: TimelineController(
        state: Get.put(TimelineState()),
      ),
    ),

    GetBuilder<ProfileController>(
      builder: (controller) => ProfileScreen(),
      init: ProfileController(
          commonController: Get.find<CommonController>(),
          state: Get.put(ProfileState())
      ),
    ),

  ];

  void updateBottomNavBarIndex(int index) {
    this.index = index.obs;
    update();
    Get.appUpdate();

  }

  @override
  void onInit() {
    super.onInit();
  }
}
