// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

extension ThemeExtension on ThemeData {
  Color get colorPrimary => brightness == Brightness.dark
      ? const Color(0xffF45D08)
      : const Color(0xffF45D08);
  Color get colorPrimaryDark => brightness == Brightness.dark
      ? const Color(0xff242329)
      : const Color(0xff242329);
  Color get dayNight => brightness == Brightness.dark
      ? const Color(0xffffffff)
      : const Color(0xff000000);
  Color get btnTextCol => brightness == Brightness.dark
      ? const Color(0xF9FAFAFA)
      : const Color(0xff494646);
  Color get menu_opener_color => brightness == Brightness.dark
      ? const Color(0xe2232323)
      : const Color(0xe3e3e3e3);
  Color get sheetColor => brightness == Brightness.dark
      ? const Color(0xff232323)
      : const Color(0xf0ffffff);
  Color get curveBG => brightness == Brightness.dark
      ? const Color(0x8D4A4A48)
      : const Color(0xB4F1F1F1);
  Color get barrierColor => brightness == Brightness.dark
      ? const Color(0xA4353534)
      : const Color(0xA4353534);

  TextStyle get kTitleTextStyle => GoogleFonts.montserrat(
        //roboto
        fontWeight: FontWeight.w500,
        color: btnTextCol,
        fontSize: 25,
      );
  TextStyle get kTitleTextStyle1 => GoogleFonts.montserrat(
        //roboto
        fontWeight: FontWeight.w600,
        color: btnTextCol,
        fontSize: 32,
      );

  TextStyle get kSubTitleTextStyle => GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: btnTextCol,
      );
  TextStyle get kSubTitleTextStyle2 => GoogleFonts.montserrat(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: btnTextCol,
      );
  TextStyle get kSmallTextStyle => GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: btnTextCol,
      );
  TextStyle get kSmallmidTextStyle => GoogleFonts.montserrat(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: btnTextCol,
      );
  TextStyle get kVerySmallTextStyle => GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        color: btnTextCol,
      );
  TextStyle get kBigTextStyle => GoogleFonts.montserrat(
        fontWeight: FontWeight.w800,
        color: btnTextCol,
        fontSize: 40,
      );
  TextStyle get kBigTextStyle1 => GoogleFonts.montserrat(
        fontWeight: FontWeight.w600,
        color: btnTextCol,
        fontSize: 80,
      );
  TextStyle get kVeryBigTextStyle => GoogleFonts.montserrat(
        fontWeight: FontWeight.w800,
        color: btnTextCol,
        fontSize: 52,
      );
}

class Themes {
  static final light = ThemeData.light().copyWith(
    // backgroundColor: Colors.white,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
    dialogBackgroundColor: Colors.transparent,
    dialogTheme:
        const DialogTheme(backgroundColor: Colors.transparent, elevation: 0),
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xffffffff),
            statusBarIconBrightness: Brightness.dark)),
    scaffoldBackgroundColor: const Color(0xffffffff),
    // textTheme: TextTheme(headline1: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.w800,color: Theme.of(context).btnTextCol),headline2: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w600),headline3: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w600))
  );
  static final dark = ThemeData.dark().copyWith(
    // backgroundColor: Colors.black,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xf2161616),
            statusBarIconBrightness: Brightness.light)),
    scaffoldBackgroundColor: const Color(0xff161616),
  );
}
