import 'package:AARUUSH_CONNECT/Screens/Notification/controllers/NotificationController.dart';
import 'package:get/get.dart';

class NotificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(NotificationController());
  }

}