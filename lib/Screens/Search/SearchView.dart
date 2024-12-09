import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
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
        event.startdate!.contains(DateTime
            .now()
            .year
            .toString()))
        .toList();
  }

  void _initialList() {
    eventList.value = homeController.eventList
        .where((event) =>
    event.live! &&
        event.startdate != null &&
        event.startdate!.contains(DateTime
            .now()
            .year
            .toString()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AaruushAppBar(title: "AARUUSH",actions: [
        IconButton.outlined(
          padding: EdgeInsets.zero,
          onPressed: () => {Navigator.pop(context)},
          icon: const Icon(Icons.close_rounded),
          color: Colors.white,
          iconSize: 25,
        ),
      ],),
      body: BgArea(
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: AppBar().preferredSize.height + 30,),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: SizedBox(
                height: 50,
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
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Search Event Name",
                      hintStyle: const TextStyle(color: Colors.black45),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (searchResults.isEmpty) {
                return Expanded(
                  child: CustomScrollView(
                    slivers: [LiveSliverGrid.options(
                      options: const LiveOptions(

                        showItemInterval: Duration(milliseconds: 100),

                        showItemDuration: Duration(milliseconds: 300),

                        visibleFraction: 0.05,

                        reAnimateOnVisibility: false,),
                      itemCount: eventList.length,
                      itemBuilder: _buildAnimatedCard,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      controller: _scrollController1,
                    ),],
                  ),
                );
              }

              else {
                return Expanded(
                  child: CustomScrollView(
                    slivers: [LiveSliverGrid.options(
                      itemCount: searchResults.length,
                      itemBuilder: _buildSearchedAnimatedCard,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ), controller: _scrollController2, options: const LiveOptions(

                      showItemInterval: Duration(milliseconds: 100),

                      showItemDuration: Duration(milliseconds: 300),

                      visibleFraction: 0.05,

                      reAnimateOnVisibility: false,),
                    ),],
                  )
                );
              }
            })
          ],
        ),
      ),
    );
  }

}


Widget _buildAnimatedCard(BuildContext context, int index,
    Animation<double> animation) {
  var event = eventList[index];
  return FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      // And slide transition
      child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          // Paste you Widget
          child:
          eventCard(
            event,
                () =>
                Get.to(() =>
                    EventsScreen(
                      event: event,
                      fromMyEvents: false.obs,
                    )),
            homeController,
          ))
  );
}


Widget _buildSearchedAnimatedCard(BuildContext context, int index,
    Animation<double> animation) {
  var event = searchResults[index];
  return FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      // And slide transition
      child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          // Paste you Widget
          child: eventCard(
            event,
                () =>
                Get.to(() =>
                    EventsScreen(
                      event: event,
                      fromMyEvents: false.obs,
                    )),
            homeController,
          )
      ));
}