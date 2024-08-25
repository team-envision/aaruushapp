import 'package:AARUUSH_CONNECT/Screens/Profile/profileController.dart';
import 'package:AARUUSH_CONNECT/components/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/profile_text_field.dart';
import '../Home/home_controller.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key,});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<ProfileController>(ProfileController());
    final homeController = Get.put<HomeController>(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xFF070709),
      appBar: AaruushAppBar(
        title: "Edit Profile",
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close_rounded),
            color: Colors.white,
            iconSize: 25,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: controller.formkey,
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0,left: 10,right: 10),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Obx(
                        () => CircleAvatar(
                      radius: 60,
                      backgroundImage: homeController.common.profileUrl.value != null
                          ? NetworkImage(homeController.common.profileUrl.value)
                          : const AssetImage('assets/images/profile.png') as ImageProvider,
                    ),
                  ),



                CustomTextField(
                  label: 'Name',
                  type: TextInputType.text,
                  controller: controller.nameController,
                ),

                CustomTextField(
                  controller: controller.phoneController,
                  label: 'Phone',
                  type: TextInputType.phone,
                ),

                CustomTextField(
                  controller: controller.emailController,
                  label: 'Email',
                  type: TextInputType.emailAddress,
                  enabled: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: primaryButton(
                    text: "Save",
                    onTap: () {
                      if (controller.formkey.currentState!.validate()) {
                        controller.updateProfile();
                      }
                    },
                  ),
                ),
              ],
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
