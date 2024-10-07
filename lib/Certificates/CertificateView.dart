import 'package:AARUUSH_CONNECT/Certificates/CertificateController.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Certificateview extends StatelessWidget{
  Certificateview({super.key});
final controller = Get.put(Certificatecontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AaruushAppBar(title: "AARUUSH",actions: [IconButton.outlined(padding: EdgeInsets.zero,
        onPressed: () => {Navigator.pop(context)},
        icon: const Icon(Icons.close_rounded),
        color: Colors.white,
        iconSize: 25,
      ),]),
      body:   BgArea(
          children: [
        SafeArea(
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
            [
              SizedBox(width: 70,),
              Text("Certificates",style: Get.theme.kSubTitleTextStyle,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SvgPicture.asset("assets/images/icons/BadgesIcon.svg",height: 35,width: 35,),
              )
            ],),
        ),

            SizedBox(height: Get.height,
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1), itemBuilder: (context, index) =>

                  AnyLinkPreview(
                    link: "https://vardaan.app/",
                    displayDirection: UIDirection.uiDirectionHorizontal,
                    showMultimedia: false,
                    bodyMaxLines: 5,
                    bodyTextOverflow: TextOverflow.ellipsis,
                    titleStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    errorBody: 'Show my custom error body',
                    errorTitle: 'Show my custom error title',
                    errorWidget: Container(
                      color: Colors.grey[300],
                      child: Text('Oops!'),
                    ),
                    errorImage: "https://google.com/",
                    cache: Duration(days: 7),
                    backgroundColor: Colors.grey[300],
                    borderRadius: 12,
                    removeElevation: false,
                    boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
                    onTap: (){}, // This disables tap event
                  )
                ,),
            )
      ]),
    );
  }
}
