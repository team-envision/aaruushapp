import 'package:AARUUSH_CONNECT/Common/core/Storage_Resources/local_client.dart';
import 'package:AARUUSH_CONNECT/Common/core/Storage_Resources/local_key.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

class ApiData {
  // Load environment variables from the .env file
  // TODO: Remember to import the .env file by calling ApiData.init() in your main.dart or relevant initialization file.
  static Future<void> init() async {
    try {
      await dotenv.load(fileName: "assets/.env");
    } catch (e) {
      if (kDebugMode) {
        print("Error loading .env file: $e");
      }
    }
  }

  // Read API keys from .env file
  static final String? API = dotenv.env['API_URL'];
  static final String? CDN_URL = dotenv.env['CDN_URL'];

  // Method to get the access token from GetStorage
  static String get accessToken {
    return LocalClient.getString(key:LocalKeys.accessToken);
  }

  // Method to save the access token to GetStorage
  static set accessToken(String token) {
    LocalClient.saveString(key:LocalKeys.accessToken,value: token);

  }
}
