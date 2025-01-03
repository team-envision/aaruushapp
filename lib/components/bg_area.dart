// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BgArea extends StatelessWidget {
  const BgArea({
    super.key,
    required this.child,
    this.image = "bg.png",
  });
  final Widget child;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
            image: AssetImage('assets/images/$image'), fit: BoxFit.cover),
      ),
      child: child,
    );
  }
}
