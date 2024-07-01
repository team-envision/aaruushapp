import 'package:aarush/Data/bottomIndexData.dart';
import 'package:aarush/Model/Events/event_list_model.dart';
import 'package:aarush/Screens/Events/events_screen.dart';
import 'package:aarush/Screens/Profile/editProfile.dart';
import 'package:aarush/Screens/Tickets/TicketDisplayPage.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/components/aaruushappbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Utilities/bottombar.dart';
import '../Home/home_controller.dart';

class MyEvents extends StatelessWidget {
  MyEvents({super.key, this.eventList});
  List<EventListModel>? eventList;
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    eventList == null
        ? eventList = controller.eventList.value
        : eventList = eventList;
    controller.common.fetchAndLoadDetails();
    final eventIds = controller.common.registeredEvents();
    var registeredEvents = <EventListModel>[];
    for (var i = 0; i < eventIds.length; i++) {
      for (var j = 0; j < eventList!.length; j++) {
        debugPrint("Ids: ${eventList![j].id}");
        if (eventIds[i] == eventList![j].id) {
          registeredEvents.add(eventList![j]);
        }
      }
    }
    // controller.common.signOutCurrentUser();;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: AaruushAppBar(title: "My Events", actions: [
          IconButton(
            onPressed: () => {Get.back()},
            icon: const Icon(Icons.close_rounded),
            color: Colors.white,
            iconSize: 25,
          ),
        ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            sizeBox(50, 0),
            Padding(
              padding:
                  EdgeInsets.only(left: MediaQuery.sizeOf(context).width / 25),
              child: const Text(
                'Events and tickets',
                style: TextStyle(fontSize: 32),
              ),
            ),
            sizeBox(50, 0),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 30),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 159 / 200),
                  physics: const BouncingScrollPhysics(),
                  itemCount: registeredEvents.length,
                  itemBuilder: (context, index) {
                    return TicketTile(
                      imagePath: registeredEvents[index].image!,
                      title: registeredEvents[index].name!,
                      event: registeredEvents[index],
                    );
                  },
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: const AaruushBottomBar(
          bottomIndex: BottomIndexData.TICKETS,
        ),
      ),
    );
  }
}

class TicketTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final EventListModel event;

  const TicketTile({
    required this.imagePath,
    required this.title,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: const Color(0xFFA39E9E).withOpacity(0.11),
          child: GridTile(
            footer: Container(
              height: 48,
              child: GridTileBar(
                leading: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 40,
                          left: MediaQuery.of(context).size.width / 35),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width / 4.97,
                          child: Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFFEF6522),
                              fontSize: 14,
                            ),
                          )),
                    ),
                    //padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/60,left:MediaQuery.of(context).size.width/13 ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 50),
                      child: IconButton(
                          onPressed: () {
                            Get.to(() => TicketDisplayPage(
                                  event: event,
                                ));
                          },
                          icon: const Icon(Icons.qr_code_scanner_rounded)),
                    )
                  ],
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 10, 40),
              child: GestureDetector(
                //TODO: make this gesture detector redirect to events page
                onTap: () => Get.to(() => EventsScreen(
                      event: event,
                      fromMyEvents: true,
                    )),
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFA39E9E).withOpacity(0.11),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.white,
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(imagePath),
                            fit: BoxFit.fill)),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
