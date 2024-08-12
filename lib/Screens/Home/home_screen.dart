import 'dart:ui';

import 'package:aarush/Data/api_data.dart';
import 'package:aarush/Data/bottomIndexData.dart';
import 'package:aarush/Model/Events/event_list_model.dart';
import 'package:aarush/Screens/About/aboutpage.dart';

import 'package:aarush/Screens/Home/home_controller.dart';
import 'package:aarush/Screens/Profile/profilepage.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/appBarBlur.dart';
import 'package:aarush/Utilities/AaruushBottomBar.dart';
import 'package:aarush/Utilities/capitalize.dart';
import 'package:aarush/Utilities/correct_ellipis.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/Utilities/removeBracketsIfExist.dart';
import 'package:aarush/components/bg_area.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../components/aaruushappbar.dart';
import '../Events/events_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    RxString userName = (toRemoveTextInBracketsIfExists(controller.common.userName.value).toString()).obs;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AaruushAppBar(

        actions: [
          IconButton(
            onPressed: () => {Get.to(() => AboutPage())},
            icon: const Icon(Icons.info_outlined),
            color: Colors.white,
            iconSize: 25,
          ),
        ],
        title:
          "AARUUSH",
      ),
      body:  BgArea(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          sizeBox(120, 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FittedBox(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                        () => Text(
                      "Hi, ${userName.value}".useCorrectEllipsis(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Get.theme.kSubTitleTextStyle,
                    ),
                  ),
              
                  IconButton(
                    onPressed: () => {Get.to(() => ProfileScreen())},
                    icon: Obx(
                          () => controller.common.profileUrl.value.isNotEmpty
                          ? CircleAvatar(
                        backgroundImage: NetworkImage(controller.common.profileUrl.value),
                      )
                          : Image.asset(
                        'assets/images/profile.png',
                        height: 30,
                      ),
                    ),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                ],
              ),
            ),
          ),
          sizeBox(50, 0),
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
            child: Row(
              children: [
                categoryButton(
                  iconData: Icons.all_inclusive_rounded,
                  name: "All",
                  onTap: () => controller.setSortCategory("All"),
                ),
                ...controller.catList.map((e) {
                  return categoryButton(
                    icon: "${ApiData.CDN_URL}/icons/categories/${e.toLowerCase().split(' ').join('-')}.png",
                    name: e.toLowerCase().split('-').join(' ').toCapitalized(),
                    onTap: () => controller.setSortCategory(e),
                  );
                }).toList(),
              ],
            ),
          ),
          sizeBox(50, 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
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
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                primary: false,
                child: Row(
                  children: controller.eventList
                      .where((e) => e.live! && (controller.sortName.value == "All" || controller.sortName.value == e.sortCategory))
                      .map((e) {
                    return eventCard(e, () => Get.to(() => EventsScreen(event: e)));
                  }).toList(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Text(
              "Past Events",
              style: Get.theme.kTitleTextStyle,
            ),
          ),
          Obx(
                () {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                primary: false,
                child: Row(
                  children: controller.eventList.where((e) => !e.live!).map((e) {
                    return eventCard(e, () => Get.to(() => EventsScreen(event: e)));
                  }).toList(),
                ),
              );
            },
          ),
          sizeBox(100, 0),
        ],
      ),
      // bottomNavigationBar: AaruushBottomBar(),
      // bottomNavigationBar:  AaruushBottomBar(bottomIndex: BottomIndexData.HOME),
    );
  }

  Widget categoryButton({String? icon, IconData? iconData, required String name, VoidCallback? onTap}) {
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
                    color: const Color.fromARGB(255, 214, 129, 1),
                    size: 30,
                  );
                },
              )
                  : Icon(
                iconData,
                color: const Color.fromARGB(255, 214, 129, 1),
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

  Widget eventCard(EventListModel event, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 250,
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            onTap: onTap,
            child: CachedNetworkImage(
              progressIndicatorBuilder: (ctx, url, progress) => CircularProgressIndicator(
                value: progress.progress,
                color: Get.theme.colorPrimary,
              ),
              imageUrl: event.image!,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) => Image.asset("assets/images/error404.png"),
              width: 400,
              height: 250,
            ),
          ),
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              backgroundColor: Get.theme.curveBG.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              fixedSize: const Size.fromWidth(130),
            ),
            child: Text(
              event.live ?? false ? "Register Now" : "View Event", // Default to false if live status is null
              style: Get.theme.kVerySmallTextStyle,
            ),
          ),
        ],
      ),
    );
  }

}
