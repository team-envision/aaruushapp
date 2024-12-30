import 'package:AARUUSH_CONNECT/Screens/Auth/auth_screen.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/Utilities/custom_sizebox.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:AARUUSH_CONNECT/components/primaryButton.dart';
import 'package:AARUUSH_CONNECT/components/white_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: innerConstraints.maxWidth * 0.1),
                                child: Text(
                                  "WELCOME",
                                  style: Get.theme.kSmallmidTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: innerConstraints.maxWidth * 0.06,
                                  ),
                                ),
                              ),
                            ),
                            sizeBox(innerConstraints.maxHeight * 0.1, 0),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: innerConstraints.maxWidth * 0.1),
                                child: Text(
                                  "Embracing Change, Pioneering Excellence",
                                  style: Get.theme.kSmallTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: innerConstraints.maxWidth * 0.045,
                                  ),
                                ),
                              ),
                            ),
                            sizeBox(innerConstraints.maxHeight * 0.1, 0),
                            Center(
                              child: SizedBox(
                                height: innerConstraints.maxHeight * 0.25,
                                width: innerConstraints.maxWidth * 0.8,
                                child: primaryButton(
                                  text: 'Get Started',
                                  onTap: () => {
                                    Get.off(() => const AuthScreen()),
                                  },
                                ),
                              ),
                            ),
                          ],
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