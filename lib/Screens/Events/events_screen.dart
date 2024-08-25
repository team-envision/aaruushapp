import 'dart:ui';
import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/events_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/register_event.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/Utilities/custom_sizebox.dart';
import 'package:AARUUSH_CONNECT/Utilities/snackbar.dart';
import 'package:AARUUSH_CONNECT/components/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:AARUUSH_CONNECT/components/primaryButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({
    Key? key,
    this.event,
    this.fromMyEvents = false,
    this.fromNotificationRoute = false,
    this.EventId,
  }) : super(key: key);

  final EventListModel? event;
  final bool fromMyEvents;
  final bool fromNotificationRoute;
  final String? EventId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<EventsController>(EventsController());

    // Fetch event data if accessed from the notification route
    if (fromNotificationRoute && EventId != null) {
      print("fromRoute");
      controller.fetchEventData(EventId!);
      print("controller.eventData");
      print(controller.eventData);
    } else if (event != null) {
      // Use the passed event data
      controller.eventData.value = event!;
      controller.getUser().then((value) {
        controller.checkRegistered(controller.eventData.value);
      });
    }

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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.eventData.value == null) {
          // Display a loading indicator or an appropriate message
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final eventData = controller.eventData.value;
        return BgArea(
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
              imageUrl: eventData.image!,
              fit: BoxFit.contain,
              width: Get.width,
              height: 300,
            ),
            sizeBox(10, 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: Text(eventData.name!, style: Get.theme.kSubTitleTextStyle),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: Text(
                eventData.oneliner ?? "Nil",
                style: Get.theme.kVerySmallTextStyle,
              ),
            ),
            sizeBox(20, 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _iconWithText(Icons.calendar_month, eventData.date ?? ''),
                    sizeBox(10, 0),
                    _iconWithText(Icons.access_time, eventData.time ?? ''),
                    sizeBox(10, 0),
                    GestureDetector(
                      onTap: () {
                        if (eventData.location != null &&
                            eventData.locationLat != null &&
                            eventData.locationLng != null) {
                          controller.openMapWithLocation(
                              eventData.locationLat!, eventData.locationLng!);
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
                            eventData.location ?? '',
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
            if (eventData.timeline != null)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Html(
                  data: eventData.timeline ?? "",
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
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 22),
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
                    unselectedLabelColor: Get.theme.curveBG.withOpacity(0.5),
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
                      color: const Color.fromARGB(44, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _tabDataWidget(text: eventData.about ?? "Nil"),
                          _tabDataWidget(text: eventData.structure ?? "Nil"),
                          _tabDataWidget(text: eventData.contact ?? "Nil"),
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
                    if (eventData.reqdfields != null && eventData.reqdfields!) {
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
                        if (eventData.live!) {
                          Get.to(() => RegisterEvent(event: eventData));
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
                      if (await canLaunchUrl(Uri.parse(eventData.reglink.toString()))) {
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
                          launchUrl(Uri.parse(eventData.reglink!.toString()));
                          controller.registerEvent(e: eventData);
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
                  isDisabled: !eventData.live!,
                );
              }),
            sizeBox(200, 0),
          ],
        );
      }),
      // bottomNavigationBar: AaruushBottomBar(bottomIndex: BottomIndexData.NONE),
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
    Key? key,
    required this.text,
  }) : super(key: key);

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

