import 'dart:convert';
import 'package:AARUUSH_CONNECT/Common/controllers/common_controller.dart';
import 'package:AARUUSH_CONNECT/Screens/Certificates/state/Certificate_State.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Data/api_data.dart';

class CertificateController extends GetxController {
  final CommonController commonController;
  final CertificateState state;

  CertificateController({required this.commonController, required this.state});
  @override
  void onInit() {
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
    state.isLoading.value = true;
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
          state.certificates[e["event"]] = e["link"];
        }
        print(state.certificates);
      } else {
        printError(
            info: "Error gallery: ${response.body} ${response.statusCode}");
        throw Exception('Failed to load certificates');
      }
    } catch (e) {
      printError(info: 'Error fetching certificates: $e');
    } finally {
      state.isLoading.value = false;
    }
  }
}
