import 'dart:io';
import 'package:AARUUSH_CONNECT/Utilities/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../Common/common_controller.dart';


class appRating {
  final RxBool _flag = false.obs;
  final TextEditingController _feedbackController = TextEditingController();
  final _common = Get.put(CommonController());

  Future<void> updateFeedback({
    required String feedback,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Map<String, dynamic> userData = {
      'feedBack': feedback,
    };

      try {
        await users.doc(CommonController.emailAddress.value).update(userData);
        Get.back();
      } on FirebaseException catch (e) {
        kDebugMode ? print(e.message) : null;
        setSnackBar(e.code, e.message!);
      }
      catch (error) {
        printError(info: error.toString());
      }

  }


    void rateApp(BuildContext context) {
    RateMyApp rateMyApp = RateMyApp(
      preferencesPrefix: 'rateMyApp_',
      minDays: 1,
      minLaunches: 2,
      remindDays: 2,
      remindLaunches: 2,
      googlePlayIdentifier: 'com.aaruush.connect',
      appStoreIdentifier: '6737286063',
    );

    rateMyApp.init().then((_) async {
    if(rateMyApp.shouldOpenDialog){
      if(!_flag.value){rateMyApp.launchNativeReviewDialog().then((value)=>_flag.value=true);}
      if(!_flag.value){ rateMyApp.showStarRateDialog(
        context,
        title: 'Rate this app',
        message: 'You like this app ? Then take a little bit of your time to leave a rating :',
        actionsBuilder: (context, stars) {
          return [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.white60),
              onPressed: () async {

                await rateMyApp.callEvent(RateMyAppEventType.noButtonPressed);
                Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
              },
              child: const Text('No,Thanks'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(239, 101, 34, 1),foregroundColor: Colors.white),
              onPressed: () async {
                await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
                Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
                stars ?? 0.0;
                if(stars!<=3.0){
                  showDialog(
                    builder: (_) => Dialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      child: Container(
                        width: Get.width*1.2, // Set a percentage of the screen width
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Feedback", style: TextStyle(fontSize: 24)),
                            const SizedBox(height: 10),
                            const Text("Help Us!"),
                            const Text("With your valuable feedback"),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                height: 150,
                                child: TextField(
                                  controller: _feedbackController,
                                  maxLines: null,
                                  enableSuggestions: true,
                                  expands: true,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Your Feedback',

                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: (){
                                  if(_feedbackController.text!="" || _feedbackController.text.isNotEmpty){
                                    updateFeedback(feedback: _feedbackController.text);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color.fromRGBO(239, 101, 34, 1),
                                ),
                                child: const Text("Submit"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), context: context,
                  );

                }
                else{
                  await rateMyApp.launchStore();
                }
              },
              child: const Text('OK'),
            ),

          ];
        },
        ignoreNativeDialog: Platform.isAndroid,
        dialogStyle: const DialogStyle(
          titleAlign: TextAlign.center,
          messageAlign: TextAlign.center,
          messagePadding: EdgeInsets.only(bottom: 20),
        ),
        starRatingOptions: const StarRatingOptions(itemColor:  Color.fromRGBO(239, 101, 34, 1),),
        onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
      );}
    }
    });
  }}



