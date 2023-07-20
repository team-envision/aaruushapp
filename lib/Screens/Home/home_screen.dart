// ignore_for_file: invalid_use_of_protected_member

import 'package:aarush/Data/bottomIndexData.dart';
import 'package:aarush/Model/Events/event_list_model.dart';
import 'package:aarush/Screens/Events/events_screen.dart';
import 'package:aarush/Screens/Home/home_controller.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/bottombar.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/components/bg_area.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomeController>(HomeController());
    // controller.common.signOutCurrentUser();
    controller.loadAttributes();
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => {},
          icon: Obx(
            () => controller.userAttributes.value['image'] != null
                ? CircleAvatar(
                    backgroundImage:
                        NetworkImage(controller.userAttributes.value['image']!),
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
            onPressed: () => {},
            icon: SvgPicture.asset('assets/images/icons/bell.svg'),
            color: Colors.white,
            iconSize: 25,
          ),
        ],
        title: Text(
          "AARUUSH",
          style: Get.theme.kTitleTextStyle.copyWith(fontFamily: 'Xirod'),
        ),
      ),
      body: BgArea(image: "bg2.png", children: [
        sizeBox(120, 0),
        FutureBuilder(
            future: controller.fetchEventData(),
            builder: (ctx, AsyncSnapshot<List<EventListModel>> snapshot) {
              if (snapshot.hasData) {
                return CarouselSlider(
                  items: [
                    ...snapshot.data!.map((e) {
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        height: 250,
                        width: 400,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
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
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loading.gif',
                                image: e.image!,
                                placeholderScale: 0.1,
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
                                    backgroundColor:
                                        Get.theme.curveBG.withOpacity(0.7),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    fixedSize: Size.fromWidth(130)),
                                child: Text(
                                  "Register Now",
                                  style: Get.theme.kVerySmallTextStyle,
                                )),
                          ],
                        ),
                      );
                    })
                  ],
                  options: CarouselOptions(
                      autoPlay: true,
                      scrollPhysics: const BouncingScrollPhysics(),
                      enlargeCenterPage: true,
                      height: 250,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      enlargeFactor: 0.2,
                      viewportFraction: 0.6,
                      aspectRatio: 1.3),
                );
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Something went wrong 🤧",
                  style: Get.theme.kSmallTextStyle,
                ));
              } else
                return const Center(child: CircularProgressIndicator());
            }),
      ]),
      bottomNavigationBar: const AaruushBottomBar(
        bottomIndex: BottomIndexData.HOME,
      ),
    );
  }
}
