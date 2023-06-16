import 'package:aarush/eventpage.dart';
import 'package:aarush/profilepage.dart';
import 'package:aarush/search.dart';
import 'package:flutter/material.dart';
import 'jsonextract.dart';
import 'main.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'profilepage.dart';
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
          height: 1000,
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
                      MaterialPageRoute(builder: (context) =>  profile()));

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

                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Container(
                  height: 500,
                  padding:EdgeInsets.all(15),
                  decoration:BoxDecoration(
                    color:Color.fromRGBO(115, 115, 115, 0.3),
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),

                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("OUR WORKSHOPS",style:TextStyle(fontWeight:FontWeight.bold,fontSize: 30,color: Colors.white)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 80,
                            decoration:BoxDecoration(
                              color:Color.fromRGBO(115, 115, 115, 0.5),
                              borderRadius: BorderRadius.all(Radius.circular(12)),

                            ),
                            child: Center(child:Text("Stock Market and Financial Management",style: TextStyle(fontSize:20,color: Colors.white),),
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 80,
                            decoration:BoxDecoration(
                              color:Color.fromRGBO(115, 115, 115, 0.5),
                              borderRadius: BorderRadius.all(Radius.circular(12)),

                            ),
                            child: Center(child:Text("Stock Market and Financial Management",style: TextStyle(fontSize:20,color: Colors.white),),
                            ),),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
