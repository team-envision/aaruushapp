import 'dart:ui';
import 'package:AARUUSH_CONNECT/Common/core/Routes/app_routes.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/eventScreen/controllers/events_controller.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/Utilities/custom_sizebox.dart';
import 'package:AARUUSH_CONNECT/Utilities/snackbar.dart';
import 'package:AARUUSH_CONNECT/components/MapScreen.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:AARUUSH_CONNECT/components/ticketButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsScreen extends StatelessWidget {
  EventsScreen({
    super.key,
  });

  final controller = Get.find<EventsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SizedBox(
            height: 35,
            width: 35,
            child: IconButton.outlined(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      Color.fromRGBO(255, 255, 255, 0.04)),
                  shape: WidgetStatePropertyAll(
                      CircleBorder(side: BorderSide(color: Colors.white)))),
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.of(Get.context!).pop(),
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              iconSize: 20,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.state.isLoading.value) {
          return Center(
            child: Container(
                height: Get.height,
                width: Get.width,
                color: Colors.black,
                child: Image.asset('assets/images/spinner.gif', scale: 4)),
          );
        }

        return BgArea(
          image: 'bg.png',
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min,
              children: [
                sizeBox(100, 0),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min,
                    children: [
                      if (controller.state.eventData.value?.image != null)
                        ImageColoredShadow(
                            link: controller.state.eventData.value!.image!),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 5),
                        child: Text(
                            controller.state.eventData.value?.name
                                    .toString()
                                    .trim() ??
                                "",
                            style: Get.theme.kSubTitleTextStyle
                                .copyWith(fontSize: 28)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 5),
                        child: Wrap(
                          spacing: 10,
                          children: [
                            const Icon(
                              Icons.date_range,
                              size: 25,
                            ),
                            Text(controller.state.eventData.value?.date ?? "",
                                style: Get.theme.kVerySmallTextStyle.copyWith(
                                    fontSize: 18,
                                    color: const Color(0xFFEF6522))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 5),
                        child: Wrap(
                          spacing: 10,
                          children: [
                            const Icon(
                              Icons.access_time_outlined,
                              size: 25,
                            ),
                            Text(controller.state.eventData.value?.time ?? "",
                                style: Get.theme.kVerySmallTextStyle.copyWith(
                                    fontSize: 18,
                                    color: const Color(0xFFEF6522))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 5),
                        child: Wrap(
                          spacing: 10,
                          children: [
                            controller.state.eventData.value?.mode == "offline"
                                ? SizedBox(
                                    height: 21,
                                    width: 21,
                                    child: Image.asset(
                                      "assets/images/icons/offline.png",
                                      scale: 3.9,
                                      color: Colors.white,
                                    ))
                                : Image.asset("assets/images/icons/online.png",
                                    scale: 3.9, color: Colors.white),
                            Text(
                                controller.state.eventData.value?.mode
                                        .toString()
                                        .capitalizeFirst ??
                                    "",
                                style: Get.theme.kVerySmallTextStyle.copyWith(
                                    fontSize: 18,
                                    color: const Color(0xFFEF6522))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 5),
                        child: Wrap(
                          spacing: 10,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 25,
                            ),
                            FittedBox(
                              child: Text(
                                  controller.state.eventData.value?.location ??
                                      "",
                                  style: Get.theme.kVerySmallTextStyle.copyWith(
                                      fontSize: 18,
                                      color: const Color(0xFFEF6522))),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 25),
                  child: Text(
                    controller.state.eventData.value?.oneliner ?? "Nil",
                    style: Get.theme.kVerySmallTextStyle,
                  ),
                ),
                if (controller.state.eventData.value?.timeline != null)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Html(
                      data: controller.state.eventData.value?.timeline ?? "",
                      style: {
                        "body": Style(
                          color: Colors.white,
                          fontSize: FontSize(14),
                        ),
                      },
                    ),
                  ),
                DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Colors.white,
                        indicatorPadding: const EdgeInsets.all(12),
                        padding: const EdgeInsets.all(12),
                        labelPadding: const EdgeInsets.all(12),
                        unselectedLabelColor: Colors.white60,
                        labelStyle: Get.theme.kVerySmallTextStyle.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        physics: const BouncingScrollPhysics(),
                        indicatorColor: Colors.transparent,
                        tabs: [
                          Container(
                              width: 250,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(29, 29, 29, 1),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: const Tab(
                                text: 'About',
                              )),
                          Container(
                              width: 250,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(29, 29, 29, 1),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: const Tab(
                                text: 'Structure',
                              )),
                          Container(
                              width: 250,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(29, 29, 29, 1),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: const Tab(
                                text: 'Contact',
                              )),
                        ],
                      ),
                      Container(
                        width: Get.width,
                        height: Get.height * 0.34,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(29, 29, 29, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TabBarView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            _TabDataWidget(
                                text:
                                    controller.state.eventData.value?.about ??
                                        "Nil"),
                            _TabDataWidget(
                                text: controller
                                        .state.eventData.value?.structure ??
                                    "Nil"),
                            _TabDataWidget(
                                text: controller
                                        .state.eventData.value?.contact ??
                                    "Nil"),
                          ],
                        ),
                      ),
                      Text(
                          (controller.state.eventData.value?.mode ==
                                      "online" ||
                                  controller.state.eventData.value
                                          ?.locationLng ==
                                      null ||
                                  controller.state.eventData.value
                                          ?.locationLat ==
                                      null)
                              ? ''
                              : 'LOCATION',
                          style: Get.theme.kVerySmallTextStyle.copyWith(
                            fontSize: 20,
                            color: Colors.grey,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(21),
                          child: controller.state.eventData.value?.mode!
                                          .toLowerCase() ==
                                      "online" ||
                                  controller.state.eventData.value?.locationLng ==
                                      null ||
                                  controller.state.eventData.value
                                          ?.locationLat ==
                                      null
                              ? const SizedBox(
                                  height: 10,
                                )
                              : Container(
                                  height: 200,
                                  width: Get.width * 0.9,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(210)),
                                  child: Mapscreen(
                                      Lattitude: controller
                                          .state.eventData.value?.locationLat,
                                      Longitude: controller
                                          .state.eventData.value?.locationLng,
                                      location: controller
                                          .state.eventData.value?.location)))
                    ],
                  ),
                ),
                sizeBox(150, 0),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        if (!controller.state.isEventRegistered.value) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: TicketButton(
              text: controller.state.isEventRegistered.value
                  ? 'View Ticket'
                  : 'Register now',
              onTap: () async {

                if (controller.state.isEventRegistered.value) {
                  Get.toNamed(AppRoutes.ticket,
                      arguments: controller.state.eventData.value);
                  return;
                }
                await controller.getUser();
                if (controller
                    .state.eventData.value!.dynamicform!.isNotEmpty) {
                  if (controller.state.eventData.value?.live ?? false) {
                    Get.toNamed(AppRoutes.registerEvent,
                        arguments: controller.state.eventData);
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
                } else if ((controller
                    .state.eventData.value!.reglink!.isNotEmpty)) {
                  if (await canLaunchUrl(Uri.parse(controller
                      .state.eventData.value!.reglink
                      .toString()))) {
                    launchUrl(Uri.parse(controller
                        .state.eventData.value!.reglink
                        .toString()));
                    controller.registerEvent(
                        e: controller.state.eventData.value!);
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
              isDisabled: !(controller.state.eventData.value?.live ?? false),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: TicketButton(
              text: 'View Ticket',
              onTap: () async {
                if (controller.state.isEventRegistered.value) {
                  Get.toNamed(AppRoutes.ticket,
                      arguments: controller.state.eventData.value);
                  return;
                }
              },
              isDisabled: !(controller.state.eventData.value?.live ?? false),
            ),
          );
        }
      }),
    );
  }
}

class _TabDataWidget extends StatelessWidget {
  const _TabDataWidget({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Html(data: text, style: {
        "body": Style(
          color: Colors.white,
          textAlign: TextAlign.center,
          fontSize: FontSize(19.5),
        )
      }),
    );
  }
}

class ImageColoredShadow extends StatelessWidget {
  const ImageColoredShadow({
    super.key,
    required this.link,
  });

  final String link;

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = 300.0;
    double blurRadius = 60.0;
    double blurSigma = 100;
    String imageUrl = link;

    return Stack(children: [
      Center(
          child: ClipRRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: width + blurRadius,
                    height: height + blurRadius,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: CachedNetworkImageProvider(imageUrl))),
                  )))),
      Positioned.fill(
          child: SizedBox(
            width: width + blurRadius,
            height: height + blurRadius,
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                child: Container(color: Colors.black.withOpacity(0))),
          )),
      Positioned.fill(
        bottom: 20,
        child: Center(
          child: Container(
              width: width - 20,
              height: height,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: CachedNetworkImageProvider(imageUrl)))),
        ),
      ),
    ]);
  }
}
