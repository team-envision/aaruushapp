import 'package:aarush/Screens/Auth/auth_controller.dart';
import 'package:aarush/Screens/Auth/auth_screen.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/components/bg_area.dart';
import 'package:aarush/components/primaryButton.dart';
import 'package:aarush/components/text_field.dart';
import 'package:aarush/components/white_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<AuthController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgArea(children: [
        sizeBox(50, 0),
        WhiteBox(
            height: Get.height,
            width: Get.width,
            margin: const EdgeInsets.all(20),
            child: Form(
              key: controller.signUpFormKey,
              child: Column(children: [
                sizeBox(50, 0),
                textField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    controller: controller.name,
                    label: 'Name'),
                textField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Please enter a valid college name';
                      }
                      return null;
                    },
                    controller: controller.college,
                    label: 'College/University'),
                textField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Please enter a valid register number';
                      }
                      return null;
                    },
                    controller: controller.registerNumber,
                    label: 'Register Number'),
                textField(
                    validator: (v) {
                      if (v!.isEmpty && !GetUtils.isPhoneNumber(v)) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                    controller: controller.phone,
                    label: 'Phone Number'),
                textField(
                    validator: (v) {
                      if (v!.isEmpty && !GetUtils.isEmail(v)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    controller: controller.emailAddress,
                    label: 'Email'),
                textField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    controller: controller.signupPassword,
                    label: 'Enter password'),
                textField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: controller.confirmPassword,
                    label: 'Confirm password'),
                sizeBox(20, 0),
                primaryButton(
                    text: 'Sign Up',
                    onTap: () => {
                          if (controller.signUpFormKey.currentState!.validate())
                            {
                              // controller.signUp()
                            }
                        }),
                sizeBox(20, 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: Get.width * 0.2,
                      color: Get.theme.curveBG.withOpacity(0.4),
                    ),
                    sizeBox(0, 5),
                    Text(
                      'or',
                      style: Get.theme.kVerySmallTextStyle
                          .copyWith(color: Colors.black87),
                    ),
                    sizeBox(0, 5),
                    Container(
                      height: 1,
                      width: Get.width * 0.2,
                      color: Get.theme.curveBG.withOpacity(0.4),
                    ),
                  ],
                ),
                sizeBox(20, 0),
                GestureDetector(
                  onTap: () => Get.off(() => AuthScreen()),
                  child: Text('Login',
                      style: Get.theme.kVerySmallTextStyle
                          .copyWith(color: Colors.black87)),
                ),
              ]),
            ))
      ]),
    );
  }
}
