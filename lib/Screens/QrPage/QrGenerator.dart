import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

//Todo : delete flutter_svg_provider package if not used.

class QrGeneratorFunc extends StatelessWidget {
  const QrGeneratorFunc({super.key, required this.qrGeneratingString});
  final String qrGeneratingString;
  @override
  Widget build(BuildContext context) {
    return QrImageView(
      size: 120,
      data: qrGeneratingString,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.M,
      backgroundColor: Colors.white,
      eyeStyle: const QrEyeStyle(color: Colors.black),
      // embeddedImage: const AssetImage('assets/images/icons/AaruushPng.png'),
      // embeddedImage: const Svg('assets/images/icons/AaruushQrLogo.svg') ,
      // embeddedImageStyle:   QrEmbeddedImageStyle(
      //   size: Size(MediaQuery.of(context).size.height/4,MediaQuery.of(context).size.height/5),
      // ),
    );
  }
}
