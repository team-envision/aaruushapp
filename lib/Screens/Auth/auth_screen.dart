// import 'package:AARUUSH_CONNECT/Screens/Auth/auth_controller.dart';
// import 'package:AARUUSH_CONNECT/Screens/Auth/registerView.dart';
// import 'package:AARUUSH_CONNECT/Themes/themes.dart';
// import 'package:AARUUSH_CONNECT/Utilities/custom_sizebox.dart';
// import 'package:AARUUSH_CONNECT/components/bg_area.dart';
// import 'package:AARUUSH_CONNECT/components/primaryButton.dart';
// import 'package:AARUUSH_CONNECT/components/profile_text_field.dart';
// import 'package:AARUUSH_CONNECT/components/white_box.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import '../../components/AuthTextFields.dart';
// import 'loginView.dart';
//
// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});
//
//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
//   late TabController tabController;
//
//   @override
//   void initState() {
//     tabController = TabController(length: 2, vsync: this);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//         body: BgArea(
//           children: [
//             sizeBox(45, 0),
//             SvgPicture.asset(
//               'assets/images/Aarushlogo.svg',
//               height: 130,
//               width: 200,
//             ),
//
//
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 35),
//               child: Container(
//                 height:60,
//                 decoration: BoxDecoration(
//               color: Color(0xffF45D08),
//                 borderRadius: BorderRadius.circular(28),
//               ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: TabBar(
//                     dividerHeight: 0,
//                     unselectedLabelColor: Colors.black,
//                     labelColor: Colors.black,
//                   indicatorSize: TabBarIndicatorSize.label,
//                   labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                     indicatorPadding: EdgeInsets.symmetric(horizontal: -48),
//                     indicator: BoxDecoration(
//
//                       color: Colors.white,
//                         borderRadius: BorderRadius.circular(28),
//                       ),
//                     controller: tabController,
//                     tabs: [
//                       Tab(text: 'Login     ',
//                       ),
//                       Tab(text: 'Register'),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: Get.height-225,
//               child: TabBarView(
//                 controller: tabController,
//                 children: [Login(),registerView()],
//               ),
//             ),
//
//
//           ],
//         ));
//   }
//
//
// }



import 'dart:ui';

import 'package:AARUUSH_CONNECT/Screens/Auth/auth_controller.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/Utilities/custom_sizebox.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:AARUUSH_CONNECT/components/white_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<AuthController>(AuthController());
    return Scaffold(
      body: BgArea(child: Column(
        children: [
          sizeBox(50, 0),
          SvgPicture.asset(
            'assets/images/Aarushlogo.svg',
            height: 300,
            width: 500,
          ),

          sizeBox(50, 0),
          WhiteBox(
            margin: const EdgeInsets.all(20),
            height: 320,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizeBox(50, 0),
                Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child:  Text(
                        "WELCOME ",
                        style: Get.theme.kSmallmidTextStyle.copyWith(fontSize: 23),
                      ),
                    ),
                  ),
                ),
                sizeBox(25, 0),
                Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 60.0,right: 20.0),
                      child: Text("Embracing Change, Pioneering Excellence",
                          style: Get.theme.kSmallTextStyle
                              .copyWith(color: Colors.white)),
                    )),
                sizeBox(30, 0),
                Center(
                  child: SizedBox(
                      height: 60,
                      width: 300,
                      child:  TextButton.icon(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 10,
                              padding: const EdgeInsets.all(18),
                              fixedSize: Size.fromWidth(Get.width),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () => controller.googleSignIn(),
                          icon: SvgPicture.asset('assets/images/google_logo.svg',
                              height: 24, width: 24),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              'Sign in with Google',
                              style: Get.theme.kSmallTextStyle
                                  .copyWith(color: Colors.black.withAlpha(138)),
                            ),
                          ))
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

