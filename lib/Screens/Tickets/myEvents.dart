// import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
// import 'package:AARUUSH_CONNECT/Screens/Tickets/TicketDisplayPage.dart';
// import 'package:AARUUSH_CONNECT/Themes/themes.dart';
// import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
// import 'package:AARUUSH_CONNECT/components/bg_area.dart';
// import 'package:auto_animated/auto_animated.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../Events/events_screen.dart';
// import '../Home/home_controller.dart';
//
// var registeredEvents;
//
// class MyEvents extends StatefulWidget {
//   List<EventListModel>? eventList;
//   bool fromProfile;
//   MyEvents({super.key, this.eventList, required this.fromProfile});
//
//   @override
//   State<MyEvents> createState() => _MyEventsState();
// }
//
// class _MyEventsState extends State<MyEvents> {
//   final scrollController = ScrollController();
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     scrollController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     HomeController controller = Get.find();
//     widget.eventList == null
//         ? widget.eventList = controller.eventList
//         : widget.eventList = widget.eventList;
//     controller.common.fetchAndLoadDetails();
//     final eventIds = controller.common.registeredEvents();
//     registeredEvents = <EventListModel>[];
//     for (var i = 0; i < eventIds.length; i++) {
//       for (var j = 0; j < widget.eventList!.length; j++) {
//         if (eventIds[i] == widget.eventList![j].id) {
//           registeredEvents.add(widget.eventList![j]);
//         }
//       }
//     }
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: widget.fromProfile
//           ? AaruushAppBar(title: "Aaruush", actions: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: IconButton.outlined(
//                   padding: EdgeInsets.zero,
//                   alignment: Alignment.center,
//                   onPressed: () => {Navigator.pop(context)},
//                   icon: const Icon(Icons.close_rounded),
//                   color: Colors.white,
//                   iconSize: 25,
//                 ),
//               )
//             ])
//           : AaruushAppBar(
//               title: "My Events",
//             ),
//       body: BgArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 15, right: 15),
//           child: CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(
//                   child: SizedBox(
//                 height: AppBar().preferredSize.height + 65,
//               )),
//               registeredEvents.isEmpty
//                   ? SliverToBoxAdapter(
//                       child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(18.0),
//                         child: Text(
//                           "You Haven't registered For Any Event",
//                           style: Get.textTheme.labelMedium!
//                               .copyWith(letterSpacing: 4),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ))
//                   : LiveSliverGrid.options(
//                       controller: scrollController,
//                       options: const LiveOptions(
//                         showItemInterval: Duration(milliseconds: 100),
//                         showItemDuration: Duration(milliseconds: 300),
//                         visibleFraction: 0.05,
//                         reAnimateOnVisibility: false,
//                       ),
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2,
//                               mainAxisSpacing: 15,
//                               crossAxisSpacing: 15,
//                               childAspectRatio: 159 / 200),
//                       itemBuilder: _buildAnimatedCard,
//                       itemCount: registeredEvents.length,
//                     ),
//               SliverToBoxAdapter(
//                 child: SizedBox(
//                   height: 0.1 * Get.height,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget _buildAnimatedCard(
//     BuildContext context, int index, Animation<double> animation) {
//   return FadeTransition(
//       opacity: Tween<double>(
//         begin: 0,
//         end: 1,
//       ).animate(animation),
//       child: SlideTransition(
//         position: Tween<Offset>(
//           begin: Offset(0, -0.1),
//           end: Offset.zero,
//         ).animate(animation),
//         child: TicketTile(
//           imagePath: registeredEvents[index].image!,
//           title: registeredEvents[index].name!,
//           event: registeredEvents[index],
//         ),
//       ));
// }
//
// class TicketTile extends StatelessWidget {
//   final String imagePath;
//   final String title;
//   final EventListModel event;
//
//   const TicketTile({
//     super.key,
//     required this.imagePath,
//     required this.title,
//     required this.event,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         borderRadius: BorderRadius.circular(12),
//         child: Container(
//           color: const Color(0xFFA39E9E).withOpacity(0.11),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
//                 child: GestureDetector(
//                   onTap: () => Get.to(() => EventsScreen(
//                         event: event,
//                         fromMyEvents: true.obs,
//                       )),
//                   child: Container(
//                     height: MediaQuery.of(context).size.height / 5.3,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                         color: const Color(0xFFA39E9E).withOpacity(0.11),
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                             color: Colors.white,
//                             width: 0,
//                             strokeAlign: BorderSide.strokeAlignOutside),
//                         image: DecorationImage(
//                             image: CachedNetworkImageProvider(imagePath),
//                             fit: BoxFit.fill)),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: Row(
//                     children: [
//                       SizedBox(
//                           width: MediaQuery.of(context).size.width / 3.76,
//                           child: Text(
//                             title,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               color: Color(0xFFEF6522),
//                               fontSize: 14,
//                             ),
//                           )),
//                       IconButton(
//                         iconSize: 20,
//                         padding: EdgeInsets.zero,
//                         onPressed: () {
//                           Get.to(() => TicketDisplayPage(
//                                 event: event,
//                               ));
//                         },
//                         icon: const Padding(
//                           padding: EdgeInsets.zero,
//                           child: Icon(
//                             Icons.qr_code_scanner_rounded,
//                             size: 20,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:AARUUSH_CONNECT/Screens/Tickets/TicketDisplayPage.dart';
import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Events/events_screen.dart';
import '../Home/home_controller.dart';

var registeredEvents;

class MyEvents extends StatefulWidget {
  List<EventListModel>? eventList;
  bool fromProfile;
  MyEvents({super.key, this.eventList, required this.fromProfile});

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
    HomeController controller = Get.find();
    widget.eventList ??= controller.eventList;
    controller.common.fetchAndLoadDetails();
    final eventIds = controller.common.registeredEvents();
    registeredEvents = <EventListModel>[];
    for (var eventId in eventIds) {
      for (var event in widget.eventList!) {
        if (eventId == event.id) {
          registeredEvents.add(event);
        }
      }
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: widget.fromProfile
          ? AaruushAppBar(title: "Aaruush", actions: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: IconButton.outlined(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                  color: Colors.white,
                  iconSize: screenWidth * 0.06,
                ),
              )
            ])
          : AaruushAppBar(title: "My Events"),
      body: BgArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: registeredEvents.isEmpty ?null :SizedBox(height: MediaQuery.of(context).size.height / 8),
              ),
              registeredEvents.isEmpty
                  ? SliverToBoxAdapter(
                      child: SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: Center(
                          child: Text(
                            "You Haven't registered For Any Event",
                            style: Get.textTheme.labelMedium!
                                .copyWith(letterSpacing: 4),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  : LiveSliverGrid.options(
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
          ),
        ),
      ),
    );
  }
}

Widget _buildAnimatedCard(
    BuildContext context, int index, Animation<double> animation) {
  final screenWidth = MediaQuery.of(context).size.width;

  return FadeTransition(
    opacity: Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animation),
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -0.1),
        end: Offset.zero,
      ).animate(animation),
      child: TicketTile(
        imagePath: registeredEvents[index].image!,
        title: registeredEvents[index].name!,
        event: registeredEvents[index],
        width: screenWidth / 2.5,
      ),
    ),
  );
}

class TicketTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final EventListModel event;
  final double width;

  const TicketTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.event,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: const Color(0xFFA39E9E).withOpacity(0.11),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: width * 0.07,
                left: width * 0.07,
                right: width * 0.07,
              ),
              child: GestureDetector(
                onTap: () => Get.to(() => EventsScreen(
                      event: event,
                      fromMyEvents: true.obs,
                    )),
                child: Container(
                  height: screenHeight / 5.3,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA39E9E).withOpacity(0.11),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white,
                      width: 0,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(imagePath),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: SizedBox(
                      width: width * 0.6513,
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFFEF6522),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: 20,
                    onPressed: () {
                      Get.to(() => TicketDisplayPage(event: event));
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
