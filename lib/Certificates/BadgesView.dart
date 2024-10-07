import 'package:flutter/material.dart';

class Badgesview extends StatelessWidget {
  const Badgesview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Row(
        children:
        [Text("Certificates"),
          Text("Badges")
        ],),
    ]
    );

  }
}
