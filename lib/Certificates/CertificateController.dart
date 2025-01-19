import 'dart:convert';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Common/common_controller.dart';
import '../Data/api_data.dart';

class Certificatecontroller extends GetxController {
  RxMap certificates = {}.obs;
  final commonConroller= Get.put(CommonController());
  var isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCertificates();
  }

  void openPreviewDialog(BuildContext context, String pdfUrl) {
    print(context.height);
    Get.defaultDialog(
        title: "",
        titlePadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,buttonColor: Get.theme.colorPrimary,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
            height: 300,
            width: Get.width,
            child: SfPdfViewerTheme(data: SfPdfViewerThemeData(
              backgroundColor: Colors.transparent,progressBarColor: Get.theme.colorPrimary,paginationDialogStyle: const PdfPaginationDialogStyle(backgroundColor: Colors.red)
            ),
            child: SfPdfViewer.network(pdfUrl))));
  }



  void downloadPDF(String pdfUrl) async {
    if (await canLaunchUrl(Uri.parse(pdfUrl))) {
      await launchUrl(Uri.parse(pdfUrl));
    } else {
      Get.snackbar('Error', 'Could not open link',
          snackPosition: SnackPosition.BOTTOM);
    }
  }





  Future<void> fetchCertificates() async {
    RxString email = CommonController.emailAddress;
    print(email);
    isLoading.value = true;
    try {
      final response = await http.get(
          Uri.parse('${ApiData.API}/users/$email/certificates'),
          headers: {'Authorization': ApiData.accessToken});
      if (response.statusCode == 200) {
        String data = utf8.decode(response.bodyBytes);
        List<dynamic> jsonResponse =
            json.decode(data); // Corrected to decode as Map
        print(jsonResponse);
        for (var e in jsonResponse) {
          certificates[e["event"]] = e["link"];
        }
        print(certificates);
      } else {
        printError(
            info: "Error gallery: ${response.body} ${response.statusCode}");
        throw Exception('Failed to load certificates');
      }
    } catch (e) {
      printError(info: 'Error fetching certificates: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
