import 'package:flutter/material.dart';
import 'dart:ui';

const color=const Color(0xffffffff60);
int c=0;
void main() {
  runApp(const ecom());
}
class ecom extends StatelessWidget {
  const ecom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyApp()
    );
  }
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SingleChildScrollView(
        child: Container(
          height: 1050,
          width:   double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/bg.png'),
              fit: BoxFit.cover
          ),
        ),
        child:
          Column(
          children: [
            SizedBox(
              height: 50,
            ),

            Image.asset('images/Group557.jpg',
              height: 200,
              width: 500,
            ),
            Text("AARUUSH",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.79,
                fontFamily: 'Xirod',
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text("Connect",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),


            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 300,
              width: 320,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('images/Rectangle2.jpg'),
                      fit: BoxFit.cover

                ),
              ),
                child: Column(
                  children: [

                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                        ),
                        ClipRect(

                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Text('WELCOME',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,


                            ),),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 35,

                        ),
                        Flexible(child: Text('Lorem ipsum dolor sit amet,consectetur    adipiscing elit labore et.'))
                      ],
                    ),
                    Card(
                      child: Container(

                        height: 100,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255,255,255,2),
                          image: DecorationImage(image: AssetImage('images/Rectangle3.jpg'),

                          ),
                        ),

                        child:TextButton(
                          child: Text("Get Started",
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                          onPressed: (){},
                        ),
                      ),
                    )
                  ],


                )
                ),
  ],
            ),


    ),
        ),

      );
  }
}
