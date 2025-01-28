import 'package:AARUUSH_CONNECT/Screens/Splash/controllers/Splash_Controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
