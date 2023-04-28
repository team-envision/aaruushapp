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
        height: MediaQuery.of(context).size.height,
        width:   MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/bg2.jpg'),
              fit: BoxFit.cover
          ),
        ),
        child:Column(crossAxisAlignment: CrossAxisAlignment.start,

          children: [SizedBox(
            height: 40,
          ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                IconButton(onPressed: (){},
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
                IconButton(onPressed: (){
                  print(n2);
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const eventpage()));}, icon: Icon(Icons.notifications_outlined),color: Colors.white,iconSize: 30,)
              ],
            ),


            Image.network(_eventList1[pg]['image'],
            height: 300,
            width: 410,
            fit: BoxFit.contain,),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 20, 5),
              child: Text(n2,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 20),
              child: Text(_eventList1[pg]['oneliner'],
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Icon(Icons.calendar_month_outlined,color: Colors.white,),
                Text(_eventList1[pg]['date'],style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.access_time,color: Colors.white,),
                Text(_eventList1[pg]['location'],style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.pin_drop,color: Colors.white,),
                Text(eventList[pg]['location'],style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),)
              ],
            ),
            SingleChildScrollView(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(tabs: [
                      Tab(text: "About",),
                      Tab(text: "Requirement",),
                      Tab(text: "Contact",),
                    ]),
                    Container(
                      height: 300,
                      child: TabBarView(children: [
                        Container(
                          child: Html(data: _eventList1[pg]['about'],style: {"body": Style(color: Colors.white)},),
                        ),

                        //   child: Text(_eventList1[0]['about'],style: TextStyle(
                        //     fontSize: 14,
                        //     color: Colors.white,
                        //   ),),
                        // ),
                        Container(
                          child: Html(data: _eventList1[pg]['structure'],style: {"body": Style(color: Colors.white)},),

                        ),
                        Container(

                          child: Html(data: _eventList1[pg]['contact'],style: {"body": Style(color: Colors.white,fontSize:FontSize(18))},),

                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ),

          ],
        )
    ),
        )
    );
  }
}
