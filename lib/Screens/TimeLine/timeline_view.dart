import 'dart:convert';
import 'package:aarush/Screens/TimeLine/timeline_controller.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/aaruushappbar.dart';

class TimelineView extends GetView<TimelineController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AaruushAppBar(title: "AARUUSH"),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString("assets/json/timeLine.json"),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (snapshot.hasData) {
            var data = jsonDecode(snapshot.data.toString());
            return Padding(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: makeItem(
                      image: data[index]["image"],
                      year: data[index]["year"],
                      tagline: data[index]["tagline"],
                      description: data[index]["description"],
                    ),
                  );
                },
                itemCount: data.length,
                scrollDirection: Axis.vertical,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something Went Wrong", style: TextStyle(color: Colors.white)),
            );
          } else {
            return Center(
              child: Text("No Data Available", style: TextStyle(color: Colors.white)),
            );
          }
        },
      ),
    );
  }

  Widget makeItem({required String image, required int year, required String tagline, required String description}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 200,
          margin: EdgeInsets.only(right: 20),
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: FittedBox(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Text(
                    year.toString(),
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'xirod',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: FlipCard(
            flipOnTouch: true,
            front: Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.1),
                    ],
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 32,
                      width: 45,
                      child: Image.asset('assets/images/aaruush.png'),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 13, bottom: 7),
                      child: Icon(Icons.info, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            back: Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.orange,
                  width: 3.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: Text(
                  description,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'xirod',
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
