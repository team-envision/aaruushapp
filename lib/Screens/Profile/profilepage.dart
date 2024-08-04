import 'package:aarush/Data/bottomIndexData.dart';
import 'package:aarush/Screens/About/aboutpage.dart';
import 'package:aarush/Screens/Profile/editProfile.dart';
import 'package:aarush/Screens/Tickets/myEvents.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/correct_ellipis.dart';
import 'package:aarush/components/aaruushappbar.dart';
import 'package:aarush/components/bg_area.dart';
import 'package:aarush/components/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities/AaruushBottomBar.dart';
import '../Home/home_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomeController>(HomeController());

    return Scaffold(extendBody: true,extendBodyBehindAppBar: true,
      appBar: AaruushAppBar(
        title: "Profile",
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close_rounded),
            color: Colors.white,
            iconSize: 25,
          ),
        ],
      ),
      body: BgArea(
        children: <Widget>[
          SizedBox(height: 0.3*Get.width,),
          Row(
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
                            ? NetworkImage(controller.common.profileUrl.value!)
                            : AssetImage('assets/images/profile.png') as ImageProvider,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: GestureDetector(
                      onTap: () => Get.to(() => EditProfile()),
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
          ProfileButtons(
            buttonName: 'My Events',
            onPressedFunc: () {
              Get.to(() => MyEvents(
                eventList: controller.eventList.value,
              ));
            },
          ),
          // ProfileButtons(buttonName: 'My Proshows', onPressedFunc: () {}),
          ProfileButtons(
            buttonName: 'About Aaruush',
            onPressedFunc: () {
              Get.to(() => const AboutPage());
            },
          ),
          const SizedBox(height: 50),
          primaryButton(
            text: "Log out",
            onTap: () => controller.common.signOutCurrentUser(),
          ),
        ],
      ),

    );
  }
}

class ProfileButtons extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressedFunc;

  const ProfileButtons({
    Key? key,
    required this.buttonName,
    required this.onPressedFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width / 15,
        MediaQuery.of(context).size.height / 50,
        MediaQuery.of(context).size.width / 15,
        0,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: TextButton(
          onPressed: onPressedFunc,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFF504D50)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.05),
              ),
            ),
          ),
          child: Text(
            buttonName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
