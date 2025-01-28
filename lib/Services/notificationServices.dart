import 'dart:convert';
import 'dart:io';
import 'package:AARUUSH_CONNECT/Screens/Events/views/events_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Screens/Notification/views/NotificationScreen.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _saveNotification(message);
        handleMessage(context, message);
      },
    );
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      _saveNotification(message);

      String? url = message.data['url'];
      if (kDebugMode) {
        print(message);
      }
      if (url != null && url.isNotEmpty) {
        print(message.data["url"]);
      } else {
        print(notification!.body);
      }

      if (kDebugMode) {
        print("Notification title: ${notification?.title}");
        print("Notification body: ${notification?.body}");
        if (android != null) {
          print('Android notification count: ${android.count}');
          print('Android notification link: ${android.link}');
        }
        print('Notification data: ${message.data}');
      }

      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("User granted provisional permission");
    } else {
      debugPrint("User declined permission");
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId ?? 'default_channel',
      message.notification!.android!.channelId ?? 'Default Channel',
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      enableLights: true,
      ledColor: Colors.red,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'channel description',
      importance: Importance.max,
      enableLights: true,
      priority: Priority.max,
      category: AndroidNotificationCategory.promo,
      fullScreenIntent: true,
      playSound: true,
      groupAlertBehavior: GroupAlertBehavior.all,
      ticker: 'ticker',
      sound: channel.sound,
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            interruptionLevel: InterruptionLevel.active);

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    _flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title ?? 'No Title',
      message.notification!.body ?? 'No Body',
      notificationDetails,
    );
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    // When app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(context, initialMessage);
      _saveNotification(initialMessage);
    }

    // When app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (kDebugMode) {
        print('A new onMessageOpenedApp event was published!');
        print("app is in background");
        print(message.data);
      }
      handleMessage(context, message);
      // get_launch_url();
    });
  }

  Future<void> _saveNotification(RemoteMessage message) async {
    print("Notification saved");
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    // Open the Hive box
    var box = await Hive.openBox('notifications');

    // Store the notification
    await box.add({
      'title': message.notification?.title,
      'body': message.notification?.body,
      'linkAndroid': message.notification?.android?.imageUrl,
      'linkApple': message.notification?.apple?.imageUrl,
      'data': message.data,
      'receivedAt': DateTime.now(),
    });
  }

  Future<void> handleMessage(
      BuildContext context, RemoteMessage message) async {
    _saveNotification(message);
    String? url = message.data['url'];
    String? eventRoute = message.data['event'];

    if (url != null && url.isNotEmpty) {
      if (kDebugMode) {
        print("handleMessage1$url");
      }
      await launchUrl(Uri.parse(url));
    } else if (eventRoute != null && eventRoute.isNotEmpty) {
      if (kDebugMode) {
        print("eventroute");
      }
      Get.to(() => EventsScreen(
            fromNotificationRoute: true,
            EventId: eventRoute,
            fromMyEvents: false.obs,
          ));
    } else {
      if (kDebugMode) {
        Get.to(NotificationScreen());
        print('No valid URL or key in the notification.');
        print(message);
      }
    }
  }

  // void get_launch_url() async {
  //   print("get_launch_url");
  //
  //   final prefs = await SharedPreferences.getInstance();
  //   String? url = prefs.getString('KEY_LAUNCH_URL');
  //   print("get_launch_url opened");
  //   print(url);
  //
  //   if (url != null && url.isNotEmpty) {
  //     final Uri linkUrl = Uri.parse(url);
  //
  //     if (await canLaunchUrl(linkUrl)) {
  //       if (kDebugMode) {
  //         print("launching");
  //       }
  //       await launchUrl(linkUrl);
  //       await prefs.remove("KEY_LAUNCH_URL");
  //     } else {
  //       if (kDebugMode) {
  //         print("Could not launch URL: $linkUrl");
  //       }
  //     }
  //   } else {
  //     if (kDebugMode) {
  //       print("get_launch_url: No URL found or empty");
  //     }
  //   }
  // }

  Future<void> forgroundMessage() async {
    print("forgroundMessage");
    // get_launch_url();
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      await _saveNotification(message!);
    }
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }
}
