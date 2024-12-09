import 'dart:io';
import 'package:AARUUSH_CONNECT/Certificates/CertificateView.dart';
import 'package:AARUUSH_CONNECT/Data/api_data.dart';
import 'package:AARUUSH_CONNECT/Screens/About/aboutpage.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/home_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Notification/NotificationScreen.dart';
import 'package:AARUUSH_CONNECT/Screens/Profile/profilepage.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/Utilities/capitalize.dart';
import 'package:AARUUSH_CONNECT/Utilities/correct_ellipis.dart';
import 'package:AARUUSH_CONNECT/Utilities/custom_sizebox.dart';
import 'package:AARUUSH_CONNECT/Utilities/removeBracketsIfExist.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:upgrader/upgrader.dart';
import '../../Utilities/aaruushappbar.dart';
import '../../components/carouselSliderAutoplay.dart';
import '../../components/eventCard.dart';
import '../../components/searchTextField.dart';
import '../Events/events_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

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
        extendBody: true,
        appBar: AaruushAppBar(
          actions: [
            IconButton(
              onPressed: () => {Get.to(() =>  NotificationScreen())},
              icon: const Icon(Icons.notifications),
              color: Colors.white,
              iconSize: 25,
            ),
            IconButton(
              onPressed: () => {Get.to(() => const AboutPage())},
              icon: const Icon(Icons.info_outlined),
              color: Colors.white,
              iconSize: 25,
            ),
          ],
          title: "AARUUSH",
        ),
        body: BgArea(

          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizeBox(100, 0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        onPressed: () => {Get.to(() => const ProfileScreen())},
                        icon: Obx(
                              () => controller.common.profileUrl.value.isNotEmpty
                              ? CircleAvatar(
                            backgroundImage: NetworkImage(
                                controller.common.profileUrl.value),
                          )
                              : Image.asset(
                            'assets/images/profile.png',
                            height: 30,
                          ),
                        ),
                        color: Colors.white,
                        iconSize: 40,
                      ),
                      Obx(() => FittedBox(
                        child: Text(
                          "Hi, ${toRemoveTextInBracketsIfExists(controller.common.userName.toString())}"
                              .useCorrectEllipsis(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style:
                          Get.theme.kSmallTextStyle.copyWith(fontSize: 18),
                        ),
                      )),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Get.to(() => Certificateview());
                          },
                          icon: Image.asset("assets/images/icons/certificates.png"))
                    ],
                  ),
                ),
                searchTextField(context: context),
                sizeBox(20, 0),
                Autoplay(),
                sizeBox(30, 0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Categories",
                    style: Get.theme.kTitleTextStyle1,
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
                        onTap: () => controller.setSortCategory("All"),
                      ),
                      ...controller.catList.map((e) {
                        if (e != "events") {
                          return categoryButton(
                            icon:
                            "${ApiData.CDN_URL}/icons/categories/${e.toLowerCase().split(' ').join('-')}.png",
                            name: e
                                .toLowerCase()
                                .split('-')
                                .join(' ')
                                .toCapitalized(),
                            onTap: () => controller.setSortCategory(e),
                          );
                        } else {
                          return categoryButton(
                            iconData: Icons.category_rounded,
                            name: e
                                .toLowerCase()
                                .split('-')
                                .join(' ')
                                .toCapitalized(),
                            onTap: () => controller.setSortCategory(e),
                          );
                        }
                      }),
                    ],
                  ),
                ),
                sizeBox(15, 0),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                  child: Obx(
                        () => Text(
                      "${controller.sortName.value.toLowerCase().split('-').join(' ').toCapitalized()} Live Events",
                      style: Get.theme.kTitleTextStyle,
                    ),
                  ),
                ),
                Obx(
                      () {
                    if (controller.isLoading.value) {
                      return const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(239, 101, 34, 1),
                          ));
                    }
            
                    return controller.LiveEventsList.isNotEmpty
                        ? SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        primary: false,
                        child: Row(
                          children: controller.eventList
                              .where((e) =>
                          e.live! &&
                              (controller.sortName.value == "All" ||
                                  controller.sortName.value ==
                                      e.sortCategory))
                              .map((event) {
                            return eventCard(
                                event,
                                    () => Get.to(() => EventsScreen(
                                  event: event,
                                  fromMyEvents: false.obs,
                                )),
                                controller);
                          }).toList(),
                        ))
                        : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Currently No Live Events",
                          style: TextStyle(letterSpacing: 4),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                  child: Text(
                    "Past Events",
                    style: Get.theme.kTitleTextStyle,
                  ),
                ),
                Obx(
                      () {
                    if (controller.isLoading.value) {
                      return const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(239, 101, 34, 1),
                          ));
                    }
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      child: Row(
                        children: controller.eventList
                            .where((e) => !e.live! && e.startdate != null
                            ? (e.startdate!
                            .contains(DateTime.now().year.toString())
                            ? true
                            : false)
                            : false)
                            .map((e) {
                          return eventCard(
                              e,
                                  () => Get.to(() => EventsScreen(
                                event: e,
                                fromMyEvents: false.obs,
                              )),
                              controller);
                        }).toList(),
                      ),
                    );
                  },
                ),
                sizeBox(50, 0),
                Text(
                  "For you",
                  style: Get.theme.kTitleTextStyle1,
                ),
                sizeBox(14, 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.getToURL(URL: "https://cap.aaruush.org/");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Get.theme.colorPrimary,
                        ),
                        padding: const EdgeInsets.all(10),
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Discover\nCAP Portal",
                              style: Get.theme.kSmallTextStyle.copyWith(
                                  fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Perks:\nLOR & Certificates",
                                  style: Get.theme.kVerySmallTextStyle
                                      .copyWith(color: Colors.white),
                                ),
                                const Icon(Icons.arrow_forward),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.getToURL(URL: "https://www.aaruush.org/about");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Get.theme.colorPrimary,
                        ),
                        padding: const EdgeInsets.all(10),
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Explore\nAARUUSH",
                              style: Get.theme.kSmallTextStyle.copyWith(
                                  fontWeight: FontWeight.w900, color: Colors.white),
                            ),
                            Row(
                              children: [
                                Text(
                                  "...rising in the spirit\nof the innovation",
                                  style: Get.theme.kVerySmallTextStyle
                                      .copyWith(color: Colors.white),
                                ),
                                const Icon(Icons.arrow_forward),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
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
                        print(error);
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
