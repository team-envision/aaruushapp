import 'dart:io';
import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Common/core/Routes/app_routes.dart';
import 'package:AARUUSH_CONNECT/Data/api_data.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/views/events_screen.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/controllers/home_controller.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/Utilities/capitalize.dart';
import 'package:AARUUSH_CONNECT/Utilities/correct_ellipis.dart';
import 'package:AARUUSH_CONNECT/Utilities/custom_sizebox.dart';
import 'package:AARUUSH_CONNECT/Utilities/removeBracketsIfExist.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';
import '../../../Utilities/aaruushappbar.dart';
import '../../../components/carouselSliderAutoplay.dart';
import '../../../components/eventCard.dart';
import '../../../components/searchTextField.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      showLater: false,
      showIgnore: false,
      shouldPopScope: () => false,
      barrierDismissible: false,
      showReleaseNotes: false,
      dialogStyle: Platform.isAndroid
          ? UpgradeDialogStyle.material
          : UpgradeDialogStyle.cupertino,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        // extendBody: true,
        appBar: AaruushAppBar(
          actions: [
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.notificationScreen),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.about),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.info_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            )
          ],
          title: "AARUUSH",
        ),
        body: BgArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 7.5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.profileScreen);
                        },
                        child: Obx(
                          () => CommonController.profileUrl.value.isNotEmpty
                              ? CircleAvatar(
                                  radius: 22,
                                  backgroundImage: NetworkImage(
                                      CommonController.profileUrl.value),
                                )
                              : Image.asset(
                                  'assets/images/profile.png',
                                  height: 30,
                                ),
                        ),
                      ),
                      sizeBox(0, 9),
                      Obx(() => FittedBox(
                            child: Text(
                              "Hi, ${toRemoveTextInBracketsIfExists(CommonController.userName.toString())}"
                                  .useCorrectEllipsis(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Get.theme.kTitleTextStyle.copyWith(
                                  fontSize: 19, fontWeight: FontWeight.w700),
                            ),
                          )),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.certificateView),
                        child: Image.asset(
                          "assets/images/icons/certificate.png",
                          scale: 24,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: searchTextField(context: context),
                ),
                sizeBox(20, 0),
                Autoplay(),
                sizeBox(20, 0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Categories",
                    style: Get.theme.kTitleTextStyle1.copyWith(fontSize: 28),
                  ),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  child: Row(
                    children: [
                      categoryButton(
                        iconData: Icons.all_inclusive_rounded,
                        name: "All",
                        onTap: () => homeController.setSortCategory("All"),
                      ),
                      ...homeController.state.catList.map((e) {
                        if (e != "events") {
                          return categoryButton(
                            icon:
                                "${ApiData.CDN_URL}/icons/categories/${e.toLowerCase().split(' ').join('-')}.png",
                            name: e
                                .toLowerCase()
                                .split('-')
                                .join(' ')
                                .toCapitalized(),
                            onTap: () => homeController.setSortCategory(e),
                          );
                        } else {
                          return categoryButton(
                            iconData: Icons.category_rounded,
                            name: e
                                .toLowerCase()
                                .split('-')
                                .join(' ')
                                .toCapitalized(),
                            onTap: () => homeController.setSortCategory(e),
                          );
                        }
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 40),
                  child: Obx(
                    () => Text(
                      "${homeController.state.sortName.value.toLowerCase().split('-').join(' ').toCapitalized()} Live Events",
                      style: Get.theme.kTitleTextStyle1.copyWith(fontSize: 28),
                    ),
                  ),
                ),
                Obx(
                  () {
                    if (homeController.state.isLoading.value) {
                      return Center(
                        child: Container(
                            color: Colors.black,
                            child: Image.asset('assets/images/spinner.gif',
                                scale: 4)),
                      );
                    }

                    return homeController.state.LiveEventsList.isNotEmpty
                        ? SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            primary: false,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 8),
                              child: Row(
                                children: homeController.state.eventList
                                    .where((e) =>
                                        e.live! &&
                                        (homeController.state.sortName.value ==
                                                "All" ||
                                            homeController
                                                    .state.sortName.value ==
                                                e.sortCategory))
                                    .map((event) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: OpenContainer(
                                      middleColor: Colors.transparent,
                                      openColor: Colors.transparent,
                                      closedColor: Colors.transparent,
                                      closedShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      transitionDuration:
                                          const Duration(milliseconds: 400),
                                      transitionType:
                                          ContainerTransitionType.fadeThrough,
                                      closedBuilder: (context, action) =>
                                          eventCard(
                                        event,
                                        action,
                                        homeController,
                                      ),
                                      openBuilder: (context, action) =>
                                          EventsScreen(
                                        event: event,
                                        fromMyEvents: false.obs,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                "Currently No Live Events",
                                style: TextStyle(letterSpacing: 4),
                              ),
                            ),
                          );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 40),
                  child: Text(
                    "Past Events",
                    style: Get.theme.kTitleTextStyle1.copyWith(fontSize: 28),
                  ),
                ),
                Obx(
                  () {
                    if (homeController.state.isLoading.value) {
                      return Center(
                        child: Container(
                            color: Colors.black,
                            child: Image.asset('assets/images/spinner.gif',
                                scale: 4)),
                      );
                    }
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 8),
                        child: Row(
                          children: homeController.state.eventList
                              .where((e) =>
                                  !e.live! &&
                                  e.startdate != null &&
                                  e.edition == 'a24')
                              .map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: OpenContainer(
                                middleColor: Colors.transparent,
                                openColor: Colors.transparent,
                                closedColor: Colors.transparent,
                                closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                transitionDuration:
                                    const Duration(milliseconds: 400),
                                transitionType:
                                    ContainerTransitionType.fadeThrough,
                                openBuilder: (context, _) => EventsScreen(
                                  event: e,
                                  fromMyEvents: false.obs,
                                ),
                                closedBuilder: (context, openContainer) =>
                                    eventCard(
                                  e,
                                  openContainer,
                                  homeController,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 40),
                  child: Text(
                    "For you",
                    style: Get.theme.kTitleTextStyle1.copyWith(fontSize: 28),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            homeController.getToURL(
                                URL: "https://cap.aaruush.org/");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Get.theme.colorPrimary,
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Discover\nCAP Portal",
                                  style: Get.theme.kSmallTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Perks:\nLOR & Certificates",
                                  style: Get.theme.kVerySmallTextStyle.copyWith(
                                      color: Colors.white, fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            homeController.getToURL(
                                URL: "https://www.aaruush.org/about");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Get.theme.colorPrimary,
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Explore\nAARUUSH",
                                  style: Get.theme.kSmallTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "...rising in the spirit\nof the innovation",
                                  style: Get.theme.kVerySmallTextStyle.copyWith(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                sizeBox(144, 0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryButton(
      {String? icon,
      IconData? iconData,
      required String name,
      VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Get.theme.curveBG,
              child: icon != null && icon.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: icon,
                      height: 30,
                      errorWidget: (context, url, error) {
                        return Icon(
                          iconData ?? Icons.category_rounded,
                          color: const Color.fromRGBO(239, 101, 34, 1),
                          size: 30,
                        );
                      },
                    )
                  : Icon(
                      iconData,
                      color: const Color.fromRGBO(239, 101, 34, 1),
                      size: 30,
                    ),
            ),
            sizeBox(10, 0),
            Text(
              name,
              style: Get.theme.kVerySmallTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
