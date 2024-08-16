import 'dart:ui';

import 'package:flutter/material.dart';

class horizontalScrollCards extends StatefulWidget {
  const horizontalScrollCards({super.key});

  @override
  State<horizontalScrollCards> createState() => _horizontalScrollCardsState();
}

class _horizontalScrollCardsState extends State<horizontalScrollCards> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,

        itemCount: 5,
        itemBuilder: (BuildContext context,int index){
      return const Buildcard(cardColor: Colors.transparent, cardIcon: Icons.gamepad);
    });
  }
}

class Buildcard extends StatelessWidget {
  final Color cardColor;
  final IconData cardIcon;
  const Buildcard({super.key, required this.cardColor, required this.cardIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        child: Stack(
          children: [
            ClipRRect(child: ImageFiltered(imageFilter: ImageFilter.blur(sigmaX: 71,sigmaY: 71))),
            SizedBox(
              width: 90,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Colors.transparent,
                shape:  RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white,
                  width: 1
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Icon(cardIcon,color: const Color(0xFFEF6522),)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
