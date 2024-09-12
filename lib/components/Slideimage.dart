import 'package:flutter/material.dart';
class SlideImage extends StatelessWidget {
  const SlideImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 180,
        width: 280,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white
        ),


      ),
    );
  }
}
