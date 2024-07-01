import 'package:aarush/Screens/Auth/auth_controller.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/components/bg_area.dart';
import 'package:aarush/components/primaryButton.dart';
import 'package:aarush/components/profile_text_field.dart';
import 'package:aarush/components/white_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<AuthController>(AuthController());
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
          height: Get.height * 0.4,
          width: Get.width,
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                sizeBox(50, 0),
                Text('Register or login to continue',
                    style: Get.theme.kTitleTextStyle
                        .copyWith(color: Colors.black87)),
                sizeBox(30, 0),
                TextButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black26.withAlpha(9),
                        elevation: 8,
                        shadowColor: Colors.black12,
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
              ],
            ),
          ),
        )
      ]),
    ));
  }
}
