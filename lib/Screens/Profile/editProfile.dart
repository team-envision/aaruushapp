import 'package:aarush/Screens/Profile/profileController.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/components/aaruushappbar.dart';
import 'package:aarush/components/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/profile_text_field.dart';
import '../Home/home_controller.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<ProfileController>(ProfileController());
    final homeController = Get.find<HomeController>();

    return SafeArea(
      child: Scaffold(
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
            child: Column(
              children: <Widget>[
                sizeBox(150, 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      iconSize: MediaQuery.of(context).size.height / 6,
                      onPressed: () {},
                      icon: Obx(
                            () => CircleAvatar(
                          radius: 60,
                          backgroundImage: homeController.common.profileUrl.value != null
                              ? NetworkImage(homeController.common.profileUrl.value!)
                              : AssetImage('assets/images/profile.png') as ImageProvider,
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ],
                ),
                sizeBox(50, 0),
                CustomTextField(
                  label: 'Name',
                  type: TextInputType.text,
                  controller: controller.nameController,
                ),
                sizeBox(50, 0),
                CustomTextField(
                  controller: controller.phoneController,
                  label: 'Phone',
                  type: TextInputType.phone,
                ),
                sizeBox(50, 0),
                CustomTextField(
                  controller: controller.emailController,
                  label: 'Email',
                  type: TextInputType.emailAddress,
                  enabled: false,
                ),
                sizeBox(50, 0),
                primaryButton(
                  text: "Save",
                  onTap: () {
                    if (controller.formkey.currentState!.validate()) {
                      controller.updateProfile();
                    }
                  },
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
    Key? key,
    required this.type,
    required this.label,
    this.enabled,
    required this.controller,
  }) : super(key: key);

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
