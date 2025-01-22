import 'package:AARUUSH_CONNECT/Certificates/CertificateView.dart';
import 'package:AARUUSH_CONNECT/Screens/About/aboutpage.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/editProfile.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/profileController.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/Utilities/correct_ellipis.dart';
import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/common_controller.dart';
import '../Home/home_controller.dart';

class ProfileScreen extends StatelessWidget {
  final dynamic showCloseButton;
  final bool isSwipingEnabled;

  ProfileScreen(
      {super.key, this.showCloseButton = false, this.isSwipingEnabled = false});

  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomeController>(HomeController());

    return GestureDetector(
      onHorizontalDragUpdate: isSwipingEnabled
          ? (details) {
              if (details.primaryDelta! > -1 &&
                  details.localPosition.dx < 100) {
                Navigator.pop(context);
              }
            }
          : null,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AaruushAppBar(
          title: "Profile",
          actions: showCloseButton
              ? [
                  IconButton.outlined(
                    padding: EdgeInsets.zero,
                    onPressed: () => {Navigator.pop(context)},
                    icon: const Icon(Icons.close_rounded),
                    color: Colors.white,
                    iconSize: 20,
                  ),
                ]
              : [],
        ),
        body: BgArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 8),
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              iconSize: Get.width * 0.15,
                              icon: Obx(
                                () =>
                                    CommonController.profileUrl.value.isNotEmpty
                                        ? CircleAvatar(
                                            radius: Get.width * 0.15,
                                            backgroundImage: NetworkImage(
                                              CommonController.profileUrl.value,
                                            ),
                                          )
                                        : SizedBox(
                                            height: Get.width * 0.3,
                                            width: Get.width * 0.3,
                                            child: ClipOval(
                                              child: Image.asset(
                                                'assets/images/profile.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              right: 4,
                              child: GestureDetector(
                                onTap: () => Get.to(() {
                                  profileController.update();
                                  return const EditProfile();
                                }),
                                child: Container(
                                  width: Get.height / 25,
                                  height: Get.height / 25,
                                  decoration: const ShapeDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.00, -1.00),
                                      end: Alignment(0, 1),
                                      colors: [
                                        Color(0xFFED6522),
                                        Color(0xFFC59123)
                                      ],
                                    ),
                                    shape: OvalBorder(),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 22,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: Get.width * 0.01),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => FittedBox(
                                child: Text(
                                  CommonController.userName.value
                                      .useCorrectEllipsis(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Get.theme.kTitleTextStyle.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: Get.width * 0.06),
                                ),
                              ),
                            ),
                            SizedBox(height: Get.width * 0.015),
                            FittedBox(
                              child: Text(
                                CommonController.emailAddress.value,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Get.theme.kVerySmallTextStyle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: Get.width * 0.035),
                              ),
                            ),
                            SizedBox(height: Get.width * 0.015),
                            FittedBox(
                              child: Text(
                                CommonController.aaruushId.value,
                                style: Get.theme.kVerySmallTextStyle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: Get.width * 0.035),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.width * 0.3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: OpenContainer(
                                  middleColor: Colors.transparent,
                                  openColor: Colors.transparent,
                                  closedColor: Colors.transparent,
                                  transitionType:
                                      ContainerTransitionType.fadeThrough,
                                  transitionDuration:
                                      const Duration(milliseconds: 400),
                                  closedBuilder: (context, action) {
                                    return ProfileButtons(
                                      buttonName: 'Certificates',
                                      leadingIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Image.asset(
                                          "assets/images/icons/certificate.png",
                                          scale: 27,
                                          color: Colors.black,
                                        ),
                                      ),
                                      trailingIcon:
                                          Icons.arrow_forward_ios_outlined,
                                      onPressedFunc: action,
                                      color: Colors.white,
                                    );
                                  },
                                  openBuilder: (context, action) =>
                                      Certificateview(),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: OpenContainer(
                                  middleColor: Colors.transparent,
                                  openColor: Colors.transparent,
                                  closedColor: Colors.transparent,
                                  transitionType:
                                      ContainerTransitionType.fadeThrough,
                                  transitionDuration:
                                      const Duration(milliseconds: 400),
                                  closedBuilder: (context, action) {
                                    return ProfileButtons(
                                      buttonName: 'About',
                                      leadingIcon: const Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.info_outline_rounded,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      ),
                                      trailingIcon:
                                          Icons.arrow_forward_ios_outlined,
                                      onPressedFunc: action,
                                      color: Colors.white,
                                    );
                                  },
                                  openBuilder: (context, action) =>
                                      const AboutPage(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          OpenContainer(
                            middleColor: Colors.transparent,
                            openColor: Colors.transparent,
                            closedColor: Colors.transparent,
                            transitionType: ContainerTransitionType.fadeThrough,
                            transitionDuration:
                                const Duration(milliseconds: 1000),
                            closedBuilder: (context, action) {
                              return ProfileButtons(
                                buttonName: "Log out",
                                onPressedFunc: () async {
                                  action();
                                  profileController.resetProfileData();
                                  await controller.common.signOutCurrentUser();
                                },
                                leadingIcon: const Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Icon(
                                    Icons.logout,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                                color: Get.theme.colorPrimary,
                              );
                            },
                            openBuilder: (context, action) => Container(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.width * 0.5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileButtons extends StatelessWidget {
  final String buttonName;
  final Widget? leadingIcon;
  final Color color;
  IconData? trailingIcon;
  final VoidCallback onPressedFunc;

  ProfileButtons({
    super.key,
    required this.buttonName,
    required this.onPressedFunc,
    this.leadingIcon,
    IconData? trailingIcon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressedFunc,
      child: Container(
        height: Get.height * 0.06,
        width: Get.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leadingIcon != null) ...[
                leadingIcon!,
              ],
              Text(
                buttonName,
                style: Get.theme.kSmallTextStyle.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: Get.width * 0.04),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
