import 'dart:ui';
import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/events_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Events/register_event.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/Utilities/custom_sizebox.dart';
import 'package:AARUUSH_CONNECT/Utilities/snackbar.dart';

import 'package:AARUUSH_CONNECT/components/bg_area.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/MapScreen.dart';
import '../../components/ticketButton.dart';

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
      appBar: AppBar(

        backgroundColor: Colors.transparent,

          leading:IconButton(
            icon: Icon(Icons.arrow_back),

            color: Colors.white,
              onPressed: ()=>{Navigator.pop(context)},

          ),



        actions: [ Container(
            height: 49,
            width: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xFF504C45),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
              color: Colors.white,
              iconSize: 25,
            ),
          )
        ],

        centerTitle: true,
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

            Column(
              children: [
                ImageColoredShadow(link: eventData.image!),
                Row(crossAxisAlignment: CrossAxisAlignment.center,verticalDirection: VerticalDirection.up,
                  children: [
                    Expanded(flex: 1,
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5,),
                        child: Text(eventData.name!,
                            style: Get.theme.kSmallTextStyle.copyWith(fontSize:21 )), //X-play
                      ),
                    ),

                    Column(
                      children: [


                    Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xFFEF6522),
                      ),
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: _iconWithText(eventData.time ?? '')),
                    ), SizedBox(height: 10,),
                        Container(
                          height: 40,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(0xFFEF6522),
                          ),
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: _iconWithText(eventData.date ?? '')),
                        ),

                      ],
                    ),

                  ],
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: Text(
                eventData.oneliner ?? "Nil",
                style: Get.theme.kVerySmallTextStyle,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

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
            // Container(
            //   width: Get.width,
            //   margin:
            //       const EdgeInsets.symmetric(horizontal: 10.0, vertical: 22),
            //   height: 5,
            //   decoration: BoxDecoration(
            //     color: Get.theme.colorPrimary,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            // ),
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    
                    labelColor: Colors.white,
                    indicatorPadding: EdgeInsets.all(12),padding: EdgeInsets.all(12),labelPadding: EdgeInsets.all(12),
                    unselectedLabelColor: Colors.white10,
                    labelStyle: Get.theme.kVerySmallTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    physics: const BouncingScrollPhysics(),
                    indicatorColor: Colors.transparent,
                    tabs:  [
                      Container(  width:250,decoration: BoxDecoration(
                        color: Color.fromRGBO(29, 29, 29, 1),
                       borderRadius: BorderRadius.circular(13),

                      ),
                          child: Tab(text: 'About',)
                          ),
                      Container(  width:250,decoration: BoxDecoration(
                        color: Color.fromRGBO(29, 29, 29, 1),
                        borderRadius: BorderRadius.circular(13),

                      ),
                          child: Tab(text: 'Structure',)
                      ),
                      Container(  width:250,decoration: BoxDecoration(
                        color: Color.fromRGBO(29, 29, 29, 1),
                        borderRadius: BorderRadius.circular(13),

                      ),
                          child: Tab(text: 'Contact',)
                      ),
                    ],
                  ),
                  Container(
                    width: Get.width,
                    height: Get.height * 0.24,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(20),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(

                      color: Colors.transparent,


                      borderRadius: BorderRadius.circular(20),
                    //  border: Border.all(color: Colors.white, width: 0),
                    ),
                    child: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _tabDataWidget(text: eventData.about ?? "Nil"),
                        _tabDataWidget(text: eventData.structure ?? "Nil"),
                        _tabDataWidget(text: eventData.contact ?? "Nil"),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(('LOCATION '),style: TextStyle(fontSize: 24,color: Colors.grey),),

                  GestureDetector(
                    onTap: () {
                      print("eventData.locationLat!");
                      print(eventData.location!);
                      print(eventData.locationLat);
                      // print( eventData.locationLng!);

                      if (eventData.location != null &&
                          eventData.locationLat != null &&
                          eventData.locationLng != null) {
                        print("eventData.location!");
                        controller.openMapWithLocation(
                            eventData.locationLat!, eventData.locationLng!

                        );
                      }
                      else{
                        print("latitude and log in null");
                        controller.openMapWithLocation(
                          // eventData.locationLat!, eventData.locationLng!
                          "12.8240104753402", "80.0457505142571",

                        );
                      }
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.pin_drop,
                          color: Colors.grey,
                        ),
                        sizeBox(0, 3),
                        Text(
                          eventData.location ?? '',
                          style: Get.theme.kVerySmallTextStyle.copyWith(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),

                      ],
                    ),
                  ),


                    ],
                  ),

                  Container(
                    height: 150,
                    width: 340,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(210)
                     ),
                    child:Mapscreen(),
                  ) ],),
            ),
            sizeBox(20, 0),
            if (!fromMyEvents)
              Obx(() {
                return TicketButton(
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
                      if (await canLaunchUrl(
                          Uri.parse(eventData.reglink.toString()))) {
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
            sizeBox(150, 0),
          ],
        );
      }),
      // bottomNavigationBar: AaruushBottomBar(bottomIndex: BottomIndexData.NONE),
    );
  }

  Widget _iconWithText(String text) {
    return Row(
      children: [
        Text(
          text,
          style: Get.theme.kBigTextStyle1.copyWith(fontSize: 11),
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

class ImageColoredShadow extends StatelessWidget {
  const ImageColoredShadow({
    Key? key,
    required this.link,
  }) : super(key: key);

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
                  child: new Container(
                    width: width + blurRadius,
                    height: height + blurRadius,
                    decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                            fit: BoxFit.contain,
                            image: new NetworkImage(imageUrl))),
                  )))),
      Positioned.fill(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: Container(color: Colors.black.withOpacity(0)))),
      Positioned.fill( bottom: 20,
        child: Center(
          child: new Container(
              width: width - 20,
              height: height,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                      fit: BoxFit.contain, image:  CachedNetworkImageProvider(imageUrl)))),
        ),
      ),

    ]);
  }
}
