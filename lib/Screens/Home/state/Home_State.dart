import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:get/get.dart';

class HomeState extends GetXState {
  var eventList = <EventListModel>[].obs;
  var templiveEventList = <EventListModel>[].obs;
  var galleryList = [].obs;
  var tempGalleryList = [].obs;
  RxList LiveEventsList = [].obs;
  RxList regEvents = [].obs;
  var isLoading = false.obs;
  var sortName = "All".obs;
  RxString userName = "".obs;
  final List<String> catList = [
    "workshops",
    "hackathons",
    "initiatives",
    "panel-discussions",
    "domain-events",
    "events",
  ];
}
