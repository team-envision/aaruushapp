import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

//Todo : delete flutter_svg_provider package if not used.

class QrGeneratorFunc extends StatelessWidget {
  const QrGeneratorFunc({super.key, required this.qrGeneratingString});
  final String qrGeneratingString;
  @override
  Widget build(BuildContext context) {
    return QrImageView(
      size: 200,
      data: qrGeneratingString,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.M,
      backgroundColor: Colors.white,
      eyeStyle:
          const QrEyeStyle(color: Colors.black, eyeShape: QrEyeShape.square),
      // embeddedImage: const AssetImage('assets/images/icons/AaruushPng.png'),
      embeddedImage: const Svg('assets/images/icons/aaruush-ticket.svg'),
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: Size(MediaQuery.of(context).size.height / 15,
            MediaQuery.of(context).size.height / 15),
      ),
    );
  }
}
