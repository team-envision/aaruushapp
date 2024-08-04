import 'dart:ui';

import 'package:aarush/Screens/Auth/auth_screen.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/components/bg_area.dart';
import 'package:aarush/components/primaryButton.dart';
import 'package:aarush/components/white_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgArea(children: [
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
                child: Text("Shifting Paradigms, Enriching Wellbeing",
                    style: Get.theme.kSmallTextStyle
                        .copyWith(color: Colors.white)),
              )),
              sizeBox(30, 0),
              Center(
                child: SizedBox(
                  height: 60,

                  child: primaryButton(
                      text:'Get Started',
                      onTap: () => {
                            // if (GetStorage().read('givenIntro') ?? true)
                            //   {GetStorage().write('givenIntro', false)},
                            // Get.off(() => LoginScreen()),
                            Get.off(() => AuthScreen()),
                          }),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
