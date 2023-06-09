// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BgArea extends StatelessWidget {
  const BgArea({
    Key? key,
    required this.children,
    this.image = "bg.jpg",
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);
  final List<Widget> children;
  final String? image;
  final CrossAxisAlignment? crossAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.black87,
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
