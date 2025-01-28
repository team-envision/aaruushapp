import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../Services/notificationServices.dart';

class NotificationController extends GetxController{

  Future<dynamic> loadNotifications() async {

    var box1 = await Hive.openBox('notifications');
    var box2 = await Hive.openBox('BackgroundNotifications');


    var notifications = box1.values.toList();


    if (box2.isNotEmpty) {
      notifications.addAll(box2.values.where((value) => value != null).toList());
    }


    notifications.sort((a, b) {
      DateTime dateA = parseDateTime(a['receivedAt']);
      DateTime dateB = parseDateTime(b['receivedAt']);
      return dateB.compareTo(dateA); // Sort by most recent first
    });

    return notifications;
  }

  DateTime parseDateTime(dynamic date) {
    if (date is String) {
      return DateTime.parse(date);
    } else if (date is DateTime) {
      return date;
    } else {
      return DateTime.now();
    }
  }

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    NotificationServices notificationServices = NotificationServices();
    notificationServices.requestNotificationPermission();
  }


}