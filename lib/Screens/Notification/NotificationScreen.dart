import 'dart:ui';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/components/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../Services/notificationServices.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    NotificationServices notificationServices = NotificationServices();
    notificationServices.requestNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AaruushAppBar(
        title: "AARUUSH",
        actions: [
          IconButton.outlined(
            padding: EdgeInsets.zero,
            onPressed: () => {Navigator.pop(context)},
            icon: const Icon(Icons.close_rounded),
            color: Colors.white,
            iconSize: 25,
          ),
        ],
      ),
      body: BgArea(
        children: [
          SafeArea(
            child: Text(
              "NOTIFICATIONS",
              style: Get.theme.kSubTitleTextStyle
                  .copyWith(color: Colors.grey, decoration: TextDecoration.underline),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                height: Get.height,
                child: FutureBuilder<dynamic>(
                  future: _loadNotifications(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Center(child: Text("No notifications available"));
                      } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No notifications available'));
                      } else {
                        var notifications = snapshot.data!;
                        notifications = notifications.toList();

                        return ListView.builder(
                          padding: EdgeInsets.only(bottom: 0.4 * Get.width),
                          physics: const RangeMaintainingScrollPhysics(),
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            var notification = notifications[index];


                            DateTime receivedAt;
                            if (notification['receivedAt'] is String) {

                              receivedAt = DateTime.parse(notification['receivedAt']);
                            } else if (notification['receivedAt'] is DateTime) {

                              receivedAt = notification['receivedAt'];
                            } else {

                              receivedAt = DateTime.now();
                            }

                            if (notification["linkAndroid"] != null) {
                              return Theme(
                                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  tilePadding: EdgeInsets.zero,
                                  showTrailingIcon: false,
                                  backgroundColor: Colors.transparent,
                                  collapsedBackgroundColor: Colors.transparent,
                                  title: kListTile(
                                    notification['title'] ?? '',
                                    timeago.format(receivedAt, locale: "en_short"),
                                    notification['body'] ?? '',
                                    notification["linkAndroid"] ?? "",
                                  ),
                                  children: [
                                    SizedBox(
                                      child: CachedNetworkImage(
                                        imageUrl: notification["linkAndroid"] ?? "",
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return notification['title'] != null
                                  ? BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                child: Card(
                                  child: ListTile(
                                    minVerticalPadding: 5,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 12),
                                    title: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: FittedBox(
                                            child: Text(
                                              notification['title'] ?? '',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text(
                                            timeago.format(receivedAt, locale: "en_short"),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(notification['body'] ?? ''),
                                  ),
                                ),
                              )
                                  : SizedBox.shrink();
                            }
                          },
                        );
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _loadNotifications() async {

    var box1 = await Hive.openBox('notifications');
    var box2 = await Hive.openBox('BackgroundNotifications');


    var notifications = box1.values.toList();


    if (box2.isNotEmpty) {
      notifications.addAll(box2.values.where((value) => value != null).toList());
    }


    notifications.sort((a, b) {
      DateTime dateA = _parseDateTime(a['receivedAt']);
      DateTime dateB = _parseDateTime(b['receivedAt']);
      return dateB.compareTo(dateA); // Sort by most recent first
    });

    return notifications;
  }

  DateTime _parseDateTime(dynamic date) {
    if (date is String) {
      return DateTime.parse(date);
    } else if (date is DateTime) {
      return date;
    } else {
      return DateTime.now();
    }
  }

  Widget kListTile(String title, String date, String subTitle, String url) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(date),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: Get.width - 100,
                    child: Text(
                      subTitle,
                      softWrap: true,
                      textWidthBasis: TextWidthBasis.parent,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(url),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
