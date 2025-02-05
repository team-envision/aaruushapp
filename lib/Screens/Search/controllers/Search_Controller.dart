import 'package:AARUUSH_CONNECT/Screens/Home/controllers/home_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/state/Home_State.dart';
import 'package:AARUUSH_CONNECT/Screens/Search/state/Search_State.dart';
import 'package:get/get.dart';

class SearchBarController extends GetxController{
  final HomeController homeController;
  final SearchState state;

  SearchBarController({required this.homeController, required this.state});

@override
  void onInit() {
    super.onInit();
    _initialList();
    state.searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    state.searchController.removeListener(_onSearchChanged);
    state.searchController.dispose();
    state.scrollController1.dispose();
    state.scrollController2.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = state.searchController.text.toLowerCase();
    state.searchResults.value = homeController.state.eventList
        .where((event) =>
    event.name!.toLowerCase().contains(query) &&
        event.startdate != null &&
        event.edition == 'a24')
        .toList();
  }

  void _initialList() {
    state.eventList.value = homeController.state.eventList
        .where((event) =>
    event.live! && event.startdate != null && event.edition == 'a24')
        .toList();
  }

}

