import 'dart:ui';

import 'package:aarush/Data/bottomIndexData.dart';
import 'package:aarush/Model/Events/event_list_model.dart';
import 'package:aarush/Screens/Events/events_controller.dart';
import 'package:aarush/Screens/Events/register_event.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/AaruushBottomBar.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/Utilities/snackbar.dart';
import 'package:aarush/components/aaruushappbar.dart';
import 'package:aarush/components/bg_area.dart';
import 'package:aarush/components/primaryButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsScreen extends StatelessWidget {
  EventsScreen({super.key, required this.event, this.fromMyEvents = false});

  final EventListModel event;
  final bool fromMyEvents;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<EventsController>(EventsController());
    controller.eventData.value = event;
    controller.getUser().then((value) {
      controller.checkRegistered(controller.eventData.value);
    });

    debugPrint("Event id is ${event.id}");

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AaruushAppBar(
        title: "Aaruush",
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
        image: 'bg.png',
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizeBox(100, 0),
          CachedNetworkImage(
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: Get.theme.colorPrimary,
                  ),
                ),
            imageUrl: event.image!,
            fit: BoxFit.contain,
            width: Get.width,
            height: 300,
          ),
          sizeBox(10, 0),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Text(event.name!, style: Get.theme.kBigTextStyle),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Text(
              event.oneliner ?? "Nil",
              style: Get.theme.kVerySmallTextStyle,
            ),
          ),
          sizeBox(20, 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(width: Get.width,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconWithText(Icons.calendar_month, event.date ?? ''),
                  sizeBox(10, 0),
                  _iconWithText(Icons.access_time, event.time ?? ''),
                  sizeBox(10, 0),
                  GestureDetector(
                    onTap: () {
                      if (event.location != null &&
                          event.locationLat != null &&
                          event.locationLng != null) {
                        controller.openMapWithLocation(
                            event.locationLat!, event.locationLng!);
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.pin_drop,
                          color: Colors.blue,
                        ),
                        sizeBox(0, 3),
                        Text(
                          event.location ?? '',
                          style: Get.theme.kVerySmallTextStyle.copyWith(
                            fontSize: 11,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (event.timeline != null)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Html(
                data: event.timeline ?? "",
                style: {
                  "body": Style(
                    color: Colors.white,
                    fontSize: FontSize(14),
                  ),
                },
              ),
            ),
          Container(
            width: Get.width,
            margin:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 22),
            height: 5,
            decoration: BoxDecoration(
              color: Get.theme.colorPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor:
                  Get.theme.curveBG.withOpacity(0.5),
                  labelStyle: Get.theme.kVerySmallTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  physics: const BouncingScrollPhysics(),
                  indicatorColor: Colors.transparent,
                  tabs: const [
                    Tab(text: 'About'),
                    Tab(text: 'Structure'),
                    Tab(text: 'Contact'),
                  ],
                ),
                Container(
                  width: Get.width,
                  height: Get.height * 0.4,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(44, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _tabDataWidget(text: event.about ?? "Nil"),
                        _tabDataWidget(text: event.structure ?? "Nil"),
                        _tabDataWidget(text: event.contact ?? "Nil"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          sizeBox(20, 0),
          if (!fromMyEvents)
            Obx(() {
              return primaryButton(
                text: controller.isEventRegistered.value
                    ? 'Registered'
                    : 'Register now',
                onTap: () async {
                  if (event.reqdfields != null && event.reqdfields!) {
                    if (controller.isEventRegistered.value) {
                      setSnackBar(
                        "INFO:",
                        "You have already registered",
                        icon: const Icon(
                          Icons.info,
                          color: Colors.orange,
                        ),
                      );
                    } else {
                      if (controller.eventData.value.live!) {
                        Get.to(() => RegisterEvent(event: event));
                      } else {
                        setSnackBar(
                          "INFO:",
                          "Event is not live now!",
                          icon: const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red,
                          ),
                        );
                      }
                    }
                  } else {
                    if (await canLaunchUrl(Uri.parse(event.reglink.toString()))) {
                      if (controller.isEventRegistered.value) {
                        setSnackBar(
                          "INFO:",
                          "You have already registered",
                          icon: const Icon(
                            Icons.info,
                            color: Colors.orange,
                          ),
                        );
                      } else {
                        launchUrl(
                          Uri.parse(event.reglink!.toString()),
                        );
                        controller.registerEvent(e: event);
                      }
                    } else {
                      setSnackBar(
                        "ERROR:",
                        "Invalid URL",
                        icon: const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      );
                    }
                  }
                },
              );
            }),
          sizeBox(200, 0),
        ],
      ),
      // bottomNavigationBar:  AaruushBottomBar(bottomIndex: BottomIndexData.NONE),
    );
  }

  Widget _iconWithText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon),
        sizeBox(0, 10),
        Text(
          text,
          style: Get.theme.kVerySmallTextStyle.copyWith(fontSize: 11),
        ),
      ],
    );
  }
}

class _tabDataWidget extends StatelessWidget {
  const _tabDataWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      primary: false,
      child: Html(
        data: text,
        style: {
          "body": Style(
            color: Colors.white,
            fontSize: FontSize(19.5),
          ),
        },
      ),
    );
  }
}
