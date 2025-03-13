import 'dart:convert';
import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Common/core/Routes/app_routes.dart';
import 'package:AARUUSH_CONNECT/Common/core/Utils/Logger/app_logger.dart';
import 'package:AARUUSH_CONNECT/Data/api_data.dart';
import 'package:AARUUSH_CONNECT/Model/Events/event_list_model.dart';
import 'package:AARUUSH_CONNECT/Screens/Home/controllers/home_controller.dart';
import 'package:AARUUSH_CONNECT/Utilities/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../state/Events_State.dart';

class EventsController extends GetxController {
  EventsController({required this.state,required this.homeController,required this.commonController});
 final EventsState state;
 final HomeController homeController;



final CommonController commonController;
  final registerFormKey = GlobalKey<FormState>();
  
  @override
  Future<void> onInit() async {
    super.onInit();

    // _initializeEventData();
    final eventId = Get.parameters['EventId'];
    Log.debug(eventId);
    await fetchEventData(eventId!);

  }



  // Future<void> _initializeEventData() async {
  //   if (widget.fromNotificationRoute && widget.EventId != nul
  //     await fetchEventData(widget.EventId!);
  //
  //     eventData = controller.eventData.value;
  //
  //     controller.checkRegistered(eventData);
  //
  //     controller.getUser().then((_) async {
  //       controller.checkRegistered(controller.eventData.value);
  //       eventData = controller.eventData.value;
  //     });
  //   } else if (!widget.fromNotificationRoute && widget.event != null) {
  //     controller.eventData.value = widget.event!;
  //     controller.getUser().then((_) async {
  //       controller.checkRegistered(controller.eventData.value);
  //       eventData = controller.eventData.value;
  //     });
  //   }
  // }


  Future<void> getUser() async {
    try {
      state.userDetails.value = await commonController.getUserDetails() ?? {};
    } catch (e,stacktrace) {
      Log.verbose('Error fetching user details: $e',[e,stacktrace]);
      setSnackBar(
        'Error:',
        'Failed to fetch user details',
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.red),
      );
    }

    // Log.info(state.userDetails.keys.toList());
    // state.userDetails.keys.map((val) {
    //   Log.info(val);
    // });

  }

  Future<void> registerEvent({required EventListModel e}) async {
    state.isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('${ApiData.API}/events/${e.category}/${e.id}/register'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': ApiData.accessToken,
        },
        body: json.encode({
          ...?state.registerFieldData.value,
          "aaruushId": state.userDetails["aaruushId"] ?? '',
          'email': state.userDetails['email'] ?? '',
          'events': state.userDetails['events'] ?? [],
          'event': e.toMap(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userRes = await http.put(
          Uri.parse('${ApiData.API}/users'),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': ApiData.accessToken,
          },
          body: json.encode({
            ...?state.registerFieldData.value,
            "aaruushId": state.userDetails['aaruushId'] ?? '',
            "email": state.userDetails['email'] ?? '',
            "events": [...?state.userDetails['events'] ?? [], e.id],
          }),
        );

        if (userRes.statusCode == 200 ||
            userRes.statusCode == 201 ||
            userRes.statusCode == 202) {
          setSnackBar(
            'SUCCESS:',
            'Event registered successfully',
            icon: const Icon(Icons.check_circle_outline_rounded,
                color: Colors.green),
          );
        } else {
          setSnackBar(
            'ERROR:',
            json.decode(userRes.body)['message'] ?? 'Unknown error',
            icon: const Icon(Icons.warning_amber_rounded, color: Colors.red),
          );
        }
      } else {
        setSnackBar(
          'ERROR:',
          json.decode(response.body)['message'] ?? 'Unknown error',
          icon: const Icon(Icons.warning_amber_rounded, color: Colors.red),
        );
      }
    } catch(e,stacktrace) {
      Log.verbose('Error registering event:',[e,stacktrace]);
      setSnackBar(
        'ERROR:',
        'Something went wrong',
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.red),
      );
    } finally {
      state.registerFieldData.clear();
      state.isLoading.value = false;
      Get.offAllNamed(AppRoutes.stage);
    }
  }

  void openMapWithLocation(String latitude, String longitude) async {
    final mapUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");

    if (await canLaunchUrl(mapUrl)) {
      await launchUrl(mapUrl);
    } else {
      Log.warning("Cannot launch map url");
    }
  }

  void checkRegistered(EventListModel e) {
    state.isEventRegistered.value = state.userDetails['events']?.contains(e.id) ?? false;
  }

  Future<void> fetchEventData(String eventId) async {
    state.isLoading.value = true;

   if(Get.arguments != null && Get.arguments.containsKey("event")){
     Log.debug(Get.arguments["event"]);
     state.eventData.value ??= await  Get.arguments["event"];
     state.isLoading.value = false;
     return;
   }
   else {
     Log.debug("Get.arguments is null or does not contain the 'event' key");
   }

    try {
      RxList<EventListModel>? jsonResponse;
      // jsonResponse.value = await commonController.fetchEventData() ?? [];
      if(jsonResponse!.isEmpty){
        state.isLoading.value = false;
        setSnackBar("Message", "Data Not Found");
        return;
      }

        List<EventListModel> filteredLiveEvents =
            jsonResponse.where((event) => event.id == eventId).toList();
      state.eventData.value =
            filteredLiveEvents.map((e) => e).first;

    } catch(e,stacktrace) {
      Log.verbose('Error fetching events:',[e,stacktrace]);
    } finally {
      state.isLoading.value = false;
    }
  }






}
