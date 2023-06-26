// import 'package:aarush/Common/common_controller.dart';
// import 'package:aarush/Data/api_data.dart';
// import 'package:aarush/Model/Events/event_list_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart';

// class EventsController extends GetxController {
//   var userAttributes = <String, String>{}.obs;
//   var userDetails = <String, dynamic>{}.obs;
//   var registerFieldData = <String, dynamic>{};
//   List<TextEditingController> textEditingControllerList = [];

//   CommonController common = Get.find();
//   final registerFormKey = GlobalKey<FormState>();

//   Future<void> loadAttributes() async {
//     var data = await common.fetchCurrentUserAttributes();
//     userAttributes.value = {
//       "name": data['name'],
//       "image": data['picture'],
//       "email": data['email'],
//     };
//   }

//   @override
//   void onInit() async {
//     userDetails.value = await common.getUserDetails();
//     super.onInit();
//   }

//   Future<void> registerEvent({required EventListModel event}) async {
//     for (var e in event.reqdfields!) {
//       registerFieldData.addAll({
//         e.value: textEditingControllerList[event.reqdfields!.indexOf(e)].text
//       });
//     }
//     debugPrint("DATA : ${{...registerFieldData, event: event.toJson()}} %%%%%%%%%%%%%%%%%%%%");
//     // try {
//     //   final response = await post(
//     //       Uri.parse(
//     //           'https://api.aaruush.org/api/v1/events/${event.category}/${event.id}/register'),
//     //       headers: {
//     //         'Content-type': 'application/json',
//     //         'Accept': 'application/json',
//     //         'Authorization': ApiData.accessToken
//     //       },
//     //       body: {
//     //         ...registerFieldData,
//     //         event:event
//     //       });
//     //   if (response.statusCode == 200 || response.statusCode == 201) {
//     //     debugPrint("EVENT REGISTERED");
//     //   } else {
//     //     throw Exception('Failed to register event ${response.body}');
//     //   }
//     // } catch (e) {
//     //   debugPrint(e.toString());
//     // }
//     registerFieldData.clear();
//   }

//   @override
//   void onClose() {
//     for (var controller in textEditingControllerList) {
//       controller.dispose();
//     }
//     super.onClose();
//   }
// }
