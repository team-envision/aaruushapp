import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/Home/home_controller.dart';

class Autoplay extends StatelessWidget {
  final homeController = Get.put(HomeController());

  Autoplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List imageList = homeController.galleryList;

      if (imageList.isEmpty) {
        return const Center(
          child: SizedBox(),
        );
      }

      return CarouselSlider.builder(
        itemCount: imageList.length,
        options: CarouselOptions(
          height: 225.0,
          autoPlay: true,
          animateToClosest: true,
          initialPage: 3,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          viewportFraction: 0.9,
        ),
        itemBuilder: (context, index, realIndex) {
          final imageUrl = imageList[index];

          return Container(
            height: 3,
            width: Get.width - 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: Container(
                      height: Get.height,
                      width: Get.width,
                      color: Colors.black,
                      child:
                          Image.asset('assets/images/spinner.gif', scale: 4)),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
