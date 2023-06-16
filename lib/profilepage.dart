import 'package:aarush/page2.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'eventpage.dart';
import 'main.dart';
class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
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
    height: 20,
    ),
    Row(
    children: [
      GestureDetector(
        onTap:(){ Navigator.push(context,MaterialPageRoute(builder: (context) =>  page2()));},
        child: Container(
          height: 40,
          child: Image.asset('images/Group557.jpg'),
        ),
      ),

    // IconButton(onPressed: (){Navigator.push(context,
    // MaterialPageRoute(builder: (context) =>  profile()));
    //
    // },
    // icon: Image.asset('images/Group557.jpg'),
    // color: Colors.white,
    // iconSize: 80,
    // ),
    SizedBox(
    width: 50,
    ),
    Text("PROFILE",
    style: TextStyle(
    color: Colors.white,
    fontSize: 25,
    fontFamily: 'Xirod',
    ),
    ),
    SizedBox(
    width: 40,
    ),
    IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close),color: Colors.white,iconSize: 30,)
    ],
    ),
    SizedBox(
    height: 30,
    ),
      Row(
        children: [
          SizedBox(
            width: 30,
          ),
          Container(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(height:110,
                    child: Image.asset('images/Ellipse 252.png',
                      fit: BoxFit.contain,
                    )),

                Image.asset("images/Frame 12.png")
              ],
            )
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Aman Agrawal",style: TextStyle(fontSize:24,fontWeight:FontWeight.bold,color: Colors.white),),
              Text("AARUUSH ID: 3010644",style: TextStyle(fontSize:12,color: Colors.white),),
              SizedBox(
                height: 5,
              ),
              Text("an5122@srmist.edu.in",style:TextStyle(color:Colors.white,fontSize: 12))

            ],
          )
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
        child: Container(
          height: 60,
          decoration:BoxDecoration(
            color:Color.fromRGBO(115, 115, 115, 0.5),
              border: Border.all(width: 2, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(12)),

          ),
        child: Center(child:Text("Change Password",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color: Colors.white),),
        ),),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
        child: Container(
          height: 60,
          decoration:BoxDecoration(
            color:Color.fromRGBO(115, 115, 115, 0.5),
            border: Border.all(width: 2, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(12)),

          ),
          child: Center(child:Text("Tickets",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color: Colors.white),),
          ),),
      ),Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
        child: Container(
          height: 60,
          decoration:BoxDecoration(
            color:Color.fromRGBO(115, 115, 115, 0.5),
            border: Border.all(width: 2, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(12)),

          ),
          child: Center(child:Text("My Events",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color: Colors.white),),
          ),),
      ),Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
        child: Container(
          height: 60,
          decoration:BoxDecoration(
            color:Color.fromRGBO(115, 115, 115, 0.5),
            border: Border.all(width: 2, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(12)),

          ),
          child: Center(child:Text("My Proshows",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color: Colors.white),),
          ),),
      ),Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
        child: Container(
          height: 60,
          decoration:BoxDecoration(
            color:Color.fromRGBO(115, 115, 115, 0.5),
            border: Border.all(width: 2, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(12)),

          ),
          child: Center(child:Text("About Aaruush",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color: Colors.white),),
          ),),
      ),
      Container(
        height: 65,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),


        child:TextButton(
          child: Text("Log Out",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          onPressed: (){Navigator.push(context,
              MaterialPageRoute(builder: (context) => const page2()));


          },
        ),  ),

    ],
    ),
    ),
    ),
    );
  }
}

class pass extends StatefulWidget {
  const pass({Key? key}) : super(key: key);

  @override
  State<pass> createState() => _passState();
}

class _passState extends State<pass> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
