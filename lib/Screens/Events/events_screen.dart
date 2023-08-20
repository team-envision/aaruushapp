// ignore_for_file: invalid_use_of_protected_member

import 'dart:ui';

import 'package:aarush/Data/bottomIndexData.dart';
import 'package:aarush/Model/Events/event_list_model.dart';
import 'package:aarush/Screens/Events/events_controller.dart';
import 'package:aarush/Screens/Events/register_event.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/bottombar.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/Utilities/snackbar.dart';
import 'package:aarush/components/bg_area.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:aarush/components/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Utilities/appBarBlur.dart';

class EventsScreen extends StatelessWidget {
  EventsScreen({super.key, required this.event, this.fromMyEvents = false});
  final EventListModel event;
  bool fromMyEvents;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<EventsController>(EventsController());
    controller.eventData.value = event;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        flexibleSpace: appBarBlur(),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => {},
          icon: Obx(
            () => controller.common.profileUrl.value != null
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
      body: BgArea(
          image: 'bg2.png',
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizeBox(100, 0),
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: event.image!,
              placeholderScale: 0.1,
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
              child:
                  Text(event.oneliner!, style: Get.theme.kVerySmallTextStyle),
            ),
            sizeBox(20, 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _iconWithText(Icons.calendar_month, event.date ?? ''),
                  _iconWithText(Icons.access_time, event.time ?? ''),
                  _iconWithText(Icons.pin_drop, event.location ?? ''),
                ],
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
                      unselectedLabelColor: Get.theme.curveBG.withOpacity(0.5),
                      labelStyle: Get.theme.kVerySmallTextStyle
                          .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                      physics: const BouncingScrollPhysics(),
                      indicatorColor: Colors.transparent,
                      tabs: const [
                        Tab(text: 'About'),
                        Tab(text: 'Structure'),
                        Tab(text: 'Contact'),
                      ]),
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
                            _tabDataWidget(text: event.about!),
                            _tabDataWidget(text: event.structure!),
                            _tabDataWidget(text: event.contact!),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            sizeBox(20, 0),
            if (!fromMyEvents)
              Obx(
                () => primaryButton(
                    text: controller.isEventRegistered.value
                        ? 'Registered'
                        : 'Register now',
                    onTap: () async => {
                          if (event.reqdfields != null && event.reqdfields!)
                            {
                              if (controller.isEventRegistered.value)
                                {
                                  setSnackBar(
                                      "INFO:", "You have already registered",
                                      icon: const Icon(
                                        Icons.info,
                                        color: Colors.orange,
                                      ))
                                }
                              else
                                {
                                  if (controller.eventData.value.live!)
                                    {Get.to(() => RegisterEvent(event: event))}
                                  else
                                    {
                                      setSnackBar(
                                          "INFO:", "Event is not live now!",
                                          icon: const Icon(
                                            Icons.warning_amber_rounded,
                                            color: Colors.red,
                                          ))
                                    }
                                }
                            }
                          else
                            {
                              if (await canLaunchUrl(Uri.parse(event.reglink!)))
                                {
                                  launchUrl(Uri.parse(event.reglink!),
                                      mode: LaunchMode.externalApplication),
                                  controller.registerEvent(e: event)
                                }
                              else
                                {
                                  setSnackBar("ERROR:", "Invalid URL",
                                      icon: const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ))
                                }
                            }
                        }),
              ),
            sizeBox(200, 0),
          ]),
      bottomNavigationBar:
          const AaruushBottomBar(bottomIndex: BottomIndexData.NONE),
    );
  }

  Widget _iconWithText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon),
        sizeBox(0, 3),
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
        style: {"body": Style(color: Colors.white, fontSize: FontSize(19.5))},
      ),
    );
  }
}
