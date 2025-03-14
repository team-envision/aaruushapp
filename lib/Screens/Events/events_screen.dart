import 'dart:io';
import 'dart:ui';
import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/events_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/register_event.dart';
import 'package:AARUUSH_CONNECT/Screens/Tickets/TicketDisplayPage.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/Utilities/custom_sizebox.dart';
import 'package:AARUUSH_CONNECT/Utilities/snackbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/MapScreen.dart';
import '../../components/ticketButton.dart';

class EventsScreen extends StatefulWidget {
  EventsScreen({
    super.key,
    this.event,
    required this.fromMyEvents,
    this.fromNotificationRoute = false,
    this.EventId,
  });

  final EventListModel? event;
  RxBool fromMyEvents = false.obs;
  final bool fromNotificationRoute;
  final String? EventId;

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final controller = Get.put<EventsController>(EventsController());
  var eventData;
  @override
  void initState() {
    super.initState();
    _initializeEventData();
    eventData = controller.eventData.value;
  }

  Future<void> _initializeEventData() async {
    if (widget.fromNotificationRoute && widget.EventId != null) {
      await controller.fetchEventData(widget.EventId!);

      eventData = controller.eventData.value;

      controller.checkRegistered(eventData);

      controller.getUser().then((_) async {
        controller.checkRegistered(controller.eventData.value);
      });
    } else if (!widget.fromNotificationRoute && widget.event != null) {
      controller.eventData.value = widget.event!;
      controller.getUser().then((_) async {
        controller.checkRegistered(controller.eventData.value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if ((details.primaryDelta! > -1 && details.localPosition.dx < 100) && Platform.isIOS) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
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
                onPressed: () => {Navigator.pop(context)},
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 20,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizeBox(100, 0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageColoredShadow(link: eventData.image!),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 5),
                        child: Text(eventData.name.toString().trim(),
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
                            Text(eventData.date,
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
                            Text(eventData.time,
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
                            eventData.mode == "offline"
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
                            Text(eventData.mode.toString().capitalizeFirst!,
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
                              child: Text(eventData.location,
                                  style: Get.theme.kVerySmallTextStyle.copyWith(
                                      fontSize: 18,
                                      color: const Color(0xFFEF6522))),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20.0, top: 25),
                    child: Text(
                      eventData.oneliner ?? "Nil",
                      style: Get.theme.kVerySmallTextStyle,
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
                  DefaultTabController(
                    length: 4,
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
                                  text: 'Timeline',
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
                              _tabDataWidget(text: eventData.about ?? "N/A"),
                              _tabDataWidget(
                                  text: eventData.structure ?? "N/A"),
                              _tabDataWidget(text: eventData.timeline ?? "N/A"),
                              _tabDataWidget(text: eventData.contact ?? "N/A"),

                            ],
                          ),
                        ),
                        Text(
                            (eventData.mode == "online" ||
                                    eventData.locationLng == null ||
                                    eventData.locationLat == null)
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
                            child: eventData.mode!.toLowerCase() == "online" ||
                                    eventData.locationLng == null ||
                                    eventData.locationLat == null
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
                                        Lattitude: eventData.locationLat,
                                        Longitude: eventData.locationLng,
                                        location: eventData.location)))
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
          if (!widget.fromMyEvents.value) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: TicketButton(
                text: controller.isEventRegistered.value
                    ? 'View Ticket'
                    : 'Register now',
                onTap: () async {
                  print(controller.eventData);

                  if (controller.isEventRegistered.value) {
                    Get.to(() =>
                        TicketDisplayPage(event: controller.eventData.value));
                    return;
                  }

                  if (controller.eventData.value.dynamicform!.isNotEmpty) {
                    if (eventData.live ?? false) {
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
                  } else if ((controller.eventData.value.reglink!.isNotEmpty)) {
                    if (await canLaunchUrl(
                        Uri.parse(eventData.reglink.toString()))) {
                      launchUrl(Uri.parse(eventData.reglink.toString()));
                      controller.registerEvent(e: eventData);
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
                isDisabled: !(eventData.live ?? false),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: TicketButton(
                text: 'View Ticket',
                onTap: () async {
                  if (controller.isEventRegistered.value) {
                    Get.to(() =>
                        TicketDisplayPage(event: controller.eventData.value));
                    return;
                  }
                },
                isDisabled: false,
              ),
            );
            ;
          }
        }),
      ),
    );
  }
}

class _tabDataWidget extends StatelessWidget {
  const _tabDataWidget({
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
                            image: NetworkImage(imageUrl))),
                  )))),
      Positioned.fill(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: Container(color: Colors.black.withOpacity(0)))),
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
