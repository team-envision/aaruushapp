import 'package:AARUUSH_CONNECT/components/AuthTextFields.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:AARUUSH_CONNECT/components/primaryButton.dart';
import 'package:AARUUSH_CONNECT/components/white_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Register_controller.dart';

class registerView extends StatelessWidget {
  registerView({super.key});

  final controller = Get.put<RegisterController>(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgArea(
        children: [
          SafeArea(
            child: SvgPicture.asset(
              'assets/images/Aarushlogo.svg',
              height: 300,
              width: 500,
            ),
          ),

      
        Obx((){
          return   WhiteBox(
              margin: const EdgeInsets.all(20),
              width: Get.width,
              height:controller.height.value,
              child: SingleChildScrollView(
                child:  Form(
                    key: controller.formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20.0, left: 20.0, top: 15, bottom: 5),
                            child: AuthTextFields(
                                hintText: 'Name',
                                controller: controller.NameTextEditingController,
                                isPasswordObsecure: false.obs,
                                validator: (value) {
                                  if(value!.isEmpty || value == Null){
                                    return "Enter Your Name";
                                  }
                                }),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                            child: AuthTextFields(
                                hintText: 'College/University',
                                controller: controller.CollgeTextEditingController,
                                isPasswordObsecure: false.obs,
                                validator: (value) {
                                  if(value!.isEmpty || value == Null){
                                    return "Enter Your College Name";
                                  }

                                }),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                            child: AuthTextFields(
                                hintText: 'Register Number',
                                controller: controller.RegNoTextEditingController,
                                isPasswordObsecure: false.obs,
                                validator: (value) {
                                  if(value!.isEmpty || value == Null){
                                    return "Enter Your Register No. / College id";
                                  }
                                  else if(value.length.isLowerThan(5) || controller.RegNoTextEditingController.text == controller.PhNoTextEditingController.text){
                                    return "Enter valid Id";
                                  }

                                }),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                            child: AuthTextFields(
                                hintText: 'Phone Number',
                                textInputType: TextInputType.phone,
                                controller: controller.PhNoTextEditingController,
                                isPasswordObsecure: false.obs,
                                validator: (value) {
                                  if(value!.isEmpty || value == Null || !value.isPhoneNumber){
                                    return "Enter Your Ph. No.";
                                  }
                                }),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                            child: AuthTextFields(
                                hintText: 'Email',
                                controller: controller.EmailTextEditingController,
                                isPasswordObsecure: false.obs,
                                validator: (value) {
                                  if(value!.isEmpty || value == Null){
                                    return "Enter Your Email";
                                  }
                                }),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(width: Get.width-150,
                              child: primaryButton(
                                  text: "Submit",
                                  onTap: () async {
                                    if (controller.formKey.currentState!.validate()) {
                                      controller.saveUserToFirestore(
                                          name: controller.NameTextEditingController.text,
                                          college: controller.CollgeTextEditingController.text,
                                          registerNumber: controller.RegNoTextEditingController.text,
                                          phoneNumber: controller.PhNoTextEditingController.text,
                                          email: controller.EmailTextEditingController.text,
                                      );
                                      controller.updateProfile();
                                      controller.height.value = Get.height*0.55;
                                    }
                                    else{
                                      controller.height.value = Get.height*0.6;
                                    }
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

              ));
        })
      
        ],
      
      ),
    );
  }
}
