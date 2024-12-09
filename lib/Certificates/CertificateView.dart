import 'package:AARUUSH_CONNECT/Certificates/CertificateController.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Certificateview extends StatelessWidget {
  Certificateview({super.key});
  final controller = Get.put(Certificatecontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AaruushAppBar(title: "Certificates", actions: [
        IconButton.outlined(
          padding: EdgeInsets.zero,
          onPressed: () => {Navigator.pop(context)},
          icon: const Icon(Icons.close_rounded),
          color: Colors.white,
          iconSize: 25,
        ),
      ]),
      body: BgArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: AppBar().preferredSize.height + 20),
          Obx(
            () => controller.isLoading.value
                ? CircularProgressIndicator(
                    color: Get.theme.colorPrimary,
                  )
                : controller.certificates.isEmpty
                    ? const Text(
                        "No Certificates",
                        style: TextStyle(letterSpacing: 4),
                      )
                    : Expanded(
                        child: LiveList.options(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          itemBuilder: buildCertificateCard,
                          itemCount: controller.certificates.length,
                          options: const LiveOptions(
                            // delay: Duration(seconds: 1),
                            showItemInterval: Duration(milliseconds: 200),
                            showItemDuration: Duration(milliseconds: 300),
                            visibleFraction: 0.05,
                            reAnimateOnVisibility: false,
                          ),
                        ),
                      ),
          )
        ],
      )),
    );
  }

  Widget buildCertificateCard(
      BuildContext context, int index, Animation<double> animation) {
    String name = controller.certificates.keys.elementAt(index);
    String pdfUrl = controller.certificates.values.elementAt(index);
    return FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        // And slide transition
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          // Paste you Widget
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(12),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 150,
                  child: SfPdfViewerTheme(
                      data: SfPdfViewerThemeData(
                          backgroundColor: Colors.transparent,
                          progressBarColor: Get.theme.colorPrimary),
                      child: SfPdfViewer.network(
                        pdfUrl,
                      )),
                ),
                Container(
                  color: Colors.black54,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 20,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            name,
                            style: Get.textTheme.headlineSmall!
                                .copyWith(color: Colors.white, fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () =>
                            controller.openPreviewDialog(Get.context!, pdfUrl),
                        icon: const Icon(Icons.open_in_new_outlined),
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () => controller.downloadPDF(pdfUrl),
                        icon: const Icon(Icons.file_download_outlined),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
