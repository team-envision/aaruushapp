import 'dart:ui';
import 'package:AARUUSH_CONNECT/Screens/Notification/NotificationController.dart';
import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

var notifications;

class NotificationScreen extends GetView<NotificationController> {
  NotificationScreen({super.key});

  NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AaruushAppBar(
        title: "NOTIFICATIONS",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SizedBox(
              height: 35,
              width: 35,
              child: IconButton.outlined(
                padding: EdgeInsets.zero,
                onPressed: () => {Navigator.pop(context)},
                icon: const Icon(Icons.close_rounded),
                color: Colors.white,
                iconSize: 20,
              ),
            ),
          ),
        ],
      ),
      body: BgArea(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 8),
            Expanded(
              child: FutureBuilder<dynamic>(
                future: controller.loadNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                          child: Text("No notifications available"));
                    } else if (snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No notifications available'));
                    } else {
                      notifications = snapshot.data!;
                      notifications = notifications.toList();

                      return LiveList.options(
                        padding: EdgeInsets.only(bottom: 0.4 * Get.width),
                        physics: const RangeMaintainingScrollPhysics(),
                        itemCount: notifications.length,
                        itemBuilder: notificationCard,
                        options: const LiveOptions(
                          showItemInterval: Duration(milliseconds: 200),
                          showItemDuration: Duration(milliseconds: 300),
                          visibleFraction: 0.05,
                          reAnimateOnVisibility: false,
                        ),
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget notificationCard(
  BuildContext context,
  int index,
  Animation<double> animation,
) {
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
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      // And slide transition
      child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          // Paste you Widget
          child: Theme(
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
          )),
    );
  } else {
    return notification['title'] != null
        ? FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            // And slide transition
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.1),
                end: Offset.zero,
              ).animate(animation),
              // Paste you Widget
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                  child: Card(
                    child: ListTile(
                      minVerticalPadding: 5,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ),
              ),
            ))
        : const SizedBox.shrink();
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
