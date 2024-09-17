
import 'dart:convert';

import 'package:AARUUSH_CONNECT/Common/common_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Data/api_data.dart';
class Certificatecontroller extends GetxController {

  var certificateList = [].obs;
  var tempCertificateList = [].obs;
  final commonConroller= Get.put(CommonController());

  var isLoading = false.obs;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCertificates();
  }

  Future<void> fetchCertificates() async {
    final email = commonConroller.emailAddress.value;
    print(email);
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('${ApiData.API}/users/$email/certificates'));

      if (response.statusCode == 200) {
        String data = utf8.decode(response.bodyBytes);
        Map<String, dynamic> jsonResponse = json.decode(data); // Corrected to decode as Map
        print(jsonResponse);

        // Check if the map contains 'certificates' key and it's a list
        if (jsonResponse.containsKey('certificates')) {
          List certificates = jsonResponse['certificates'];
          print(certificates);

          // Assuming Gallery.fromJson handles the individual certificate objects
          // tempCertificateList.assignAll(
          //   certificates.map((e) => Gallery.fromJson(e)).toList(),
          // );

          // Further processing to extract image URLs
          // tempCertificateList.forEach((gallery) {
          //   if (gallery.image != null) {
          //     certificateList.addAll(gallery.image!);
          //   }
          // });
        } else {
          printError(info: "Key 'certificates' not found in the response");
        }

      } else {
        printError(info: "Error gallery: ${response.body} ${response.statusCode}");
        throw Exception('Failed to load certificates');
      }
    } catch (e) {
      printError(info: 'Error fetching certificates: $e');
    } finally {
      isLoading.value = false;
    }
  }


}
