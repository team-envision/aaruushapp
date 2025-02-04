import 'package:AARUUSH_CONNECT/Screens/Search/Widgets/AnimatedCard.dart';
import 'package:AARUUSH_CONNECT/Screens/Search/Widgets/SearchedAnimatedCard.dart';
import 'package:AARUUSH_CONNECT/Screens/Search/controllers/Search_Controller.dart';
import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Searchscreen extends StatelessWidget {
  final SearchBarController searchController = Get.find<SearchBarController>();


   Searchscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AaruushAppBar(
        title: "AARUUSH",
        actions: [
          Padding(
            padding:  const EdgeInsets.only(right: 15),
            child: SizedBox(
              height: 35,
              width: 35,
              child: IconButton.outlined(
                padding: EdgeInsets.zero,
                onPressed: () => {Get.back()},
                icon:  const Icon(Icons.close_rounded),
                color: Colors.white,
                iconSize: 20,
              ),
            ),
          ),
        ],
      ),
      body: BgArea(
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 15),
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
                    controller: searchController.state.searchController,
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
                if (searchController.state.searchResults.isEmpty) {
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
                          itemCount: searchController.state.eventList.length,
                          itemBuilder: buildAnimatedCard,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          controller: searchController.state.scrollController1,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Expanded(
                      child: CustomScrollView(
                    slivers: [
                      LiveSliverGrid.options(
                        itemCount: searchController.state.searchResults.length,
                        itemBuilder: buildSearchedAnimatedCard,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        controller: searchController.state.scrollController2,
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