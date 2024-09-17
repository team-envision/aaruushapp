import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSlide extends StatefulWidget {
  const ImageSlide({super.key});

  @override
  State<ImageSlide> createState() => _ImageSlideState();
}

class _ImageSlideState extends State<ImageSlide> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  List<String> ListImage = [
    'assets/images/aaruush.png',
    'assets/images/aaruush.png',
    'assets/images/aaruush.png',
    'assets/images/aaruush.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
              height: 170,
              child: PageView.builder(
                controller: controller,
                itemCount: ListImage.length,
                itemBuilder: (_, index) {
                  return Container(
                      width: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white)),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(ListImage[index], fit: BoxFit.cover),
                      ));
                },
              )),
        ),
        SmoothPageIndicator(
          controller: controller,
          count: ListImage.length,
          effect: const JumpingDotEffect(
            dotHeight: 16,
            dotColor: Colors.white,
            dotWidth: 14,
            jumpScale: .7,
            verticalOffset: 20,
            activeDotColor: Colors.deepOrange,
          ),
        )
      ],
    );
  }
}
