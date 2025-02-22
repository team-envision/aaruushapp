import 'package:AARUUSH_CONNECT/Screens/Home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../controllers/Search_Controller.dart';
import '../state/Search_State.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SearchBarController(homeController: Get.find<HomeController>(), state: Get.put(SearchState())));
  }
}