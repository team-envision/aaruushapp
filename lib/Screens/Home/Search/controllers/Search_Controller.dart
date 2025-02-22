import 'package:AARUUSH_CONNECT/Screens/Home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../state/Search_State.dart';

class SearchBarController extends GetxController{
  final HomeController homeController;
  final SearchState state;

  SearchBarController({required this.homeController, required this.state});

@override
  void onInit() {
    super.onInit();
    _initialList();
    state.searchController.addListener(onSearchChanged);
  }

  @override
  void dispose() {
    state.searchController.removeListener(onSearchChanged);
    state.searchController.dispose();
    state.scrollController1.dispose();
    state.scrollController2.dispose();
    super.dispose();
  }

  void onSearchChanged() {
    state.eventList.value = homeController.state.eventList.where((event) =>event.startdate != null).toList();
    state.query.value = state.searchController.text.toLowerCase();
    state.searchResults.value = homeController.state.eventList
        .where((event) =>
    event.name!.toLowerCase().contains(state.query.value) &&
        event.startdate != null)
        .toList();
    state.searchResults.sort((a, b) => DateTime.parse(a.startdate!).compareTo(DateTime.parse(b.startdate!)));

  }

  void _initialList() {
    state.eventList.value = homeController.state.eventList
        .where((event) =>
     event.startdate != null)
        .toList();
    state.eventList.sort((a, b) => DateTime.parse(a.startdate!).compareTo(DateTime.parse(b.startdate!)));
  }

}

