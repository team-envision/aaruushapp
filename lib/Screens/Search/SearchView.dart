import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:animations/animations.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/eventCard.dart';
import '../Events/events_screen.dart';
import '../Home/home_controller.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  _SearchscreenState createState() => _SearchscreenState();
}

final HomeController homeController = Get.find();
RxList searchResults = [].obs;
RxList eventList = [].obs;

class _SearchscreenState extends State<Searchscreen> {
  final TextEditingController _searchController = TextEditingController();

  final _scrollController1 = ScrollController();
  final _scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();
    _initialList();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _scrollController1.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    searchResults.value = homeController.eventList
        .where((event) =>
            event.name!.toLowerCase().contains(query) &&
            event.startdate != null &&
            event.edition == 'a24')
        .toList();
  }

  void _initialList() {
    eventList.value = homeController.eventList
        .where((event) =>
            event.live! && event.startdate != null && event.edition == 'a24')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AaruushAppBar(
        title: "AARUUSH",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SizedBox(
              height: 35,
              width: 35,
              child: IconButton.outlined(
                padding: EdgeInsets.zero,
                onPressed: () => {Navigator.pop(context)},
                icon: const Icon(Icons.close_rounded),
                color: Colors.white,
                iconSize: 20,
              ),
            ),
          ),
        ],
      ),
      body: BgArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 8),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                child: Hero(
                  tag: "SearchTag",
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    cursorColor: Colors.black45,
                    controller: _searchController,
                    onTapOutside: (val) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 18),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Search Event Name",
                      hintStyle: const TextStyle(color: Colors.black45),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() {
                if (searchResults.isEmpty) {
                  return Expanded(
                    child: CustomScrollView(
                      slivers: [
                        LiveSliverGrid.options(
                          options: const LiveOptions(
                            showItemInterval: Duration(milliseconds: 100),
                            showItemDuration: Duration(milliseconds: 300),
                            visibleFraction: 0.05,
                            reAnimateOnVisibility: false,
                          ),
                          itemCount: eventList.length,
                          itemBuilder: _buildAnimatedCard,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          controller: _scrollController1,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Expanded(
                      child: CustomScrollView(
                    slivers: [
                      LiveSliverGrid.options(
                        itemCount: searchResults.length,
                        itemBuilder: _buildSearchedAnimatedCard,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        controller: _scrollController2,
                        options: const LiveOptions(
                          showItemInterval: Duration(milliseconds: 100),
                          showItemDuration: Duration(milliseconds: 300),
                          visibleFraction: 0.05,
                          reAnimateOnVisibility: false,
                        ),
                      ),
                    ],
                  ));
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildAnimatedCard(
    BuildContext context, int index, Animation<double> animation) {
  var event = eventList[index];
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
          child: OpenContainer(
            middleColor: Colors.transparent,
            openColor: Colors.transparent,
            closedColor: Colors.transparent,
            closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            transitionDuration: const Duration(milliseconds: 400),
            transitionType: ContainerTransitionType.fadeThrough,
            openBuilder: (context, _) => EventsScreen(
              event: event,
              fromMyEvents: false.obs,
            ),
            closedBuilder: (context, openContainer) => eventCard(
              event,
              openContainer,
              homeController,
            ),
          )));
}

Widget _buildSearchedAnimatedCard(
    BuildContext context, int index, Animation<double> animation) {
  var event = searchResults[index];
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
          child: OpenContainer(
            middleColor: Colors.transparent,
            openColor: Colors.transparent,
            closedColor: Colors.transparent,
            closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            transitionDuration: const Duration(milliseconds: 400),
            transitionType: ContainerTransitionType.fadeThrough,
            openBuilder: (context, _) => EventsScreen(
              event: event,
              fromMyEvents: false.obs,
            ),
            closedBuilder: (context, openContainer) => eventCard(
              event,
              openContainer,
              homeController,
            ),
          )));
}