import 'dart:convert';

import 'package:aarush/Screens/TimeLine/timeline_controller.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../components/aaruushappbar.dart';

class TimelineView extends GetView<TimelineController>{


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    extendBodyBehindAppBar: true,extendBody: true,
    backgroundColor: Colors.black,
    appBar: AaruushAppBar(title: "AARUUSH", actions: [
      IconButton(
        onPressed: () => {Get.back()},
        icon: const Icon(Icons.notifications_none_outlined),
        color: Colors.white,
        iconSize: 25,
      ),
    ]),
    body:FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString("assets/json/timeLine.json"),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if(snapshot.hasData){
            var data = jsonDecode(snapshot.data.toString());
            if(snapshot.connectionState == ConnectionState.done){
              return Padding(padding: EdgeInsets.all(10),
                child:  ListView.builder(itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top:20),
                    child: makeItem(image: data[index]["image"],date: 9,month: 'FEB',year: data[index]["year"],tagline: data[index]["tagline"],description: data[index]["description"]),

                  );
                },itemCount: 5,scrollDirection: Axis.vertical,
                ),);
            }
            else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            else{
              return Center(child: Text("Something Went Wrong"),);
            }
          }
          else{
            return
            Center(child: Text("Something Went Wrong"),);
          }

      },
    )
  );

  }

Widget makeItem({image,date,month,year,tagline,description}){

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
                  Text(date.toString(),style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'xirod'),),
                  Text(month.toString(),style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 18,fontFamily: 'xirod'),)
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
                fit: BoxFit.cover
              )
                        ),
                child: Container(
              
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.black.withOpacity(0.2),Colors.black.withOpacity(0.1)
                    ]
              
                    )
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 32,
                          width: 45,
                          child:Image.asset('assets/images/aaruush.png')
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("AARUUSH' "+year.toString(),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                          Text( tagline.toString() ,style: TextStyle(color: Colors.black,fontSize: 8,fontWeight: FontWeight.w300),),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 13,bottom: 7),
                        child: Icon(Icons.info),
                      )
              
              
                    ],
                  ),
              
                ),
                      ),
              back: Container(
                height: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.orange, // Border color
                    width: 3.0,        // Border width
                  ),

                ),
                child: Center(child: Text(description,style: TextStyle(color: Colors.white,fontFamily: 'xirod'),)),
              ),
            )
        )
      ],
    );
}

}