import 'package:aarush/components/AuthTextFields.dart';
import 'package:aarush/components/primaryButton.dart';
import 'package:aarush/components/white_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class registerView extends StatelessWidget {
  registerView({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WhiteBox(
        margin: const EdgeInsets.all(20),
        width: Get.width,
        height: Get.height * 0.7,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, top: 15, bottom: 5),
                    child: AuthTextFields(
                        hintText: 'Name',
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
                        isPasswordObsecure: false.obs,
                        validator: (value) {
                          if(value!.isEmpty || value == Null){
                            return "Enter Your Register No.";
                          }

                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                    child: AuthTextFields(
                        hintText: 'Phone Number',
                        isPasswordObsecure: false.obs,
                        validator: (value) {
                          if(value!.isEmpty || value == Null){
                            return "Enter Your Ph. No.";
                          }
                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                    child: AuthTextFields(
                        hintText: 'Email',
                        isPasswordObsecure: false.obs,
                        validator: (value) {
                          if(value!.isEmpty || value == Null){
                            return "Enter Your Email";
                          }
                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                    child: AuthTextFields(
                        hintText: 'Enter Password',
                        isPasswordObsecure: true.obs,
                        validator: (value) {
                          if(value!.isEmpty || value == Null){
                            return "Enter Password";
                          }
                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                    child: AuthTextFields(
                        hintText: 'Confirm Password',
                        isPasswordObsecure: true.obs,
                        validator: (value) {
                          if(value!.isEmpty || value == Null){
                            return "Confirm Password";
                          }
                        }),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(width: Get.width-150,
                      child: primaryButton(
                          text: "Sign Up",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              print("World");
                            }
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
