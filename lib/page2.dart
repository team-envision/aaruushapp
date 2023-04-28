import 'package:aarush/eventpage.dart';
import 'package:aarush/search.dart';
import 'package:flutter/material.dart';
import 'jsonextract.dart';
import 'main.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
List<dynamic> eventList=[];
int pg=0;
class page2 extends StatefulWidget {
  const page2({Key? key}) : super(key: key);

  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {

  @override
  initState()  {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width:   MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/bg2.jpg'),
                fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(onPressed: (){Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  SearchScreen()));

                  },
                    icon: Image.asset('images/profile.png'),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text("AARUUSH",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Xirod',
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  IconButton(onPressed: (){Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const eventpage()));}, icon: Icon(Icons.notifications_outlined),color: Colors.white,iconSize: 30,)
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 250,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:  CarouselSlider.builder(itemCount: eventList.length, itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        height: 400,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child:
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children:[

                            Container(
                              height: 400,
                                width: 400,
                                child: GestureDetector(
                                  onTap: (){Navigator.push(context,
                     MaterialPageRoute(builder: (context) => const eventpage()));
                                    pg=itemIndex;
                                    },
                                  child: Image.network(eventList[itemIndex]['image'],
                                  fit: BoxFit.contain,),
                                )),
                            Container(
                                height: 40,
                                width: 130,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.withOpacity(0.8),
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                child: TextButton(onPressed: (){launchlink();
                                print(eventList[itemIndex]['id']);}, child: Text("Register Now",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),))),

                          ],
                        ),
                      ),
                       options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                         enlargeFactor: 0.5,
                  ),
                  ),
                  // Row(
                  //   children: [
                  //
                  //     Container(
                  //       padding: const EdgeInsets.all(16.0),
                  //       height: 300,
                  //       decoration: BoxDecoration(
                  //         border: Border.all(width: 2, color: Colors.white),
                  //         borderRadius: BorderRadius.all(Radius.circular(40)),
                  //       ),
                  //       child:
                  //       Stack(
                  //         alignment: Alignment.bottomCenter,
                  //         children:[
                  //
                  //           Image.network(eventList[0]['image']),
                  //           Container(
                  //               height: 40,
                  //               width: 130,
                  //               decoration: BoxDecoration(
                  //                 color: Colors.blueGrey.withOpacity(0.8),
                  //                 borderRadius: BorderRadius.all(Radius.circular(20)),
                  //               ),
                  //               child: TextButton(onPressed: (){launchlink();
                  //                 print(eventList[0]['id']);}, child: Text("Register Now",
                  //                 style: TextStyle(
                  //                     color: Colors.white
                  //                 ),))),
                  //
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Container(
                  //       padding: const EdgeInsets.all(13.0),
                  //       height: 300,
                  //       decoration: BoxDecoration(
                  //         border: Border.all(width: 2, color: Colors.white),
                  //         borderRadius: BorderRadius.all(Radius.circular(40)),
                  //       ),
                  //       child:
                  //       Stack(
                  //         alignment: Alignment.bottomCenter,
                  //         children:[
                  //
                  //           GestureDetector(
                  //             onTap: (){Navigator.push(context,
                  //                 MaterialPageRoute(builder: (context) => const eventpage()));},
                  //             child: Image(image: AssetImage('images/event1.png'),
                  //             ),
                  //           ),
                  //           Container(
                  //               height: 40,
                  //               width: 130,
                  //               decoration: BoxDecoration(
                  //                 color: Colors.blueGrey.withOpacity(0.8),
                  //
                  //                 borderRadius: BorderRadius.all(Radius.circular(20)),
                  //               ),
                  //
                  //               child: TextButton(onPressed: (){}, child: Text("Register Now",
                  //                 style: TextStyle(
                  //                     color: Colors.white
                  //                 ),))),
                  //
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Container(
                  //       padding: const EdgeInsets.all(16.0),
                  //       height: 300,
                  //       decoration: BoxDecoration(
                  //         border: Border.all(width: 2, color: Colors.white),
                  //         borderRadius: BorderRadius.all(Radius.circular(40)),
                  //       ),
                  //       child:
                  //       Stack(
                  //         alignment: Alignment.bottomCenter,
                  //         children:[
                  //           Image(image: AssetImage('images/event3.png'),
                  //           ),
                  //           Container(
                  //               height: 40,
                  //               width: 130,
                  //               decoration: BoxDecoration(
                  //                 color: Colors.blueGrey.withOpacity(0.8),
                  //
                  //                 borderRadius: BorderRadius.all(Radius.circular(20)),
                  //               ),
                  //
                  //               child: TextButton(onPressed: (){}, child: Text("Register Now",
                  //                 style: TextStyle(
                  //                     color: Colors.white
                  //                 ),))),
                  //
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              ),

              // Container(
              //   margin:const EdgeInsets.all(14),
              //   height: 700.0,
              //
              //   padding: const EdgeInsets.all(7),
              //   width: 500.0,
              //   decoration: const BoxDecoration(
              //       borderRadius: BorderRadius.all(Radius.circular(37)),
              // ),
              //   child:
              //   Column(
              //
              //     children:  [
              //       const Padding(
              //         padding: EdgeInsets.only(top: 10),
              //       ),
              //       const Align(
              //
              //         alignment: Alignment.center,
              //         child: Text(
              //           'Our Workshops',
              //           style: TextStyle(fontSize: 35,color: Colors.white),
              //         ),
              //       ),
              //       const Padding(
              //         padding: EdgeInsets.only(top: 20),
              //       ),
              //       TextButton(
              //         style: TextButton.styleFrom(
              //             fixedSize: const Size(270, 70),
              //             backgroundColor: Colors.white24,
              //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
              //             textStyle: const TextStyle(fontSize: 16)),
              //         onPressed: () {},
              //         child: const Text('Stock Market and Financial Management'),
              //       ),
              //       const Padding(
              //         padding: EdgeInsets.only(top: 15),
              //       ),
              //       TextButton(
              //         style:
              //         TextButton.styleFrom(
              //             fixedSize: const Size(270, 70),
              //             backgroundColor: Colors.white24,
              //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
              //             textStyle: const TextStyle(fontSize: 16)),
              //
              //         onPressed: () {},
              //         child: const Text('Stock Market and Financial Management'),
              //       ),
              //       const Padding(
              //         padding: EdgeInsets.only(top: 15),
              //       ),
              //
              //
              //       const Padding(
              //         padding: EdgeInsets.only(top: 15),
              //       ),
              //     ],
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  }
}
