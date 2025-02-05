import 'package:AARUUSH_CONNECT/Screens/Stage/Widget/AaruushBottomBar.dart';
import 'package:AARUUSH_CONNECT/Screens/Stage/controllers/Stage_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StageView extends StatefulWidget {
  const StageView({super.key});

  @override
  State<StageView> createState() => _StageViewState();
}

class _StageViewState extends State<StageView> {
  final controller = Get.find<StageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: GetBuilder<StageController>(
        builder: (controller) =>  IndexedStack(
                index: controller.index.value,
                children: controller.pagesList,
              ),
      ),
      bottomNavigationBar: AaruushBottomBar()
    );
  }
}
