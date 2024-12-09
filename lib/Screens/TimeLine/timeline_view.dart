import 'dart:convert';
import 'package:AARUUSH_CONNECT/Screens/TimeLine/timeline_controller.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Utilities/aaruushappbar.dart';
TimelineController controller = Get.put(TimelineController());
class TimelineView extends GetView<TimelineController> {
   TimelineView({super.key});

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
              child: CircularProgressIndicator( color: Color.fromRGBO(244, 93, 8, 1)),
            );
          } else if (snapshot.hasData) {
            var data = jsonDecode(snapshot.data.toString());
            return BgArea( child:
              SafeArea(
                bottom: false,
                minimum: EdgeInsets.only(top: 180),
                child: SizedBox(
                  height: 500,
                  width: Get.width - 40,
                  child: AppinioSwiper(
                    backgroundCardCount: 4,
                    allowUnSwipe: true,
                    controller: controller.swiperController,
                    swipeOptions: SwipeOptions.only(right: true),allowUnlimitedUnSwipe: true,
                    invertAngleOnBottomDrag: true,
                    backgroundCardOffset: Offset(0, -38),loop: true,
                    cardBuilder: (context, index) {
                      return timeLineCard(
                          ImageUrl:data[index]["image"], tagLine: data[index]["tagline"]??"", year: data[index]["year"].toString()??"", description: data[index]["description"]??"",
                      );
                    },
                    cardCount: data.length,
                  ),
                ),
              )
            );
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
    return GestureDetector(
        onHorizontalDragEnd: (dragEndDetails) {
      if (dragEndDetails.primaryVelocity!.isLowerThan(0) ) {
        controller.swiperController.unswipe();
      } else if (dragEndDetails.primaryVelocity!.isGreaterThan(0) ) {
        controller.swiperController.swipeRight();
      }},
      child: FlipCard(
        side: CardSide.FRONT,
          controller: controller.flipCardController,
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
                    image: DecorationImage(alignment: year=="2007"?Alignment.centerRight:Alignment.center,
                        image: CachedNetworkImageProvider(ImageUrl,
                            maxHeight: double.maxFinite.toInt()),
                        fit: BoxFit.cover)),
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
                      // spacing: 20,
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
          ),

      ),
    );
  }
}
