import 'package:AARUUSH_CONNECT/Screens/Events/events_controller.dart';
import 'package:AARUUSH_CONNECT/Utilities/custom_sizebox.dart';
import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
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
      appBar: AaruushAppBar(
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

        title:
            "AARUUSH",
      ),
      body: BgArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 8),
                CustomBox(
                  margin: const EdgeInsets.all(20),
                  boxShadowOpacity: 0.4,
                  colourOpacity: 0.3,
                  child: Form(
                    key: controller.registerFormKey,
                    child: Column(
                      children: [
                        sizeBox(30, 0),
                        const Text(
                          "REGISTER FOR EVENTS",
                          style: TextStyle(fontFamily: "Xirod"),
                        ),
                        sizeBox(25, 0),
                        if (event.dynamicform != null)
                          ...event.dynamicform!.map((e) {
                            if (e.type == "select") {
                              return Obx(() => dropDownSelector(
                                    hint: e.label ?? "Select",
                                    list: e.options?.split(',') ?? [],
                                    onChanged: (val) {
                                      controller.registerFieldData[e.label] = val;
                                    },
                                    value:
                                        controller.registerFieldData[e.label] ?? "",
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
                                initialValue: e.label!.toLowerCase() == "name"
                                    ? controller.common.userName.toString()
                                    : (e.label!.toLowerCase() ==
                                                "college (na if not applicable)" ||
                                            e.label!.toLowerCase() ==
                                                "college name")
                                        ? controller.common.college.toString()
                                        : (e.label!.toLowerCase() ==
                                                    "registration number (na if not applicable)" ||
                                                e.label!.toLowerCase() ==
                                                    "registration number")
                                            ? controller.common.RegNo.toString()
                                            : (e.label!.toLowerCase() ==
                                                        "phone number" ||
                                                    e.label!.toLowerCase() ==
                                                        "contact number")
                                                ? controller.common.phoneNumber
                                                    .toString()
                                                : (e.label!.toLowerCase() ==
                                                            "email id" ||
                                                        e.label!.toLowerCase() ==
                                                            "email")
                                                    ? controller.common.emailAddress
                                                        .toString()
                                                    : "",
                                onChanged: (v) {
                                  controller.registerFieldData.value[e.label!] = v;
                                  debugPrint("${e.label} $v");
                                },
                                label: e.label ?? e.placeholder ?? "",
                              );
                            }
                          }),
                        sizeBox(20, 0),
                        Obx(
                          () => controller.isLoading.value
                              ? Container(
                              height: Get.height,
                              width: Get.width,
                              color: Colors.black,
                              child:
                              Image.asset('assets/images/spinner.gif', scale: 4))
                              : SizedBox(
                                  width: 250,
                                  child: primaryButton(
                                    text: "Submit data",
                                    onTap: () {
                                      if (controller.registerFormKey.currentState!
                                              .validate() &&
                                          event.dynamicform != null) {
                                        for (var e in event.dynamicform!) {
                                          controller.registerFieldData.value
                                              .addAllIf(
                                            controller.userDetails.value[e.label] !=
                                                null,
                                            {
                                              e.label!: controller
                                                  .userDetails.value[e.label]
                                            },
                                          );
                                        }
                                        debugPrint(
                                            "Register data ${controller.registerFieldData.value}");
                                        controller.registerEvent(e: event);
                                      }
                                    },
                                  ),
                                ),
                        ),
                        sizeBox(30, 0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
