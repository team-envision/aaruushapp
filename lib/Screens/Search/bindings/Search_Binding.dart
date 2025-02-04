import 'package:AARUUSH_CONNECT/Screens/Home/controllers/home_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Search/controllers/Search_Controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Search/state/Search_State.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SearchBarController(homeController: Get.find<HomeController>(), state: Get.put(SearchState())));
  }
}