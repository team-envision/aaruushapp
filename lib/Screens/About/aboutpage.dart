import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/components/aaruushappbar.dart';
import 'package:aarush/components/bg_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/DynamicWhiteBox.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AaruushAppBar(title: "About us", actions: [
          IconButton.outlined(padding: EdgeInsets.zero,
            onPressed: () => {Navigator.pop(context)},
            icon: const Icon(Icons.close_rounded),
            color: Colors.white,
            iconSize: 25,
          ),
        ],),
        body: BgArea(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizeBox(100, 0),
                Text("Aaruush Connect App",
                    style: Get.theme.kVerySmallTextStyle.copyWith(fontWeight: FontWeight.w300,fontSize: 23)),
                sizeBox(10, 0),
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse("https://envision.aaruush.org");
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url,
                          mode: LaunchMode.externalApplication);
                    }
                  },
                  child: Text("Developed by Team Envision",
                      style: Get.theme.kVerySmallTextStyle
                          .copyWith(color: const Color.fromRGBO(239, 101, 34, 1),)),
                ),
                sizeBox(20, 0),
                Text("About Aaruush", style: Get.theme.kSubTitleTextStyle),
                sizeBox(20, 0),
                CustomBox(
                  bordersize: 16,
                  margin: const EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                        """Aaruush, SRM Institute of Science and Technology's premier national techno-management fest, has been a beacon of innovation since 2007. Inaugurated by late Dr. A. P. J. Abdul Kalam, it brings together students worldwide for technical workshops, hackathons, lectures, and exhibitions. With 16 domains, 13 committees, 2 teams, and a diverse range of events, Aaruush fosters creativity and transformative experiences under the theme "Towards Infinity" and motto "Rising in the Spirit of Innovation." Join us to experience a festival where imagination meets execution and creativity knows no bounds.""",
                        style: Get.theme.kSmallTextStyle.copyWith(fontSize: 16),textAlign: TextAlign.justify,),
                  ),
                ),
                sizeBox(20, 0),
                Text("About Team Envision",
                    style: Get.theme.kSubTitleTextStyle),
                sizeBox(20, 0),
                CustomBox(
                  bordersize: 16,
                  margin: const EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        "Team Envision is a multidisciplinary technical team of Aaruush, dedicated to solving societal and campus challenges through innovative solutions. With expertise in in a variety of technical fields, they consistently excel in prestigious competitions like the Smart India Hackathon. The team develops cutting-edge technologies, crafts user-friendly applications, secures digital transactions, and creates visually impactful designs, driving technological advancement and making a significant impact on both society and the campus community.",
                        style: Get.theme.kSmallTextStyle.copyWith(fontSize: 16),textAlign: TextAlign.justify,),
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}





