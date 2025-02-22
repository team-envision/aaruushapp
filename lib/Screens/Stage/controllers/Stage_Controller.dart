import 'package:AARUUSH_CONNECT/Screens/Events/MyEvents/view/myEvents.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/views/home_screen.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/controllers/profileController.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/views/profilepage.dart';
import 'package:AARUUSH_CONNECT/Screens/TimeLine/controllers/timeline_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/TimeLine/views/timeline_view.dart';
import 'package:get/get.dart';
import '../../Home/controllers/home_controller.dart';

class StageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt index = 0.obs;
  final pagesList = [
    GetBuilder<HomeController>(
        builder: (controller) => HomeScreen(),
        init: Get.find<HomeController>()),
    GetBuilder<HomeController>(
        builder: (controller) => const MyEvents(),
        init: Get.find<HomeController>()),
    GetBuilder<TimelineController>(
      builder: (controller) => const TimelineView(),
      init: Get.find<TimelineController>(),
    ),
    GetBuilder<ProfileController>(
      builder: (controller) => ProfileScreen(),
      init: Get.find<ProfileController>(),
    ),
  ];

  void updateBottomNavBarIndex(int index) {
    this.index = index.obs;
    update();
  }
}
