import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
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

class _SearchscreenState extends State<Searchscreen> {
  final TextEditingController _searchController = TextEditingController();
  final HomeController homeController = Get.find();
  RxList searchResults = [].obs;
  RxList eventList = [].obs;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _initialList();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
      searchResults.value = homeController.eventList
          .where((event) =>
              event.name!.toLowerCase().contains(query) &&
              event.startdate != null &&
              event.startdate!.contains(DateTime.now().year.toString()))
          .toList();
  }
  void _initialList() {

    eventList.value = homeController.eventList
        .where((event) =>
    event.live! &&
        event.startdate != null &&
        event.startdate!.contains(DateTime.now().year.toString()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AaruushAppBar(title: "AARUUSH"),
      body: BgArea(
        children: [
          SizedBox(height: 100,),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SizedBox(
              height: 50,
              child: Hero(
                tag: "SearchTag",
                child: TextField(style: TextStyle(color: Colors.black),cursorColor: Colors.black45,
                  controller: _searchController,onTapOutside: (val){FocusManager.instance.primaryFocus?.unfocus();},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search Event Name",
                    hintStyle: TextStyle(color: Colors.black45),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Obx((){
            if(searchResults.isEmpty){
              return SizedBox(height: Get.height,
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: eventList.length,shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var event = eventList[index];
                    return eventCard(
                      event,
                          () => Get.to(() => EventsScreen(
                        event: event,
                        fromMyEvents: false.obs,
                      )),
                      homeController,
                    );
                  },
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
              );
            }

           else{
              return  SizedBox(height: Get.height,
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: searchResults.length,shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var event = searchResults[index];
                    return eventCard(
                      event,
                          () => Get.to(() => EventsScreen(
                        event: event,
                        fromMyEvents: false.obs,
                      )),
                      homeController,
                    );
                  },
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
              );
            }
          })
        ],
      ),
    );
  }
}
