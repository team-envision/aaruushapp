import 'package:AARUUSH_CONNECT/Screens/Profile/profileController.dart';
import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/profile_text_field.dart';
import '../Home/home_controller.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<ProfileController>(ProfileController());
    final homeController = Get.put<HomeController>(HomeController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF070709),
      appBar: AaruushAppBar(
        title: "Edit Profile",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SizedBox(
              height: 35,
              width: 35,
              child: IconButton.outlined(
                padding: EdgeInsets.zero,
                onPressed: () => {Navigator.pop(context)},
                icon: const Icon(Icons.close_rounded),
                color: Colors.white,
                iconSize: 20,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Form(
            key: controller.formkey,
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 8),
                  Obx(
                    () => CircleAvatar(
                      radius: 70,
                      backgroundImage: homeController.common.profileUrl.value !=
                              null
                          ? NetworkImage(homeController.common.profileUrl.value)
                          : const AssetImage('assets/images/profile.png')
                              as ImageProvider,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      height: 55,
                      child: CustomTextField(
                        label: 'Name',
                        type: TextInputType.text,
                        controller: controller.nameController,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: 55,
                      child: CustomTextField(
                        controller: controller.phoneController,
                        label: 'Phone',
                        type: TextInputType.phone,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: 55,
                      child: CustomTextField(
                        controller: controller.emailController,
                        label: 'Email',
                        type: TextInputType.emailAddress,
                        enabled: false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: SizedBox(
                      height: 55,
                      width: Get.width,
                      child: primaryButton(
                        text: "Save",
                        onTap: () {
                          if (controller.formkey.currentState!.validate()) {
                            controller.updateProfile();
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
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.type,
    required this.label,
    this.enabled,
    required this.controller,
  });

  final TextInputType type;
  final String label;
  final bool? enabled;
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
      label: label,
    );
  }
}
