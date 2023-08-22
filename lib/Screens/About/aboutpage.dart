import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/components/aaruushappbar.dart';
import 'package:aarush/components/bg_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AaruushAppBar(title: "About us", actions: [
          IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: const Icon(Icons.close_rounded),
            color: Colors.white,
            iconSize: 25,
          ),
        ]),
        body: BgArea(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizeBox(100, 0),
                Text("Aaruush Connect App",
                    style: Get.theme.kSubTitleTextStyle),
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
                          .copyWith(color: Colors.blue)),
                ),
                sizeBox(20, 0),
                Text("About Aaruush", style: Get.theme.kSubTitleTextStyle),
                sizeBox(20, 0),
                Text(
                    "The word 'Aaruush' translates to 'the first rays of the sun'. Started by four visionary final-year college students, Aaruush intended to be a technical fest with 26 events and over 3000 participants, but it exceeded all expectations. And so successful was the idea that the inauguration was presided over by the former president of India, Dr A.P.J. Abdul Kalam",
                    style: Get.theme.kSmallTextStyle),
                sizeBox(20, 0),
                Text("About Team Envision",
                    style: Get.theme.kSubTitleTextStyle),
                sizeBox(20, 0),
                Text(
                    "Team Envision, the multidisciplinary technical team of Aaruush, was formed with the goal of finding solutions to the majority of societal and campus-related problems. It is a consortium of AI-ML, Cyber Security, Blockchain, Editorial, Game Developers, Web Developers, App Developers and Designers who work closely to ideate, fabricate and develop products that tackle the above-mentioned problems. Team Envision promotes learning and growth through effective solutions. Our team is composed of diligent and meticulous members, who through their skills have won various accolades for our institution. As a team, we have participated in various hackathons, namely the Smart India Hackathon, Rajasthan Hackathon, Mozofest Hackathon, Accenture Blockchain Hackathon etc. and have come out victorious. In Smart India Hackathon 2022, our team has successfully emerged as the winner.",
                    style: Get.theme.kSubTitleTextStyle),
              ],
            ),
          )
        ]));
  }
}
