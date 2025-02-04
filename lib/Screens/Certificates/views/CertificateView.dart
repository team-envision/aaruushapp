import 'package:AARUUSH_CONNECT/Common/core/Routes/app_routes.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../controllers/CertificateController.dart';

class CertificateView extends StatelessWidget {
  CertificateView({super.key});
  final CertificateController certificateController =
      Get.find<CertificateController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! > -1 && details.localPosition.dx < 100) {
         Get.back();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AaruushAppBar(title: "Certificates", actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SizedBox(
              height: 35,
              width: 35,
              child: IconButton.outlined(
                padding: EdgeInsets.zero,
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close_rounded),
                color: Colors.white,
                iconSize: 20,
              ),
            ),
          ),
        ]),
        body: BgArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Get.height / 9),
              Obx(
                () => certificateController.state.isLoading.value
                    ? Center(
                      child: Image.asset(
                        'assets/images/spinner.gif',
                        scale: 4,
                      ),
                    )
                    : certificateController.state.certificates.isEmpty
                        ? const Text(
                            "No Certificates",
                            style: TextStyle(letterSpacing: 4),
                          )
                        : Expanded(
                            child: LiveList.options(
                              padding: EdgeInsets.zero,
                              itemBuilder: buildCertificateCard,
                              itemCount: certificateController
                                  .state.certificates.length,
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
          ),
        ),
      ),
    );
  }

  Widget buildCertificateCard(
      BuildContext context, int index, Animation<double> animation) {
    String name =
        certificateController.state.certificates.keys.elementAt(index);
    String pdfUrl =
        certificateController.state.certificates.values.elementAt(index);
    return FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        // And slide transition
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.1),
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
                        onPressed: () => certificateController
                            .openPreviewDialog(Get.context!, pdfUrl),
                        icon: const Icon(Icons.open_in_new_outlined),
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () =>
                            certificateController.downloadPDF(pdfUrl),
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
