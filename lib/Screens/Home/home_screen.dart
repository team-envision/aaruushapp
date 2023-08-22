// ignore_for_file: invalid_use_of_protected_member

import 'dart:ui';

import 'package:aarush/Data/api_data.dart';
import 'package:aarush/Data/bottomIndexData.dart';
import 'package:aarush/Model/Events/event_list_model.dart';
import 'package:aarush/Screens/About/aboutpage.dart';
import 'package:aarush/Screens/Events/events_screen.dart';
import 'package:aarush/Screens/Home/home_controller.dart';
import 'package:aarush/Screens/Profile/profilepage.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/appBarBlur.dart';
import 'package:aarush/Utilities/bottombar.dart';
import 'package:aarush/Utilities/capitalize.dart';
import 'package:aarush/Utilities/correct_ellipis.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/components/bg_area.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomeController>(HomeController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        flexibleSpace: appBarBlur(),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => {Get.to(() => ProfileScreen())},
          icon: Obx(
            () => controller.common.profileUrl.value != null &&
                    controller.common.profileUrl.value.isNotEmpty
                ? CircleAvatar(
                    backgroundImage:
                        NetworkImage(controller.common.profileUrl.value),
                  )
                : Image.asset(
                    'assets/images/profile.png',
                    height: 30,
                  ),
          ),
          color: Colors.white,
          iconSize: 40,
        ),
        actions: [
          IconButton(
            onPressed: () => {Get.to(const AboutPage())},
            icon: const Icon(Icons.info_outlined),
            color: Colors.white,
            iconSize: 25,
          ),
        ],
        title: Text(
          "AARUUSH",
          style: Get.theme.kTitleTextStyle.copyWith(fontFamily: 'Xirod'),
        ),
      ),
      body: BgArea(
          crossAxisAlignment: CrossAxisAlignment.start,
          image: "bg2.png",
          children: [
            sizeBox(120, 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => Text(
                  "Hi, ${controller.common.userName.value}"
                      .useCorrectEllipsis(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Get.theme.kTitleTextStyle,
                ),
              ),
            ),
            sizeBox(50, 0),
            FutureBuilder(
                future: controller.fetchEventData(),
                builder: (ctx, AsyncSnapshot<List<EventListModel>> snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    final catList =
                        data!.map((e) => e.sortCategory).toSet().toList();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Categories",
                            style: Get.theme.kTitleTextStyle,
                          ),
                        ),
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          child: Row(children: [
                            categoryButton(
                              iconData: Icons.all_inclusive_rounded,
                              name: "All",
                              onTap: () => controller.setSortCategory("All"),
                            ),
                            ...catList.map((e) {
                              return categoryButton(
                                icon:
                                    "${ApiData.CDN_URL}/icons/categories/${e?.toLowerCase().split(' ').join('-')}.png",
                                name: e!
                                    .toLowerCase()
                                    .split('-')
                                    .join(' ')
                                    .toCapitalized(),
                                onTap: () => controller.setSortCategory(e),
                              );
                            })
                          ]),
                        ),
                        sizeBox(50, 0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          child: Obx(
                            () => Text(
                              "${controller.sortName.value.toLowerCase().split('-').join(' ').toCapitalized()} Live Events",
                              style: Get.theme.kTitleTextStyle,
                            ),
                          ),
                        ),
                        sizeBox(20, 0),
                        SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            primary: false,
                            child: Obx(
                              () => Row(
                                children: [
                                  ...snapshot.data!.map((e) {
                                    return e.live! &&
                                            (controller.sortName.value ==
                                                    "All" ||
                                                controller.sortName.value ==
                                                    e.sortCategory)
                                        ? Container(
                                            padding: const EdgeInsets.all(16.0),
                                            height: 250,
                                            width: 250,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.white),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                            ),
                                            child: Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(() => EventsScreen(
                                                          event: e,
                                                        ));
                                                  },
                                                  child: CachedNetworkImage(
                                                    progressIndicatorBuilder: (ctx,
                                                            url, progress) =>
                                                        CircularProgressIndicator(
                                                      value: progress.progress,
                                                      color: Get
                                                          .theme.colorPrimary,
                                                    ),
                                                    imageUrl: e.image!,
                                                    fit: BoxFit.cover,
                                                    width: 400,
                                                    height: 250,
                                                  ),
                                                ),
                                                TextButton(

                                                    //   onPressed: (){launchlink();
                                                    // print(eventList[itemIndex]['id']);},
                                                    onPressed: () {
                                                      Get.to(() => EventsScreen(
                                                            event: e,
                                                          ));
                                                    },
                                                    style: TextButton.styleFrom(
                                                        backgroundColor: Get
                                                            .theme.curveBG
                                                            .withOpacity(0.7),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        fixedSize: const Size
                                                            .fromWidth(130)),
                                                    child: Text(
                                                      "Register Now",
                                                      style: Get.theme
                                                          .kVerySmallTextStyle,
                                                    )),
                                              ],
                                            ),
                                          )
                                        : sizeBox(0, 0);
                                  })
                                ],
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          child: Text(
                            "Past Events",
                            style: Get.theme.kTitleTextStyle,
                          ),
                        ),
                        sizeBox(20, 0),
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          child: Row(
                            children: [
                              ...snapshot.data!.map((e) {
                                return !e.live!
                                    ? Container(
                                        padding: const EdgeInsets.all(16.0),
                                        height: 250,
                                        width: 250,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2, color: Colors.white),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(() => EventsScreen(
                                                      event: e,
                                                    ));
                                              },
                                              child: CachedNetworkImage(
                                                progressIndicatorBuilder: (ctx,
                                                        url, progress) =>
                                                    CircularProgressIndicator(
                                                  value: progress.progress,
                                                  color: Get.theme.colorPrimary,
                                                ),
                                                imageUrl: e.image!,
                                                fit: BoxFit.cover,
                                                width: 400,
                                                height: 250,
                                              ),
                                            ),
                                            TextButton(

                                                //   onPressed: (){launchlink();
                                                // print(eventList[itemIndex]['id']);},
                                                onPressed: () {
                                                  Get.to(() => EventsScreen(
                                                        event: e,
                                                      ));
                                                },
                                                style: TextButton.styleFrom(
                                                    backgroundColor: Get
                                                        .theme.curveBG
                                                        .withOpacity(0.7),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    fixedSize:
                                                        const Size.fromWidth(
                                                            130)),
                                                child: Text(
                                                  "View Event",
                                                  style: Get.theme
                                                      .kVerySmallTextStyle,
                                                )),
                                          ],
                                        ),
                                      )
                                    : sizeBox(0, 0);
                              })
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    debugPrint("Err ${snapshot.error}");
                    return Center(
                        child: Text(
                      "Something went wrong 🤧",
                      style: Get.theme.kSmallTextStyle,
                    ));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            sizeBox(100, 0),
          ]),
      bottomNavigationBar: const AaruushBottomBar(
        bottomIndex: BottomIndexData.HOME,
      ),
    );
  }
}

Widget categoryButton({
  String? icon,
  IconData? iconData,
  required String name,
  VoidCallback? onTap,
}) {
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
                          // Handle image loading error by showing default icon
                          return Icon(
                            iconData ?? Icons.category_rounded,
                            color: const Color.fromARGB(255, 214, 129, 1),
                            size: 30,
                          );
                        },
                      )
                    : Icon(
                        iconData,
                        color: const Color.fromARGB(255, 214, 129, 1),
                        size: 30,
                      )),
            sizeBox(10, 0),
            Text(
              name,
              style: Get.theme.kVerySmallTextStyle,
            )
          ],
        ),
      ));
}
