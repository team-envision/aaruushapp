import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:get/get.dart';

class EventsState extends GetXState{
  final screenWidth = Get.width;
  final screenHeight = Get.height;


  var userDetails = {}.obs;
  var registerFieldData = {}.obs;
  RxString changeInDropDown = "ALL".obs;
  RxBool isLoading = false.obs;
  RxBool isEventRegistered = false.obs;
  var eventData = Rxn<EventListModel>();
  RxList locations = [].obs;


}