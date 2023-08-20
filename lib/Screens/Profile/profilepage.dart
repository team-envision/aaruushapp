import 'package:aarush/Data/bottomIndexData.dart';
import 'package:aarush/Screens/Profile/editProfile.dart';
import 'package:aarush/Screens/Tickets/myEvents.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/correct_ellipis.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/components/aaruushappbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utilities/appBarBlur.dart';
import '../../Utilities/bottombar.dart';
import '../Home/home_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomeController>(HomeController());
    return SafeArea(
      child: Scaffold(
        appBar: AaruushAppBar(
          title: "Profile",
          actions: [
            IconButton(
              onPressed: () => {Get.back()},
              icon: const Icon(Icons.close_rounded),
              color: Colors.white,
              iconSize: 25,
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        iconSize: MediaQuery.of(context).size.height / 6,
                        icon:
                            Obx(() => controller.common.profileUrl.value != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        controller.common.profileUrl.value!),
                                  )
                                : Image.asset(
                                    'assets/images/profile.png',
                                    fit: BoxFit.fill,
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                  )),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 10,
                        child: GestureDetector(
                          onTap: () => Get.to(const EditProfile()),
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
                  sizeBox(20, 0),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width *
                          0.5, // Adjust this value as needed
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            controller.common.userName.value
                                .useCorrectEllipsis(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Get.theme.kTitleTextStyle,
                          ),
                        ),
                        sizeBox(10, 0),
                        Text(controller.common.emailAddress.value,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Get.theme.kVerySmallTextStyle),
                        Text(controller.common.aaruushId.value,
                            style: Get.theme.kVerySmallTextStyle),
                      ],
                    ),
                  ),
                ],
              ),
              sizeBox(100, 0),
              ProfileButtons(
                  ButtonName: 'My Events',
                  onPressedFunc: () {
                    Get.to(() => MyEvents(
                          eventList: controller.eventList.value,
                        ));
                  }),
              // ProfileButtons(ButtonName: 'My Proshows', onPressedFunc: () {}),
              ProfileButtons(
                  ButtonName: 'About Aaruush',
                  onPressedFunc: () async {
                    // Launch URL
                    final url = Uri.parse("https://aaruush.org/about");
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url,
                          mode: LaunchMode.externalApplication);
                    }
                  }),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 8,
                    MediaQuery.of(context).size.height / 15,
                    MediaQuery.of(context).size.width / 8,
                    15),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {controller.common.signOutCurrentUser();},
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFFFF723D)),
                      ),
                      child: const Text('Log Out',
                          style: TextStyle(color: Colors.white, fontSize: 25))),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: const AaruushBottomBar(
          bottomIndex: BottomIndexData.PROFILE,
        ),
      ),
    );
  }
}

class ProfileButtons extends StatelessWidget {
  final String ButtonName;
  final VoidCallback onPressedFunc;
  const ProfileButtons(
      {super.key, required this.ButtonName, required this.onPressedFunc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width / 15,
          MediaQuery.of(context).size.height / 50,
          MediaQuery.of(context).size.width / 15,
          0),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: TextButton(
          onPressed: onPressedFunc,
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Color(0xFF504D50)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.05))),
          ),
          child: Text(
            ButtonName,
            style: const TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
