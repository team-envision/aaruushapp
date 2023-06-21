import 'package:aarush/Common/default_controller_bindings.dart';
import 'package:aarush/Screens/Home/home_screen.dart';
import 'package:aarush/Screens/OnBoard/on_boarding_screen.dart';
import 'package:aarush/Screens/aaruush_app.dart';
import 'package:aarush/Themes/theme_service.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/amplifyconfiguration.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:aarush/page2.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'eventpage.dart';
import 'jsonextract.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'newfolder.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as t;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(AaruushApp());
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
   Future<void> configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }
