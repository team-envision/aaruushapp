import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Autoplay extends StatelessWidget {
  final PageController controller = PageController(viewportFraction: 0.8, keepPage: true);
  final List<String> ListImage = [
    'assets/images/img.png',
    'assets/images/img_1.png',
    'assets/images/img_2.png',
    'assets/images/img_3.png'
  ];

  Autoplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: ListImage.length, // Set the number of items
          options: CarouselOptions(
            height: 170.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
          ),
          itemBuilder: (context, index, realIndex) {
            final image = ListImage[index];
            return Container(
              height: 3,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        // Uncomment this section if you want to add the SmoothPageIndicator
        // SmoothPageIndicator(
        //   controller: controller,
        //   count: ListImage.length,
        //   effect: const JumpingDotEffect(
        //     dotHeight: 16,
        //     dotColor: Colors.white,
        //     dotWidth: 14,
        //     jumpScale: .7,
        //     verticalOffset: 20,
        //     activeDotColor: Colors.deepOrange,
        //   ),
        //  ),
      ],
    );
  }
}
