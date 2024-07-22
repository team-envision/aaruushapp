import 'dart:ui';

import 'package:aarush/Data/api_data.dart';
import 'package:aarush/Data/bottomIndexData.dart';
import 'package:aarush/Model/Events/event_list_model.dart';
import 'package:aarush/Screens/About/aboutpage.dart';

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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Events/events_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

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
        actions: [
          IconButton(
            onPressed: () => {Get.to(() => AboutPage())},
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
      body:  BgArea(
        crossAxisAlignment: CrossAxisAlignment.start,
        image: "bg2.png",
        children: [
          sizeBox(120, 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Obx(
                  () => Text(
                "Hi, ${controller.common.userName.value}".useCorrectEllipsis(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Get.theme.kTitleTextStyle,
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
      bottomNavigationBar: const AaruushBottomBar(bottomIndex: BottomIndexData.HOME),
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
              imageUrl: event.image ?? 'https://imgs.search.brave.com/IexF9m6HTHhdVbZbd7ZaacA6S3QJOvPTfRLibNcISCA/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9uZXRu/dXQuaW8vd3AtY29u/dGVudC9wbHVnaW5z/L3BoYXN0cHJlc3Mv/cGhhc3QucGhwL2My/VnlkbWxqWlQxcGJX/Rm5aWE1tYzNKalBX/aDBkSEJ6SlQvTkJK/VEpHSlRKR2JtVjBi/blYwTG1sdkpUSkdk/M0F0WTI5dWRHVnVk/Q1V5Um5Wd2JHOWha/SE1sTWtZeU1ESXpK/VEpHTURVbE1rWkli/M2N0ZEc4dFUyOXNk/bVV0VUhKdmVIa3RS/WEp5YjNJdFEyOWta/WE10SlRJMVJUSWxN/alU0TUNVeU5Ua3pM/VlJvWlMxVmJIUnBi/V0YwWlMxSGRXbGta/UzB0TVRBeU5IZ3hN/REkwTG5CdVp5WmpZ/V05vWlUxaGNtdGxj/ajB4TnpJd016VXlN/ekF5TFRZNE5UUXlK/blJ2YTJWdVBUbGtZ/akprWlRCbE5HUmhZ/VEUxWVdFLnEucG5n', // Use empty string or placeholder if image is null
              fit: BoxFit.cover,
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
