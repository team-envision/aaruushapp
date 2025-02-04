import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Common/core/Routes/app_routes.dart';
import 'package:AARUUSH_CONNECT/Common/core/Utils/Logger/app_logger.dart';
import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:animations/animations.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'events_screen.dart';
import '../../Home/controllers/home_controller.dart';

var registeredEvents = <EventListModel>[].obs;

class MyEvents extends StatefulWidget {
  RxList<EventListModel>? eventList;
  MyEvents({super.key});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  final scrollController = ScrollController();




  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    final screenHeight = Get.height;

    Future.delayed(Duration(milliseconds: 300), () async {
      HomeController controller = Get.find<HomeController>();
      CommonController commonController = Get.find<CommonController>();
      widget.eventList ??= controller.state.eventList;

      // Fetch data and populate registeredEvents
      await commonController.fetchAndLoadDetails();
      final eventIds = commonController.registeredEvents();
      Log.info(eventIds);
      for (var eventId in eventIds) {
        for (var event in widget.eventList!) {
          if (eventId == event.id) {
            registeredEvents.add(event);

          }
        }
      }

    });



    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AaruushAppBar(title: "My Events"),
      body: BgArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Obx(() {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: registeredEvents.isEmpty
                      ? null
                      : SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height / 8),
                ),
                if (registeredEvents.isEmpty) SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      "You Haven't registered For Any Event",
                      style: Get.textTheme.labelMedium!
                          .copyWith(letterSpacing: 4),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ) else LiveSliverGrid.options(
                  controller: scrollController,
                  options: const LiveOptions(
                    showItemInterval: Duration(milliseconds: 100),
                    showItemDuration: Duration(milliseconds: 300),
                    visibleFraction: 0.05,
                    reAnimateOnVisibility: false,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth > 600 ? 3 : 2,
                    mainAxisSpacing: screenHeight * 0.02,
                    crossAxisSpacing: screenWidth * 0.03,
                    childAspectRatio: 159 / 200,
                  ),
                  itemBuilder: _buildAnimatedCard,
                  itemCount: registeredEvents.length,
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: screenHeight * 0.1),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }


  Widget _buildAnimatedCard(BuildContext context, int index,
      Animation<double> animation) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero)
            .animate(animation),
        child: OpenContainer(
          middleColor: Colors.transparent,
          openColor: Colors.transparent,
          closedColor: Colors.transparent,
          closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return TicketTile(
              imagePath: registeredEvents[index].image!,
              title: registeredEvents[index].name!,
              event: registeredEvents[index],
              width: screenWidth / 2.5,
            );
          },
          openBuilder: (BuildContext _, VoidCallback __) {
            return EventsScreen(
              event: registeredEvents[index],
              fromMyEvents: true.obs,
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      ),
    );
  }
}


class TicketTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final EventListModel event;
  final double width;

  const TicketTile(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.event,
      required this.width});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: const Color(0xFFA39E9E).withOpacity(0.11),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: width * 0.07, left: width * 0.07, right: width * 0.07),
              child: Container(
                height: screenHeight / 5.3,
                decoration: BoxDecoration(
                  color: const Color(0xFFA39E9E).withOpacity(0.11),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 0),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(imagePath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: SizedBox(
                      width: width * 0.6513,
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xFFEF6522), fontSize: 14),
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: 20,
                    onPressed: () {
                      Get.toNamed(AppRoutes.ticket, arguments: event);
                    },
                    icon: const Icon(Icons.qr_code_scanner_rounded, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
