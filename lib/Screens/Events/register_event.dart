import 'package:AARUUSH_CONNECT/Screens/Events/events_controller.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/Utilities/custom_sizebox.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:AARUUSH_CONNECT/components/primaryButton.dart';
import 'package:AARUUSH_CONNECT/components/dropdown_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Model/Events/event_list_model.dart';
import '../../components/DynamicWhiteBox.dart';
import '../../components/profile_text_field.dart';

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
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: Text(
          "AARUUSH",
          style: Get.theme.kTitleTextStyle.copyWith(fontFamily: 'Xirod'),
        ),
      ),
      body: SafeArea(
        child: BgArea(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomBox(
              margin: const EdgeInsets.all(20),
              child: Form(
                key: controller.registerFormKey,
                child: Column(
                  children: [
                    sizeBox(50, 0),
                    if (event.dynamicform != null)
                      ...event.dynamicform!.map((e) {
                        if (e.type == "select") {
                          print("e.label");
                          print(e.label);
                          return Obx(() => dropDownSelector(
                            hint: e.label ?? "Select",
                            list: e.options?.split(',') ?? [],
                            onChanged: (val) {
                              controller.registerFieldData[e.label] = val;
                            },
                            value: controller.registerFieldData[e.label] ?? "",
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
                                : (e.type == "tel" || e.type == "number")
                                ? TextInputType.phone
                                : TextInputType.text,
                            initialValue: e.label == "Name"? controller.common.userName.toString():e.label=="College (NA if not applicable)"?controller.common.college.toString():e.label=="Registration Number (NA if not applicable)"?controller.common.RegNo.toString():e.label=="Phone Number"?controller.common.phoneNumber.toString():e.label=="Email ID"?controller.common.emailAddress.toString():"",
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
      ),
    );
  }
}
