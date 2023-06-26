// ignore_for_file: invalid_use_of_protected_member

import 'package:aarush/Screens/Events/events_controller.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/components/bg_area.dart';
import 'package:aarush/components/primaryButton.dart';
import 'package:aarush/components/white_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Model/Events/event_list_model.dart';
import '../../components/text_field.dart';

class RegisterEvent extends GetView<EventsController> {
  const RegisterEvent({super.key, required this.event});
  final EventListModel event;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => {Get.back()},
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          title: Text(
            "AARUUSH",
            style: Get.theme.kTitleTextStyle.copyWith(fontFamily: 'Xirod'),
          ),
        ),
        body: BgArea(crossAxisAlignment: CrossAxisAlignment.center, children: [
          sizeBox(150, 0),
          WhiteBox(
              width: Get.width,
              margin: const EdgeInsets.all(20),
              child: Form(
                  key: controller.registerFormKey,
                  child: Column(
                    children: [
                      sizeBox(50, 0),
                      // if (event.reqdfields != null)
                      //   Text(
                      //     'Enter "null" for optional data',
                      //     style: Get.theme.kSubTitleTextStyle
                      //         .copyWith(color: Colors.black87),
                      //   ),
                      // sizeBox(30, 0),
                      if (event.reqdfields != null)
                        ...event.reqdfields!.map((e) {
                          return textField(
                              validator: (v) {
                                if (e.value.toLowerCase().contains('email')) {
                                  if (!GetUtils.isEmail(v!)) {
                                    return 'Please enter a valid email';
                                  }
                                } else if (e.value
                                        .toLowerCase()
                                        .contains('phone') ||
                                    e.value
                                        .toLowerCase()
                                        .contains('whatsapp') ||
                                    e.value.toLowerCase().contains('contact')) {
                                  if (!GetUtils.isPhoneNumber(v!)) {
                                    return 'Please enter a valid phone number';
                                  }
                                } else if (e.value
                                    .toLowerCase()
                                    .contains('registration')) {
                                  if (v!.isEmpty) {
                                    return 'Please enter a valid registration number';
                                  }
                                }
                                return null;
                              },
                              keyboard: e.value.toLowerCase().contains('email')
                                  ? TextInputType.emailAddress
                                  : e.value.toLowerCase().contains('phone') ||
                                          e.value
                                              .toLowerCase()
                                              .contains('whatsapp') ||
                                          e.value
                                              .toLowerCase()
                                              .contains('contact')
                                      ? TextInputType.phone
                                      : TextInputType.text,
                              initialValue:
                                  controller.userDetails.value[e.value],
                              onChanged: (v) {
                                controller.registerFieldData
                                    .addAll({e.value: v});
                              },
                              label: e.label);
                        }),
                      sizeBox(20, 0),
                      Obx(
                        () => controller.isLoading.value
                            ? const CircularProgressIndicator()
                            : primaryButton(
                                text: "Submit data",
                                onTap: () {
                                  if (controller.registerFormKey.currentState!
                                          .validate() &&
                                      event.reqdfields != null) {
                                    for (var e in event.reqdfields!) {
                                      controller.registerFieldData.addAllIf(
                                          controller
                                                  .userDetails.value[e.value] !=
                                              null,
                                          {
                                            e.value: controller
                                                .userDetails.value[e.value]
                                          });
                                    }
                                    controller.registerEvent(e: event);
                                    // Get.back()
                                  }
                                }),
                      ),
                      sizeBox(50, 0),
                    ],
                  )))
        ]));
  }
}
