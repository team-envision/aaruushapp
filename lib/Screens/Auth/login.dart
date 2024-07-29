import 'package:aarush/Screens/Auth/auth_controller.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/components/primaryButton.dart';
import 'package:aarush/components/white_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../components/AuthTextFields.dart';

class Login extends StatelessWidget {
   Login({super.key});
  final _formKey = GlobalKey<FormState>();
 RxBool isPasswordObsecure=true.obs  ;
   final controller = Get.put<AuthController>(AuthController());
  @override
  Widget build(BuildContext context) {
    return          WhiteBox(
      margin: const EdgeInsets.all(20),
      width: Get.width,
      height: Get.height * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                sizeBox(15, 0),
                Padding(
                  padding: const EdgeInsets.only(right: 115),
                  child: Text('Login to Your Account ',
                      style: Get.theme.kSmallmidTextStyle
                          .copyWith(color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Text('Make sure you already have an account. '),
                ),
                sizeBox(20, 0),
                Padding(
                  padding: const EdgeInsets.only(right: 172),
                  child: Text('Email Address',
                      style: Get.theme.kSmallmidTextStyle),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: AuthTextFields(
                        hintText: 'Enter your Email',
                        validator: (value) {
                          if (!value!.isEmail ||
                              value.isEmpty) {
                            return "Please Enter Valid Email";
                          }else{return null;}

                        }, suffixIcon: null, isPasswordObsecure: false.obs,)),
                sizeBox(10, 0),
                Padding(
                  padding: const EdgeInsets.only(right: 192),
                  child: Text('Password', style: Get.theme.kSmallmidTextStyle),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: AuthTextFields(
                    hintText: 'Enter your password',
                   suffixIcon: Obx((){
                     return IconButton(
                       icon:isPasswordObsecure.value?  Icon(Icons.visibility_off): Icon(Icons.visibility),
                       onPressed: () {
                         isPasswordObsecure.value=false ;

                       },
                     );
                   }),


                    validator: (value) {
                      if (value==null || value.isEmpty) {
                        return 'Please Enter Valid Password';
                      }else{return null;}

                    }, isPasswordObsecure: isPasswordObsecure,




                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 150, right: 4),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: SizedBox(
                    height: 50,
                    child: primaryButton(
                        text: "Login",
                        onTap: () => {
                          if (_formKey.currentState!.validate())
                            {
                              print("hello"),
                            }
                        }),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: TextButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: Colors.black12,
                          padding: const EdgeInsets.all(13),
                          fixedSize: Size.fromWidth(Get.width),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(38))),
                      onPressed: () => controller.googleSignIn(),
                      icon: SvgPicture.asset('assets/images/google_logo.svg',
                          height: 24, width: 24),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10
                            ),
                        child: Text(
                          'Sign in with Google',
                          style: Get.theme.kSmallTextStyle
                              .copyWith(color: Colors.black.withAlpha(138)),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
