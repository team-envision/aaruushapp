import 'package:aarush/Themes/themes.dart';
import 'package:aarush/components/aaruushappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Model/Events/event_list_model.dart';
import '../../Utilities/appBarBlur.dart';
import '../Home/home_controller.dart';
import '../QrPage/QrGenerator.dart';

class TicketDisplayPage extends StatelessWidget {
  const TicketDisplayPage({super.key, required this.event});
  final EventListModel event;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomeController>(HomeController());
    final qrDetails = {
      "email": controller.common.emailAddress.value,
      "aaruushId": controller.common.aaruushId.value,
      "event": event.id
    };
    return SafeArea(
        child: Scaffold(
      appBar: AaruushAppBar(title: "Aaruush"),
      body: AspectRatio(
        aspectRatio: 291 / 543,
        child: Stack(
          children: <Widget>[
            Center(
                child:
                    SvgPicture.asset('assets/images/icons/GroupTicketBg.svg')),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 7,
                  ),
                  child: Container(
                    alignment: Alignment.topCenter,
                    constraints: BoxConstraints(maxWidth: Get.width),
                    child: Text(
                      'Aaruush ${event.category}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Xirod',
                          color: Colors.black,
                          fontSize: 16),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 20,
                              left: MediaQuery.of(context).size.width / 10),
                          child: const Text(
                            'DATE',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10,
                              left: MediaQuery.of(context).size.width / 5.5),
                          child: Text(
                            event.date ?? "N/A",
                            style: TextStyle(
                                color: Color(0xFF646464), fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 5,
                            top: MediaQuery.of(context).size.height / 20,
                          ),
                          child: const Text(
                            'TIME',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10,
                              left: MediaQuery.of(context).size.width / 5.5),
                          child: Text(
                            event.time ?? "N/A",
                            style: TextStyle(
                                color: Color(0xFF646464), fontSize: 15),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 20,
                              left: MediaQuery.of(context).size.width / 10),
                          child: const Text(
                            'VENUE',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10,
                              left: MediaQuery.of(context).size.width / 5.5),
                          child: Text(
                            event.location ?? "N/A",
                            style: TextStyle(
                                color: Color(0xFF646464), fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 5,
                            top: MediaQuery.of(context).size.height / 20,
                          ),
                          child: const Text(
                            'TICKET TYPE',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10,
                              left: MediaQuery.of(context).size.width / 5.5),
                          child: Text(
                            event.payment_type ?? "N/A",
                            style: TextStyle(
                                color: Color(0xFF646464), fontSize: 15),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                QrGeneratorFunc(
                  qrGeneratingString: qrDetails.toString(),
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 20),
                  child: const Text(
                    'Scan this QR code at the venue to enter',
                    style: TextStyle(
                        color: Color(0xFF646464),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
