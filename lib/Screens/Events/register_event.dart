import 'package:aarush/Screens/Events/events_controller.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/components/bg_area.dart';
import 'package:aarush/components/primaryButton.dart';
import 'package:aarush/components/dropdown_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Model/Events/event_list_model.dart';
import '../../components/profile_text_field.dart';
import '../../components/white_box.dart';

class RegisterEvent extends GetView<EventsController> {
  const RegisterEvent({Key? key, required this.event}) : super(key: key);

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
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: Text(
          "AARUUSH",
          style: Get.theme.kTitleTextStyle.copyWith(fontFamily: 'Xirod'),
        ),
      ),
      body: BgArea(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizeBox(150, 0),
          WhiteBox(
            width: Get.width,
            margin: const EdgeInsets.all(20),
            child: Form(
              key: controller.registerFormKey,
              child: Column(
                children: [
                  sizeBox(50, 0),
                  if (event.dynamicform != null)
                    ...event.dynamicform!.map((e) {
                      if (e.type == "select") {
                        return Obx(() => dropDownSelector(
                          hint: e.label!,
                          list: e.options!.split(','),
                          onChanged: (v) {
                            controller.registerFieldData.value[e.label!] = v;
                          },
                          value: controller.registerFieldData.value[e.label],
                        ));
                      } else {
                        return profileTextField(
                          validator: (v) {
                            if (e.type == "email" && e.required!) {
                              if (!GetUtils.isEmail(v!)) {
                                return 'Please enter a valid email';
                              }
                            } else if (e.type == "tel" && e.required!) {
                              if (!GetUtils.isPhoneNumber(v!)) {
                                return 'Please enter a valid phone number';
                              }
                            }
                            return null;
                          },
                          keyboard: e.type == "email"
                              ? TextInputType.emailAddress
                              : e.type == "tel"
                              ? TextInputType.phone
                              : TextInputType.text,
                          initialValue: controller.userDetails.value[e.label],
                          onChanged: (v) {
                            controller.registerFieldData.value[e.label!] = v;
                            debugPrint("${e.label} $v");
                          },
                          label: e.placeholder ?? "",
                        );
                      }
                    }),
                  sizeBox(20, 0),
                  Obx(
                        () => controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : primaryButton(
                      text: "Submit data",
                      onTap: () {
                        if (controller.registerFormKey.currentState!.validate() &&
                            event.dynamicform != null) {
                          for (var e in event.dynamicform!) {
                            controller.registerFieldData.value
                                .addAllIf(
                              controller.userDetails.value[e.label] !=
                                  null,
                              {e.label!: controller.userDetails.value[e.label]},
                            );
                          }
                          debugPrint(
                              "Register data ${controller.registerFieldData.value}");
                          controller.registerEvent(e: event);
                        }
                      },
                    ),
                  ),
                  sizeBox(50, 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
