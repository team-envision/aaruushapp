import 'dart:convert';
import 'package:aarush/main.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'page2.dart';
import 'package:http/http.dart' as http;
import 'jsonextract.dart';
import 'package:flutter_svg/flutter_svg.dart';
String n2="";
List<dynamic> _eventList1=eventList;
_fetchData() async {
  final response = await http.get(Uri.parse('https://api.aaruush.org/api/v1/events'));
  if (response.statusCode == 200) {
    _eventList1 = json.decode(response.body);
  } else {
    throw Exception('Failed to load events');
  }
}
class eventpage extends StatefulWidget {

  const eventpage({Key? key}) : super(key: key);

  @override
  State<eventpage> createState() => _eventpageState();
}
class _eventpageState extends State<eventpage> {


  @override

  initState() {
    String name=_eventList1[pg]['name'];
    var n=name.split("-");
    n2=n.join(" ").toUpperCase();

    super.initState();
    _fetchData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child: Container(
        height: 1000,
        width:   MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('images/bg2.jpg'),
              fit: BoxFit.cover
          ),
        ),
        child:Column(crossAxisAlignment: CrossAxisAlignment.start,

          children: [const SizedBox(
            height: 40,
          ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                IconButton(onPressed: (){},
                  icon: Image.asset('assets/images/profile.png'),
                  color: Colors.white,
                  iconSize: 40,
                ),
                const SizedBox(
                  width: 40,
                ),
                const Text("AARUUSH",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Xirod',
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                IconButton(onPressed: (){
                  print(n2);
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const eventpage()));}, icon: const Icon(Icons.notifications_outlined),color: Colors.white,iconSize: 30,)
              ],
            ),


            Image.network(_eventList1[pg]['image'],
            height: 300,
            width: 410,
            fit: BoxFit.contain,),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 20, 5),
              child: Text(n2,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 20, 20),
              child: Text(_eventList1[pg]['oneliner'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const Icon(Icons.calendar_month_outlined,color: Colors.white,),
                Text(_eventList1[pg]['date'],style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),),
                const SizedBox(
                  width: 20,
                ),
                const Icon(Icons.access_time,color: Colors.white,),
                Text(_eventList1[pg]['location'],style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),),
                const SizedBox(
                  width: 20,
                ),
                const Icon(Icons.pin_drop,color: Colors.white,),
                Text(eventList[pg]['location'],style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),)
              ],
            ),
            const SizedBox(height: 5,),
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(tabs: [
                    Tab(text: "About",),
                    Tab(text: "Requirement",),
                    Tab(text: "Contact",),
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 100,
                        minHeight: 200,
                      ),
                      padding:const EdgeInsets.all(15),
                      decoration:BoxDecoration(
                        color:const Color.fromRGBO(115, 115, 115, 0.3),
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: const BorderRadius.all(Radius.circular(40)),
                      ),
                      height: 200,
                      child: TabBarView(children: [
                        SingleChildScrollView(
                          child: Container(
                            child: Html(data: _eventList1[pg]['about'],style: {"body": Style(color: Colors.white,fontSize: FontSize(19.5))},),
                          ),
                        ),
                        //   child: Text(_eventList1[0]['about'],style: TextStyle(
                        //     fontSize: 14,
                        //     color: Colors.white,
                        //   ),),
                        // ),
                        SingleChildScrollView(
                          child: Container(
                            child: Html(data: _eventList1[pg]['structure'],style: {"body": Style(color: Colors.white,fontSize: FontSize(19.5))},),
                          ),
                        ),
                        Container(
                          child: Center(
                              child: Html(data: _eventList1[pg]['contact'],style: {"body": Style(color: Colors.white,fontSize:FontSize(19.5),textAlign:TextAlign.center)},)),
                        ),
                      ]),
                    ),
                  ),
          Container(
            height: 65,
            width: 300,
            decoration: const BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),


            child:TextButton(
                    child: const Text("Register",
                      style: TextStyle(
                          color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    onPressed: (){Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const page2()));


                    },
                  ),  ),              ],
              ),
            ),

          ],
        )
    ),
        ),
    );
  }
}
