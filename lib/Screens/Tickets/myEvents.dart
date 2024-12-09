import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:AARUUSH_CONNECT/Screens/Tickets/TicketDisplayPage.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
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
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    HomeController controller = Get.find();
    widget.eventList == null
        ? widget.eventList = controller.eventList
        : widget.eventList = widget.eventList;
    controller.common.fetchAndLoadDetails();
    final eventIds = controller.common.registeredEvents();
    registeredEvents = <EventListModel>[];
    for (var i = 0; i < eventIds.length; i++) {
      for (var j = 0; j < widget.eventList!.length; j++) {
        if (eventIds[i] == widget.eventList![j].id) {
          registeredEvents.add(widget.eventList![j]);
        }
      }
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: widget.fromProfile
          ? AaruushAppBar(title: "AARUUSH", actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton.outlined(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  onPressed: () => {Navigator.pop(context)},
                  icon: const Icon(Icons.close_rounded),
                  color: Colors.white,
                  iconSize: 25,
                ),
              )
            ])
          : AaruushAppBar(
              title: "AARUUSH",
            ),
      body: BgArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: SizedBox(
              height: AppBar().preferredSize.height + 30,
            )),
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'My Events',
                  style: Get.theme.kSmallTextStyle.copyWith(
                      decoration: TextDecoration.underline, fontSize: 28),
                ),
              ),
            ),
            registeredEvents.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "You Haven't registered For Any Event",
                        style: Get.textTheme.labelMedium!
                            .copyWith(letterSpacing: 4),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ))
                : LiveSliverGrid.options(
                    controller: scrollController,
                    options: const LiveOptions(
                      showItemInterval: Duration(milliseconds: 100),
                      showItemDuration: Duration(milliseconds: 300),
                      visibleFraction: 0.05,
                      reAnimateOnVisibility: false,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 159 / 200),
                    itemBuilder: _buildAnimatedCard,
                    itemCount: registeredEvents.length,
                  ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 0.1 * Get.height,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildAnimatedCard(
    BuildContext context, int index, Animation<double> animation) {
  return FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -0.1),
          end: Offset.zero,
        ).animate(animation),

        child: TicketTile(
          imagePath: registeredEvents[index].image!,
          title: registeredEvents[index].name!,
          event: registeredEvents[index],
        ),
      ));
}

class TicketTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final EventListModel event;

  const TicketTile({
    super.key,
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
            footer: SizedBox(
              height: 48,
              child: GridTileBar(
                leading: Padding(
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
                trailing: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                  child: IconButton(
                      onPressed: () {
                        Get.to(() => TicketDisplayPage(
                              event: event,
                            ));
                      },
                      icon: const Icon(Icons.qr_code_scanner_rounded)),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 10, 40),
              child: GestureDetector(
                //TODO: make this gesture detector redirect to events page
                onTap: () => Get.to(() => EventsScreen(
                      event: event,
                      fromMyEvents: true.obs,
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
