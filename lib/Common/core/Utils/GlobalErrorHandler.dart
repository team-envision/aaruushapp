import 'dart:async';
import 'package:AARUUSH_CONNECT/Common/core/Routes/app_routes.dart';
import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:AARUUSH_CONNECT/Utilities/aaruushappbar.dart';
import 'package:AARUUSH_CONNECT/components/bg_area.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Logger/app_logger.dart';

class ErrorHandlerWidget extends StatefulWidget {
  final Widget child;

  const ErrorHandlerWidget({super.key, required this.child});

  @override
  _ErrorHandlerWidgetState createState() => _ErrorHandlerWidgetState();
}
bool _isHandlingGlobalError = false; // Global flag to prevent loops

class _ErrorHandlerWidgetState extends State<ErrorHandlerWidget> {
  late FlutterExceptionHandler _defaultFlutterErrorHandler;

  @override
  void initState() {
    super.initState();

    _defaultFlutterErrorHandler = FlutterError.onError!;

    // Global error handler for synchronous Flutter errors
    FlutterError.onError = (FlutterErrorDetails details) {
      _handleError(details);
      _defaultFlutterErrorHandler(details);
      FirebaseCrashlytics.instance.recordFlutterError;
    };

    // Global handler for asynchronous errors
    runZonedGuarded(() async {
      // App entry point
    }, (error, stackTrace) {
      _handleError(FlutterErrorDetails(exception: error, stack: stackTrace));
    });
  }

  void _handleError(FlutterErrorDetails errorDetails) {
    if (_isHandlingGlobalError) return; // Skip if already handling
    _isHandlingGlobalError = true;

    Log.verbose('Caught error', [errorDetails.exception, errorDetails.stack]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.currentRoute != '/ErrorScreen') {
        Get.offAll(() => ErrorScreen(errorDetails: errorDetails));
      }
      _isHandlingGlobalError = false; // Reset flag after navigating
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}




class ErrorScreen extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const ErrorScreen({super.key, required this.errorDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AaruushAppBar(
        title: "Error",
        actions: [
      Padding(
      padding: const EdgeInsets.only(right: 15),
      child: SizedBox(
        height: 35,
        width: 35,
        child: IconButton.outlined(
          padding: EdgeInsets.zero,
          onPressed: () => {Get.offAllNamed(AppRoutes.homeScreen)},
          icon: const Icon(Icons.close_rounded),
          color: Colors.white,
          iconSize: 20,
        ),
      ),
    ),
        ],
      ),
      body: BgArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 80, color: Colors.red),
                const SizedBox(height: 20),
                Text(
                  'Oops!\n Something went wrong.',
                  style: Get.theme.kSubTitleTextStyle.copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                ),

                // ElevatedButton(
                //   onPressed: () => Get.offAllNamed(AppRoutes.homeScreen),
                //   child: const Text('Go to Home'),
                // ),
                // const SizedBox(height: 10),
                // ElevatedButton(
                //   onPressed: () => Get.offAll(() => ErrorHandlerWidget(child: child)),
                //   child: const Text('Retry'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
