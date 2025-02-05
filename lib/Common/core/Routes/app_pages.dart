import 'package:AARUUSH_CONNECT/Common/core/Routes/app_routes.dart';
import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:AARUUSH_CONNECT/Screens/About/views/aboutpage.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/OnBoard/views/on_boarding_screen.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/Register/bindings/Register_Binding.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/Register/views/Register_View.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/Signin/bindings/SignIn_binding.dart';
import 'package:AARUUSH_CONNECT/Screens/Auth/Signin/views/signin_screen.dart';
import 'package:AARUUSH_CONNECT/Screens/Certificates/bindings/Certificate_Bindings.dart';
import 'package:AARUUSH_CONNECT/Screens/Certificates/views/CertificateView.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/myEventsBinding.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/views/events_screen.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/views/myEvents.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/views/register_event.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/bindings/Home_Bindings.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/views/home_screen.dart';
import 'package:AARUUSH_CONNECT/Screens/Notification/bindings/Notification_Binding.dart';
import 'package:AARUUSH_CONNECT/Screens/Notification/views/NotificationScreen.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/bindings/Profile_Bindings.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/views/editProfile.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/views/profilepage.dart';
import 'package:AARUUSH_CONNECT/Screens/Search/bindings/Search_Binding.dart';
import 'package:AARUUSH_CONNECT/Screens/Search/views/SearchView.dart';
import 'package:AARUUSH_CONNECT/Screens/Splash/bindings/Splash_binding.dart';
import 'package:AARUUSH_CONNECT/Screens/Splash/views/Splash_View.dart';
import 'package:AARUUSH_CONNECT/Screens/Stage/bindings/Stage_Binding.dart';
import 'package:AARUUSH_CONNECT/Screens/Stage/views/Stage_View.dart';
import 'package:AARUUSH_CONNECT/Screens/Tickets/views/TicketDisplayPage.dart';
import 'package:AARUUSH_CONNECT/Screens/TimeLine/views/timeline_view.dart';
import 'package:flutter/material.dart';
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
        name: AppRoutes.stage,
        page: () => const StageView(),
        binding: StageBinding(),
        transition: Transition.noTransition,
        // children: [
        //   GetPage(
        //       name: AppRoutes.homeScreen,
        //       page: () => HomeScreen(),
        //       binding: HomeBindings()
        //   ),
        //   GetPage(
        //     name: AppRoutes.myEvents,
        //     page: () => MyEvents(),
        //     binding: MyEventsBinding()
        //
        //   ),
        //   GetPage(
        //     name: AppRoutes.timeLine,
        //     page: () => const TimelineView(),
        //   ),
        //   GetPage(
        //       name: AppRoutes.profileScreen,
        //       page: () => ProfileScreen(),
        //       binding: ProfileBindings()),
        // ]
    ),
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
      name: AppRoutes.myEvents,
      page: () => MyEvents(),
        binding: MyEventsBinding()
    ),
    GetPage(
      name: AppRoutes.timeLine,
      page: () => const TimelineView(),
    ),
    GetPage(
      name: AppRoutes.notificationScreen,
      page: () => NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => const AboutPage(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
        name: AppRoutes.profileScreen,
        page: () => ProfileScreen(),
        binding: ProfileBindings()),
    GetPage(
      name: AppRoutes.editprofileScreen,
      page: () => const EditProfile(),
      binding: ProfileBindings(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => Searchscreen(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: AppRoutes.registerEvent,
      page: () => RegisterEvent(event: Get.arguments),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.ticket,
      page: () => TicketDisplayPage(event: Get.arguments),
    ),
    GetPage(
      name: AppRoutes.eventScreen,
      page: () => EventsScreen(
        fromMyEvents: false.obs,
      ),
    ),
  ];
}
