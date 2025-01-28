import 'package:AARUUSH_CONNECT/Common/core/Routes/app_routes.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/OnBoard/views/on_boarding_screen.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/Register/bindings/Register_Binding.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/Register/views/Register_View.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/Signin/bindings/SignIn_binding.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/Signin/views/signin_screen.dart';
import 'package:AARUUSH_CONNECT/Screens/Certificates/bindings/Certificate_Bindings.dart';
import 'package:AARUUSH_CONNECT/Screens/Certificates/views/CertificateView.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/views/myEvents.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/bindings/Home_Bindings.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/views/home_screen.dart';
import 'package:AARUUSH_CONNECT/Screens/Notification/bindings/Notification_Binding.dart';
import 'package:AARUUSH_CONNECT/Screens/Notification/views/NotificationScreen.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/bindings/Profile_Bindings.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/views/profilepage.dart';
import 'package:AARUUSH_CONNECT/Screens/Splash/bindings/Splash_binding.dart';
import 'package:AARUUSH_CONNECT/Screens/Splash/views/Splash_View.dart';
import 'package:AARUUSH_CONNECT/Screens/TimeLine/timeline_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/TimeLine/timeline_view.dart';
import 'package:AARUUSH_CONNECT/Utilities/AaruushBottomBar.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static List<GetPage> pages = [
    GetPage(
        name: AppRoutes.splash,
        page: () => const SplashView(),
        binding: SplashBinding()),
    GetPage(
      name: AppRoutes.onBoarding,
      page: () => const OnBoardingScreen(),
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInScreen(),
      binding: SignInBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: AppRoutes.signIn,
        page: () => const SplashView(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.aaruushBottomBar,
        page: () => AaruushBottomBar(),
        children: [
          GetPage(
              name: AppRoutes.homeScreen,
              page: () => HomeScreen(),
              binding: HomeBindings()),
          GetPage(
              name: AppRoutes.myEvents,
              page: () => MyEvents(fromProfile: false),
          ),
          GetPage(
              name: AppRoutes.timeLine,
              page: () => const TimelineView(),
              ),
          GetPage(
              name: AppRoutes.profileScreen,
              page: () => ProfileScreen(),
              binding: ProfileBindings()),
        ]),
    GetPage(
      name: AppRoutes.registerView,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.certificateView,
      page: () => CertificateView(),
      binding: CertificateBindings(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AppRoutes.notificationScreen,
      page: () => NotificationScreen(),
      binding: NotificationBinding(),
    ),
  ];
}
