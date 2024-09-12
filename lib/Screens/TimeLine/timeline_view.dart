import 'dart:convert';
import 'package:AARUUSH_CONNECT/Screens/TimeLine/timeline_controller.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:AARUUSH_CONNECT/components/dropdown_selector.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../Utilities/aaruushappbar.dart';

class TimelineView extends GetView<TimelineController> {
  const TimelineView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AaruushAppBar(title: "AARUUSH"),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString("assets/json/timeLine.json"),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (snapshot.hasData) {
            var data = jsonDecode(snapshot.data.toString());
            return BgArea(mainAxisAlignment: MainAxisAlignment.start, children: [
              SafeArea(
                bottom: false,
                minimum: EdgeInsets.only(top: 180),
                child: SizedBox(
                  height: 500,
                  width: Get.width - 40,
                  child: AppinioSwiper(
                    backgroundCardCount: 4,
                    invertAngleOnBottomDrag: true,
                    backgroundCardOffset: Offset(0, -38),
                    cardBuilder: (context, index) {
                      return timeLineCard(
                          ImageUrl:data[index]["image"], tagLine: data[index]["tagline"]??"", year: data[index]["year"].toString()??"", description: data[index]["description"]??"",);
                    },
                    cardCount: data.length,
                  ),
                ),
              )
            ]);
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something Went Wrong",
                  style: TextStyle(color: Colors.white)),
            );
          } else {
            return const Center(
              child: Text("No Data Available",
                  style: TextStyle(color: Colors.white)),
            );
          }
        },
      ),
    );
  }
}

class timeLineCard extends StatelessWidget {
  final String ImageUrl;
  final String tagLine;
  final String year;
  final String description;

  const timeLineCard({super.key, required this.ImageUrl,required this.tagLine,required this.year,required this.description});

  @override
  Widget build(BuildContext context) {
    return FlipCard(
        front: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Color.fromRGBO(236, 99, 32, 1))),
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(22),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(ImageUrl,
                          maxHeight: double.maxFinite.toInt()),
                      fit: BoxFit.fitHeight)),
            ),
            ListTile(
              titleTextStyle:Get.theme.kSmallTextStyle.copyWith(fontWeight: FontWeight.bold),
              style: ListTileStyle.list,iconColor: Colors.white,subtitleTextStyle: Get.theme.kVerySmallTextStyle,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              leading: Image.asset(
                "assets/images/aaruush.png",
                scale: 5,
              ),
              horizontalTitleGap: 0,
              title: Text("AARUUSH ${year.substring(2)}"),
              subtitle: FittedBox(child: Text(tagLine)),
              trailing: Icon(Icons.info),
            ),
          ]),
        ),
        back: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Color.fromRGBO(236, 99, 32, 1))),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SvgPicture.asset(
                "assets/images/aaruush.svg",
                colorFilter:
                    ColorFilter.mode(Colors.black45, BlendMode.luminosity),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 20,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          "EVENT DISCRIPTION",
                          style: Get.theme.kSubTitleTextStyle
                              .copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                      Text(
                        description,
                        style: Get.theme.kSmallTextStyle.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

// class TimelineView extends GetView<TimelineController> {
//   const TimelineView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AaruushAppBar(title: "AARUUSH"),
//       body: FutureBuilder(future: DefaultAssetBundle.of(context).loadString("assets/json/timeLine.json"), builder: (context, snapshot) {
//         if(snapshot.connectionState==ConnectionState.waiting)
//         return BgArea(mainAxisAlignment: MainAxisAlignment.end, children: [
//           SafeArea(
//             bottom: false,
//             minimum: EdgeInsets.only(top: 180),
//             child: SizedBox(
//               height: 500,
//               width: Get.width - 40,
//               child: AppinioSwiper(
//                 backgroundCardCount: 4,
//                 invertAngleOnBottomDrag: true,
//                 backgroundCardOffset: Offset(0, -38),
//                 cardBuilder: (context, index) {
//                   return timeLineCard(
//                       ImageUrl:
//                       "https://aaruush22-bucket.s3.ap-south-1.amazonaws.com/timeline/23.1.webp");
//                 },
//                 cardCount: 10,
//               ),
//             ),
//           )
//         ]);
//       },)
//     );
//   }
// }
//
// class timeLineCard extends StatelessWidget {
//   final String ImageUrl;
//
//   const timeLineCard({super.key, required this.ImageUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return FlipCard(
//         front: Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(22),
//               border: Border.all(color: Color.fromRGBO(236, 99, 32, 1))),
//           child: Stack(alignment: Alignment.bottomCenter, children: [
//             // CachedNetworkImage(imageUrl: ImageUrl,useOldImageOnUrlChange: true,fit: BoxFit.fill,),
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(22),
//                   image: DecorationImage(
//                       image: CachedNetworkImageProvider(ImageUrl,
//                           maxHeight: double.maxFinite.toInt()),
//                       fit: BoxFit.cover)),
//             ),
//             ListTile(
//               titleTextStyle: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//               style: ListTileStyle.list,
//               contentPadding: EdgeInsets.symmetric(horizontal: 10),
//               leading: Image.asset(
//                 "assets/images/aaruush.png",
//                 scale: 5,
//               ),
//               horizontalTitleGap: 0,
//               title: Text("AARUUSH 24"),
//               subtitle: Text("AAruush tagline"),
//               trailing: Icon(Icons.info),
//             )
//           ]),
//         ),
//         back: Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(22),
//               border: Border.all(color: Color.fromRGBO(236, 99, 32, 1))),
//           child: Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               SvgPicture.asset(
//                 "assets/images/aaruush.svg",
//                 colorFilter:
//                     ColorFilter.mode(Colors.black45, BlendMode.luminosity),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     spacing: 20,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20.0),
//                         child: Text(
//                           "EVENT DISCRIPTION",
//                           style: Get.theme.kSubTitleTextStyle
//                               .copyWith(fontWeight: FontWeight.w900),
//                         ),
//                       ),
//                       Text(
//                         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
//                         style: Get.theme.kSmallTextStyle.copyWith(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                         softWrap: true,
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
// }
