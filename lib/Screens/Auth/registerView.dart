import 'package:AARUUSH_CONNECT/components/AuthTextFields.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:AARUUSH_CONNECT/components/primaryButton.dart';
import 'package:AARUUSH_CONNECT/components/white_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'Register_controller.dart';

class registerView extends StatelessWidget {
  registerView({super.key});

  final controller = Get.put<RegisterController>(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BgArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;
            double fieldHeight = screenHeight * 0.07;

            return Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.06,
                bottom: screenHeight * 0.06,
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/Aarushlogo.svg',
                    height: screenHeight * 0.4,
                    width: screenWidth * 0.8,
                  ),
                  Obx(() {
                    return Expanded(
                      child: WhiteBox(
                        margin: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                        ),
                        width: screenWidth,
                        height: controller.height.value,
                        bordersize: 28,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          child: Form(
                            key: controller.formKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                                vertical: screenHeight * 0.02,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Text Fields
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.01,
                                      bottom: screenHeight * 0.01,
                                    ),
                                    child: SizedBox(
                                      height: fieldHeight,
                                      child: AuthTextFields(
                                        hintText: 'Name',
                                        controller: controller.NameTextEditingController,
                                        isPasswordObsecure: false.obs,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter Your Name";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.01,
                                      bottom: screenHeight * 0.01,
                                    ),
                                    child: SizedBox(
                                      height: fieldHeight,
                                      child: AuthTextFields(
                                        hintText: 'College/University',
                                        controller: controller.CollgeTextEditingController,
                                        isPasswordObsecure: false.obs,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter Your College Name";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.01,
                                      bottom: screenHeight * 0.01,
                                    ),
                                    child: SizedBox(
                                      height: fieldHeight,
                                      child: AuthTextFields(
                                        hintText: 'Register Number',
                                        controller: controller.RegNoTextEditingController,
                                        isPasswordObsecure: false.obs,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter Your Register No. / College ID";
                                          } else if (value.length.isLowerThan(5) ||
                                              controller.RegNoTextEditingController.text ==
                                                  controller.PhNoTextEditingController.text) {
                                            return "Enter a valid ID";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.01,
                                      bottom: screenHeight * 0.01,
                                    ),
                                    child: SizedBox(
                                      height: fieldHeight,
                                      child: AuthTextFields(
                                        hintText: 'Phone Number',
                                        textInputType: TextInputType.phone,
                                        controller: controller.PhNoTextEditingController,
                                        isPasswordObsecure: false.obs,
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !value.isPhoneNumber) {
                                            return "Enter Your Phone Number";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.01,
                                      bottom: screenHeight * 0.01,
                                    ),
                                    child: SizedBox(
                                      height: fieldHeight,
                                      child: AuthTextFields(
                                        hintText: 'Email',
                                        controller: controller.EmailTextEditingController,
                                        isPasswordObsecure: false.obs,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter Your Email";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  // Submit Button
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.02,
                                      bottom: screenHeight * 0.01,
                                    ),
                                    child: SizedBox(
                                      height: fieldHeight,
                                      child: primaryButton(
                                        borderRadius: 28,
                                        text: "Submit",
                                        onTap: () async {
                                          if (controller.formKey.currentState!.validate()) {
                                            await controller.saveUserToFirestore();
                                            await controller.updateProfile();
                                            controller.height.value = screenHeight * 0.55;
                                          } else {
                                            controller.height.value = screenHeight * 0.6;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}