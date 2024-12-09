import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../Model/Events/event_list_model.dart';
import '../../Utilities/aaruushappbar.dart';
import '../../Utilities/custom_sizebox.dart';
import '../../components/bg_area.dart';
import '../../components/ticketWidget.dart';
import '../Home/home_controller.dart';
import '../QrPage/QrGenerator.dart';

class TicketDisplayPage extends StatelessWidget {
  const TicketDisplayPage({super.key, required this.event});
  final EventListModel event;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomeController>(HomeController());
    final qrDetails = '''emailid:${controller.common.emailAddress.value},
aaruushId:${controller.common.aaruushId.value},eventId:${event.id}''';

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AaruushAppBar(title: "Aaruush", actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton.outlined(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            onPressed: () => {Navigator.pop(context)},
            icon: const Icon(Icons.close_rounded),
            color: Colors.white,
            iconSize: 25,
          ),
        )
      ]),
      body: BgArea(child: Column(
        children: [
          sizeBox(20, 0),
          SafeArea(
            child: Center(
              child: SizedBox(
                height: Get.height * 0.8,
                width: Get.width * 0.8,
                child: TicketWidget(
                  width: Get.width * 0.8,
                  height: Get.height * 0.8,
                  isCornerRounded: true,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        sizeBox(20, 0),
                        Text(
                          'Aaruush ${event.category}',
                          style: const TextStyle(
                            fontFamily: 'Xirod',
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        sizeBox(20, 0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                              color: Get.theme.colorPrimary,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text("Ticket Details",
                              style: Get.theme.kSmallTextStyle),
                        ),
                        sizeBox(50, 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Flexible ensures that widgets don't cause overflow
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text("Date:",
                                            style: Get.theme.kVerySmallTextStyle
                                                .copyWith(
                                                color: Get.theme.curveBG
                                                    .withOpacity(0.8))),
                                        Text(event.date!,
                                            style: Get.theme.kVerySmallTextStyle
                                                .copyWith(
                                                fontSize: 12,
                                                color: Get.theme.curveBG
                                                    .withOpacity(0.8))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text("Time:",
                                            style: Get.theme.kVerySmallTextStyle
                                                .copyWith(
                                                color: Get.theme.curveBG
                                                    .withOpacity(0.8))),
                                        Text(event.time!,
                                            style: Get.theme.kVerySmallTextStyle
                                                .copyWith(
                                                fontSize: 12,
                                                color: Get.theme.curveBG
                                                    .withOpacity(0.8))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text("Venue:",
                                            style: Get.theme.kVerySmallTextStyle
                                                .copyWith(
                                                color: Get.theme.curveBG
                                                    .withOpacity(0.8))),
                                        Text(
                                          event.location ??
                                              event.mode ??
                                              "N/A",
                                          style: Get.theme.kVerySmallTextStyle
                                              .copyWith(
                                            fontSize: 12,
                                            overflow: TextOverflow.clip,
                                            color: Get.theme.curveBG
                                                .withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text("Ticket Type:",
                                            style: Get.theme.kVerySmallTextStyle
                                                .copyWith(
                                                color: Get.theme.curveBG
                                                    .withOpacity(0.8))),
                                        Text(event.payment_type!,
                                            style: Get.theme.kVerySmallTextStyle
                                                .copyWith(
                                                fontSize: 12,
                                                color: Get.theme.curveBG
                                                    .withOpacity(0.8))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        sizeBox(50, 0),
                        QrGeneratorFunc(
                            qrGeneratingString: qrDetails.toString()),
                        sizeBox(20, 0),
                        if (event.timeline != null)
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Html(
                              data: event.timeline ?? "",
                              style: {
                                "body": Style(
                                    color: Colors.black,
                                    fontSize: FontSize(14))
                              },
                            ),
                          ),
                        Text("Scan the QR code at the venue",
                            style: Get.theme.kVerySmallTextStyle
                                .copyWith(color: Get.theme.curveBG)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
