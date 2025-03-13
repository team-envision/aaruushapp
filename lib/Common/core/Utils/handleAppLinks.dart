import 'package:get/get.dart';

import '../Routes/app_routes.dart';

void handleDeepLink(Uri uri) {
  switch (uri.path) {
    case '/onBoarding':
      Get.toNamed(AppRoutes.onBoarding);
      break;
    case '/signIn':
      Get.toNamed(AppRoutes.signIn);
      break;
    case '/splashScreen':
      Get.toNamed(AppRoutes.splash);
      break;
    case '/aaruushBottomBar':
      Get.toNamed(AppRoutes.aaruushBottomBar);
      break;
    case '/registerView':
      Get.toNamed(AppRoutes.registerView);
      break;
    case '/certificateView':
      Get.toNamed(AppRoutes.certificateView);
      break;
    case '/homeScreen':
      Get.toNamed(AppRoutes.homeScreen);
      break;
    case '/notificationScreen':
      Get.toNamed(AppRoutes.notificationScreen);
      break;
    case '/profileScreen':
      Get.toNamed(AppRoutes.profileScreen);
      break;
    case '/editprofileScreen':
      Get.toNamed(AppRoutes.editprofileScreen);
      break;
    case '/timeLine':
      Get.toNamed(AppRoutes.timeLine);
      break;
    case '/myEvents':
      Get.toNamed(AppRoutes.myEvents);
      break;
    case '/stage':
      Get.toNamed(AppRoutes.stage);
      break;
    case '/about':
      Get.toNamed(AppRoutes.about);
      break;
    case '/search':
      Get.toNamed(AppRoutes.search);
      break;
    case '/ticket':
      Get.toNamed(AppRoutes.ticket);
      break;
    case '/registerEvent':
      Get.toNamed(AppRoutes.registerEvent);
      break;
    case '/eventScreen':
      Get.toNamed(AppRoutes.eventScreen);
      break;
    default:
      Get.toNamed(AppRoutes.pageNotFound); // Redirect to a 404 page if the route is not found
      break;
  }
}
