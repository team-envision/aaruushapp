import 'dart:async';

import 'package:aarush/Common/default_controller_bindings.dart';
import 'package:aarush/Screens/aaruush_app.dart';
import 'package:aarush/Themes/theme_service.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as t;

import 'Data/api_data.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await GetStorage.init();
    await ApiData.init();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(AaruushApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class AaruushApp extends StatelessWidget {
  final appdata = GetStorage();

  AaruushApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: t.Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 800),
      initialBinding: DefaultController(),
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: AaruushAppScreen(),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}
