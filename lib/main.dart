import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'Common/default_controller_bindings.dart';
import 'Data/api_data.dart';
import 'Screens/aaruush_app.dart';
import 'Themes/theme_service.dart';
import 'Themes/themes.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await GetStorage.init();
    await ApiData.init();
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(AaruushApp());

    // runApp(  DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => AaruushApp(), // Wrap your app
    // ),
    // );

  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
  FlutterNativeSplash.remove();
}

class AaruushApp extends StatelessWidget {
  final appdata = GetStorage();
  AaruushApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 400),
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
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  // Open the Hive box
  var box = await Hive.openBox('BackgroundNotifications');

  // Store the notification
  await box.add({
    'title': message.notification?.title,
    'body': message.notification?.body,
    'linkAndroid': message.notification?.android!.imageUrl,
    'linkApple': message.notification?.apple!.imageUrl,
    'data': message.data,
    'receivedAt': DateTime.now(),
  });

  if (message.data['url'] != null) {
    // if (kDebugMode) {
    //   print(message);
    // final prefs = await SharedPreferences.getInstance();
    // String url = message.data['url'].toString();
    // await prefs.setString('KEY_LAUNCH_URL', url);
    // }
    // else{
    //
    // }
  } else {
    if (kDebugMode) {
      print("message is null");
    }
    if (kDebugMode) {
      print(message);
    }
  }
}