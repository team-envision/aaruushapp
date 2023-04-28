import 'dart:ui';

import 'package:flutter/material.dart';
class BottomItemsList extends StatelessWidget {
  const BottomItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Stack(
        children: [
          ClipRRect(
            child: ImageFiltered(imageFilter: ImageFilter.blur(sigmaX: 71,sigmaY: 71)),
          ),
          SizedBox(
            child: Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white,
                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: ListView.builder(
                itemCount: 10,
                  itemBuilder: (BuildContext context,int index){
                    return const Tileitem();
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Tileitem extends StatelessWidget {
  const Tileitem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        child: Row(
          children:  const <Widget>[
            Spacer(),
            Text('11-march-2023',style: TextStyle(fontFamily: 'Xirod'),),
            Spacer(),
            Text('Workshop1'),
            Spacer(),
            CircleAvatar(
              child: Image(image: NetworkImage('https://miro.medium.com/v2/resize:fit:828/format:webp/1*ijrDFseI9pdAX8pTsFvJ7g.jpeg'),)
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
