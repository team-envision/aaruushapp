import 'dart:async';

import 'package:AARUUSH_CONNECT/Common/common_controller.dart';
import 'package:AARUUSH_CONNECT/Services/notificationServices.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as t;
import 'package:shared_preferences/shared_preferences.dart';

import 'Common/default_controller_bindings.dart';
import 'Data/api_data.dart';
import 'Screens/aaruush_app.dart';
import 'Themes/theme_service.dart';
import 'Themes/themes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await GetStorage.init();
    await ApiData.init();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(AaruushApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class AaruushApp extends StatelessWidget {
  final appdata = GetStorage();
  AaruushApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: t.Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      initialBinding: DefaultController(),
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: const AaruushAppScreen(),
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp`
  await Firebase.initializeApp();
  if (message.data['url'] != null) {
    if (kDebugMode) {
      print(message);
      // final prefs = await SharedPreferences.getInstance();
      // String url = message.data['url'].toString();
      // await prefs.setString('KEY_LAUNCH_URL', url);
    }
    else{

    }
  }
  else{
    if (kDebugMode) {
      print("message is null");
    }
    if (kDebugMode) {
      print(message);
    }
  }

}
