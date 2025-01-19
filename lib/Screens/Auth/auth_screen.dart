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
      body: BgArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;

            return Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.06,
                bottom: screenHeight * 0.06,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/images/Aarushlogo.svg',
                    height: screenHeight * 0.4,
                    width: screenWidth * 0.8,
                  ),
                  WhiteBox(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.02,
                    ),
                    height: screenHeight * 0.3,
                    width: screenWidth,
                    child: LayoutBuilder(
                      builder: (context, innerConstraints) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: innerConstraints.maxHeight * 0.25,
                                width: Get.width,
                                child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    // fixedSize: const Size(300, 60),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () => controller.googleSignIn(),
                                  icon: SvgPicture.asset(
                                    'assets/images/google_logo.svg',
                                    height: Get.height*0.024,
                                    width: Get.height*0.024,
                                  ),
                                  label: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Sign in with Google',
                                      style: Get.theme.kSmallTextStyle
                                          .copyWith(color: Colors.black.withAlpha(138), fontSize: Get.height*0.018),
                                    ),
                                  ),
                                ),
                              ),
                              sizeBox(innerConstraints.maxHeight * 0.1, 0),
                              SizedBox(
                                height: innerConstraints.maxHeight * 0.25,
                                width: Get.width,
                                child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    // fixedSize: const Size(300, 60),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () => controller.appleSignIn(),
                                  icon: SvgPicture.asset(
                                    'assets/images/apple-logo.svg',
                                    height: Get.height*0.024,
                                    width: Get.height*0.024,
                                  ),
                                  label: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Sign in with Apple',
                                      style: Get.theme.kSmallTextStyle
                                          .copyWith(color: Colors.black.withAlpha(138), fontSize: Get.height*0.018),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

  }
}