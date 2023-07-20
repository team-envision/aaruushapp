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
import 'package:get_storage/get_storage.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BgArea(children: [
          sizeBox(50, 0),
          SvgPicture.asset(
            'assets/images/aaruush.svg',
            height: 200,
            width: 500,
          ),
          Text("AARUUSH",
              style: Get.theme.kBigTextStyle.copyWith(fontFamily: 'Xirod')),
          sizeBox(5, 0),
          Text("Connect", style: Get.theme.kVerySmallTextStyle),
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
                  padding: const EdgeInsets.only(left: 20.0),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: const Text(
                        'WELCOME',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                sizeBox(25, 0),
                const Flexible(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Lorem ipsum dolor sit amet,consectetur adipiscing elit labore et.',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black87,
                    ),
                  ),
                )),
                sizeBox(30, 0),
                Center(
                  child: primaryButton(
                      text: "Get Started",
                      onTap: () => {
                            // if (GetStorage().read('givenIntro') ?? true)
                            //   {GetStorage().write('givenIntro', false)},
                            // Get.off(() => LoginScreen()),
                            Get.off(() => AuthScreen()),
                          }),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
