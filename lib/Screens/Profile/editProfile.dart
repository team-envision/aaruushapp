import 'package:aarush/Screens/Profile/profileController.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/components/aaruushappbar.dart';
import 'package:aarush/components/bg_area.dart';
import 'package:aarush/components/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../components/profile_text_field.dart';
import '../Home/home_controller.dart';

//TODO: make the

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<ProfileController>(ProfileController());
    // controller.common.signOutCurrentUser();
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF070709),
      appBar: AaruushAppBar(title: "Edit Profile", actions: [
        IconButton(
          onPressed: () => {Get.back()},
          icon: const Icon(Icons.close_rounded),
          color: Colors.white,
          iconSize: 25,
        ),
      ]),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: controller.formkey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    iconSize: MediaQuery.of(context).size.height / 6,
                    onPressed: () {},
                    icon: Obx(
                      () => controller.homeController.common.profileUrl.value !=
                              null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(controller
                                  .homeController.common.profileUrl.value!),
                            )
                          : Image.asset(
                              'assets/images/profile.png',
                              height: 30,
                            ),
                    ),
                    color: Colors.white,
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   iconSize: MediaQuery.of(context).size.height / 6,
                  //   icon: CircleAvatar(
                  //     backgroundColor: Colors.white,
                  //     radius: 60,
                  //     child: SvgPicture.asset(
                  //       'assets/images/icons/GroupCamera.svg',
                  //       colorFilter: const ColorFilter.mode(
                  //           Colors.black, BlendMode.srcIn),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              // TextButton(
              //     onPressed: () {},
              //     style: const ButtonStyle(
              //         padding: MaterialStatePropertyAll(EdgeInsets.zero)),
              //     child: const Text(
              //       'Choose from gallery',
              //       style: TextStyle(fontSize: 18, color: Color(0xFFEF6522)),
              //     )),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height / 50,
              // ),
              CustomTextField(
                label: 'Name',
                type: TextInputType.text,
                controller: controller.nameController,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              CustomTextField(
                  controller: controller.phoneController,
                  label: 'Phone',
                  type: TextInputType.phone),
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              CustomTextField(
                controller: controller.emailController,
                label: 'Email',
                type: TextInputType.emailAddress,
                enabled: false,
              ),
              // SizedBox(height: MediaQuery.of(context).size.height/25,),
              sizeBox(50, 0),
              primaryButton(
                  text: "Save",
                  onTap: () {
                    if (controller.formkey.currentState!.validate()) {
                      controller.updateProfile();
                    }
                  })
            ],
          ),
        ),
      ),
    ));
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.type,
      required this.label,
      this.enabled,
      required this.controller});
  final TextInputType type;
  final String label;
  bool? enabled;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return profileTextField(
        enabled: enabled,
        keyboard: type,
        controller: controller,
        validator: (v) {
          if (v!.isEmpty) {
            return 'This field cannot be empty';
          }
          return null;
        },
        label: label);
  }
}
