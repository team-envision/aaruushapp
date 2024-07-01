import 'package:get_storage/get_storage.dart';

class ApiData {
  static String API = 'https://api.aaruush.org/api/v1';
  static String accessToken = GetStorage().read('accessToken') ?? '';
  static String CDN_URL = "http://aaruush22-bucket.s3.ap-south-1.amazonaws.com";
}
