import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Common/core/Routes/app_routes.dart';
import 'package:AARUUSH_CONNECT/Common/core/Storage_Resources/local_client.dart';
import 'package:AARUUSH_CONNECT/Common/core/Storage_Resources/local_key.dart';
import 'package:AARUUSH_CONNECT/Common/core/Utils/Logger/app_logger.dart';
import 'package:AARUUSH_CONNECT/Data/api_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {


  Future<void> getLandingPage() async {

    bool isSignedIn = await CommonController.isUserSignedIn();
    String? accessToken = ApiData.accessToken;
    String? userEmail = LocalClient.getString(key: LocalKeys.userEmail);
Log.info(accessToken);
    bool isUserAvailableinFirebase = await CommonController.isUserAvailableInFirebase(userEmail);

    if (accessToken.isEmpty) {
      Log.debug("access token is empty");
      Get.toNamed(AppRoutes.onBoarding);
    } else {
      Log.debug("access token is not empty");
      if (isSignedIn && isUserAvailableinFirebase) {
        Log.info("User signed in");
        Get.toNamed(AppRoutes.aaruushBottomBar);
      } else if (isSignedIn && !isUserAvailableinFirebase) {
        Log.info("User not registered in firebase");
        Get.toNamed(AppRoutes.registerView);
      } else {
        Log.info("User not signed in");
        Get.toNamed(AppRoutes.onBoarding);
      }
    }
  }

@override
  void onInit() {
    super.onInit();
    getLandingPage();
  }


}
