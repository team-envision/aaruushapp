

import 'package:AARUUSH_CONNECT/Screens/About/aboutpage.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/editProfile.dart';
import 'package:AARUUSH_CONNECT/Screens/Tickets/myEvents.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/Utilities/correct_ellipis.dart';
import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Home/home_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomeController>(HomeController());

    return Scaffold(extendBody: true,extendBodyBehindAppBar: true,
      appBar: AaruushAppBar(
        title: "Profile",

      ),
      body: BgArea(
        children: <Widget>[
          SizedBox(height: 0.3*Get.width,),
          Row(mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    iconSize: MediaQuery.of(context).size.height / 6,
                    icon: Obx(
                          () => CircleAvatar(
                        radius: 50,
                        backgroundImage: controller.common.profileUrl.value != null
                            ? NetworkImage(controller.common.profileUrl.value)
                            : const AssetImage('assets/images/profile.png') as ImageProvider,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 3,
                    child: GestureDetector(
                      onTap: () => Get.to(() => const EditProfile()),
                      child: Container(
                        width: MediaQuery.of(context).size.height / 20,
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: const ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [Color(0xFFED6522), Color(0xFFC59123)],
                          ),
                          shape: OvalBorder(),
                        ),
                        child: const Icon(Icons.edit),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: FittedBox(
                              child: Text(
                                controller.common.userName.value.useCorrectEllipsis(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Get.theme.kTitleTextStyle,
                                                        ),
                            ),
                          ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: FittedBox(
                        child: Text(
                          controller.common.emailAddress.value,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Get.theme.kVerySmallTextStyle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: FittedBox(
                        child: Text(
                          controller.common.aaruushId.value,
                          style: Get.theme.kVerySmallTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 100),
          // ProfileButtons(
          //   leadingIcon: Icons.lock_outlined,
          //   trailingIcon: Icons.arrow_forward_ios_outlined,
          //   buttonName: 'Change Password',
          //   onPressedFunc: () {
          //
          //   }, color: Colors.white,
          // ),
          ProfileButtons(
            buttonName: 'My Events',
            leadingIcon: Icons.celebration_outlined,
            trailingIcon: Icons.arrow_forward_ios_outlined,
            onPressedFunc: () {
              Get.to(() => MyEvents(
                eventList: controller.eventList,
              ));
            }, color: Colors.white,
          ),
          // ProfileButtons(buttonName: 'My Proshows', onPressedFunc: () {}),

          ProfileButtons(
            buttonName: 'About Aaruush',
            leadingIcon: Icons.info_outline_rounded,
            trailingIcon: Icons.arrow_forward_ios_outlined,
            onPressedFunc: () {
              Get.to(() => const AboutPage());
            }, color: Colors.white,
          ),
          // ProfileButtons(
          //   buttonName: 'Help Section',
          //   leadingIcon: Icons.headset_mic_outlined,
          //   trailingIcon: Icons.arrow_forward_ios_outlined,
          //   onPressedFunc: () {
          //
          //   }, color: Colors.white,
          // ),



          const SizedBox(height: 10),
          ProfileButtons(
            buttonName: "Log out",
            onPressedFunc: () => controller.common.signOutCurrentUser(), leadingIcon: Icons.logout, color: const Color.fromRGBO(239, 101, 34, 1),
          ),
        ],
      ),

    );
  }
}

class ProfileButtons extends StatelessWidget {
  final String buttonName;
  final IconData leadingIcon;
  final Color color;
   IconData? trailingIcon;
  final VoidCallback onPressedFunc;

   ProfileButtons({
    super.key,
    required this.buttonName,
    required this.onPressedFunc,
     required this.leadingIcon,
    IconData? trailingIcon, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width / 15,
        MediaQuery.of(context).size.height / 50,
        MediaQuery.of(context).size.width / 15,
        0,
      ),
      child: GestureDetector(onTap: onPressedFunc,
        child: Container(
          width: Get.width,
          height: 56,
          decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(7),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(leadingIcon,color: Colors.black,size: 26,),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  buttonName,
                  style:Get.theme.kSmallTextStyle.copyWith(
                    color: Colors.black,fontWeight: FontWeight.w500
                  ),
                ),
              ),
             const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(trailingIcon,color: Colors.black,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
