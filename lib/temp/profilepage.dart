// import 'package:aarush/Data/bottomIndexData.dart';
// import 'package:aarush/Screens/Profile/editProfile.dart';
// import 'package:aarush/Screens/Tickets/myEvents.dart';
// import 'package:aarush/Utilities/correct_ellipis.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import '../../Utilities/bottombar.dart';
// import '../Home/home_controller.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put<HomeController>(HomeController());
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: <Widget>[
//             Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               color: const Color(0xFF252527),
//             ),
//             Column(

//               children: [
//               Padding(
//                   padding: const EdgeInsets.only(top: 15, right: 20),
//                   child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SvgPicture.asset(
//                           'assets/images/aaruush.svg',
//                           height: MediaQuery.of(context).size.height / 10,
//                         ),
//                         const Text(
//                           'Profile',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 35,
//                             fontFamily: 'Montserrat',
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         IconButton(
//                             padding: EdgeInsets.zero,
//                             onPressed: () {
//                               Get.back();
//                               if (kDebugMode) {
//                                 print(MediaQuery.of(context).size.height);
//                               }
//                             },
//                             icon: const Icon(Icons.close_rounded, size: 40))
//                       ])),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: MediaQuery.of(context).size.width / 25),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Stack(
//                         alignment: AlignmentDirectional.center,
//                         children: [
//                           IconButton(
//                             onPressed: () {},
//                             iconSize: MediaQuery.of(context).size.height / 6,
//                             icon: Obx(
//                                 () => controller.common.profileUrl.value != null
//                                     ? CircleAvatar(
//                                         radius: 60,
//                                         backgroundImage: NetworkImage(controller
//                                             .common.profileUrl.value!),
//                                       )
//                                     : Image.asset(
//                                         'assets/images/profile.png',
//                                         fit: BoxFit.fill,
//                                         height:
//                                             MediaQuery.of(context).size.height /
//                                                 6,
//                                       )),
//                           ),
//                           Positioned(
//                             bottom: 2,
//                             right: -0,
//                             child: GestureDetector(
//                               onTap: () => Get.to(const EditProfile()),
//                               child: Container(
//                                 width: MediaQuery.of(context).size.height / 15,
//                                 height: MediaQuery.of(context).size.height / 15,
//                                 decoration: const ShapeDecoration(
//                                   gradient: LinearGradient(
//                                     begin: Alignment(0.00, -1.00),
//                                     end: Alignment(0, 1),
//                                     colors: [
//                                       Color(0xFFED6522),
//                                       Color(0xFFC59123)
//                                     ],
//                                   ),
//                                   shape: OvalBorder(),
//                                 ),
//                                 child: const Icon(Icons.edit),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Wrap(
//                               children: [
//                                 Text(
//                                   controller.common.userName.value
//                                       .useCorrectEllipsis(),
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 1,
//                                   style: const TextStyle(
//                                     // fontSize: MediaQuery.of(context).size.height/31 ,
//                                     fontSize: 26,
//                                   ),
//                                 ),
//                               ]),
//                           Text(
//                             controller.common.aaruushId.value,
//                             overflow: TextOverflow.clip,
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             controller.common.emailAddress.value,
//                             overflow: TextOverflow.ellipsis,
//                           )
//                         ],
//                       )
//                     ]),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 30),
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.25),
//                     borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(7.05),
//                         topRight: Radius.circular(7.05)),
//                   ),
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height / 20,
//                       ),
//                       ProfileButtons(
//                           ButtonName: 'My Events',
//                           onPressedFunc: () {
//                             Get.to(() => MyEvents(
//                                   eventList: controller.eventList.value,
//                                 ));
//                           }),
//                       ProfileButtons(
//                           ButtonName: 'My Proshows', onPressedFunc: () {}),
//                       ProfileButtons(
//                           ButtonName: 'About Aaruush', onPressedFunc: () {}),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(
//                             MediaQuery.of(context).size.width / 8,
//                             MediaQuery.of(context).size.height / 15,
//                             MediaQuery.of(context).size.width / 8,
//                             15),
//                         child: SizedBox(
//                           width: double.infinity,
//                           child: TextButton(
//                               onPressed: () {},
//                               style: const ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStatePropertyAll(Color(0xFFFF723D)),
//                               ),
//                               child: const Text('Log Out',
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 25))),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ])
//           ],
//         ),
//         bottomNavigationBar: const AaruushBottomBar(
//           bottomIndex: BottomIndexData.PROFILE,
//         ),
//       ),
//     );
//   }
// }

// class ProfileButtons extends StatelessWidget {
//   final String ButtonName;
//   final VoidCallback onPressedFunc;
//   const ProfileButtons(
//       {super.key, required this.ButtonName, required this.onPressedFunc});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(
//           MediaQuery.of(context).size.width / 15,
//           MediaQuery.of(context).size.height / 50,
//           MediaQuery.of(context).size.width / 15,
//           0),
//       child: SizedBox(
//         width: double.infinity,
//         height: 56,
//         child: TextButton(
//           onPressed: onPressedFunc,
//           style: ButtonStyle(
//             backgroundColor: const MaterialStatePropertyAll(Color(0xFF504D50)),
//             shape: MaterialStatePropertyAll(RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(7.05))),
//           ),
//           child: Text(
//             ButtonName,
//             style: const TextStyle(
//                 color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
//           ),
//         ),
//       ),
//     );
//   }
// }
