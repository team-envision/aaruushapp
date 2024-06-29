import 'package:get_storage/get_storage.dart';

class ApiData {
  static const String API = 'https://api.aaruush.org/api/v1';
  static const String CDN_URL = "http://aaruush22-bucket.s3.ap-south-1.amazonaws.com";

  // Method to get the access token from GetStorage
  static String get accessToken {
    final box = GetStorage();
    return box.read('accessToken') ?? '';
  }

  // Method to save the access token to GetStorage
  static set accessToken(String token) {
    final box = GetStorage();
    box.write('accessToken', token);
  }
}
