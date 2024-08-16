// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BgArea extends StatelessWidget {
  const BgArea({
    super.key,
    required this.children,
    this.image = "bg.png",
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });
  final List<Widget> children;
  final String? image;
  final CrossAxisAlignment? crossAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
            image: AssetImage('assets/images/$image'), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: crossAxisAlignment!,
          children: children,
        ),
      ),
    );
  }
}
