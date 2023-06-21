// import 'package:flutter/material.dart';
// import 'dart:ui';
// import 'package:aarush/page2.dart';
// import 'eventpage.dart';
// import 'jsonextract.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'newfolder.dart';
// const color=const Color(0xffffffff60);
// int c=0;
// Future _fetchData() async {
//   final response = await http.get(
//       Uri.parse('https://api.aaruush.org/api/v1/events'));
//   if (response.statusCode == 200) {
//     eventList = json.decode(response.body);
//   } else {
//     throw Exception('Failed to load events');
//   }
// }
// launchlink() async{
//   final Uri link = Uri.parse("https://aaruush.org/");
//   if (await launchUrl(link)) {
//     await launchUrl(link);
//   } else {
//     throw 'Could not launch $link';
//   }
// }
// Future<void> main() async {

//   WidgetsFlutterBinding.ensureInitialized();
//   await _fetchData();
//   runApp(const ecom());

// }
// class ecom extends StatelessWidget {
//   const ecom({Key? key}) : super(key: key);

//   @override


//   Widget build(BuildContext context) {
//     return MaterialApp(

//         home: MyApp()
//     );
//   }
// }
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:SingleChildScrollView(
//         child: Container(
//           height: 1050,
//           width:   double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(image: AssetImage('images/bg.jpg'),
//               fit: BoxFit.cover
//           ),
//         ),
//         child:
//           Column(
//           children: [
//             SizedBox(
//               height: 50,
//             ),

//             Image.asset('images/Group557.jpg',
//               height: 200,
//               width: 500,
//             ),
//             Text("AARUUSH",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 40.79,
//                 fontFamily: 'Xirod',
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Text("Connect",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 15,
//               ),


//             ),
//             SizedBox(
//               height: 50,
//             ),
//             Container(
//               height: 290,
//               width: 320,
//               decoration: BoxDecoration(
//                 image: DecorationImage(image: AssetImage('images/Rectangle2.jpg'),
//                       fit: BoxFit.cover

//                 ),
//               ),
//                 child: Column(
//                   children: [

//                     SizedBox(
//                       height: 50,
//                     ),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 40,
//                         ),
//                         ClipRect(

//                           child: BackdropFilter(
//                             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                             child: Text('WELCOME',
//                             style: TextStyle(
//                               fontSize: 30,
//                               fontWeight: FontWeight.bold,
//                             ),),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 25,
//                     ),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 35,

//                         ),
//                         Flexible(child: Text('Lorem ipsum dolor sit amet,consectetur adipiscing elit labore et.',
//                           style: TextStyle(
//                             fontSize: 17,
//                           ),
//                         ))
//                       ],
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       height: 50,
//                       width: 250,
//                       decoration: BoxDecoration(
//                         color: Colors.deepOrangeAccent,
//                           borderRadius: BorderRadius.all(Radius.circular(30))
//                         ),


//                       child:TextButton(
//                         child: Text("Get Started",
//                           style: TextStyle(
//                             color: Colors.white
//                           ),
//                         ),
//                         onPressed: (){Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => const page2()));


//                         },
//                       ),
//                     )
//                   ],


//                 )
//                 ),
//   ],
//             ),


//     ),
//         ),

//       );
//   }
// }
