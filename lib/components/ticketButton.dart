import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TicketButton extends StatelessWidget {
  TicketButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isDisabled = false,
  });

  final VoidCallback onTap;
  final String text;
  bool? isDisabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 90.0),
      child: TextButton(
        style: TextButton.styleFrom(
          elevation: 1,
          padding: const EdgeInsets.all(10),
          fixedSize: const Size.fromWidth(233),
          backgroundColor: isDisabled! ? Colors.grey : Get.theme.colorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: isDisabled! ? null : onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: Get.theme.kSmallTextStyle,
            ),
            const SizedBox(width: 8), // Add some space between text and icon
            const FaIcon(
              FontAwesomeIcons.ticket,size: 20, // Use Cupertino icon
              color: Colors.white, // Adjust the color as needed
            ),
          ],
        ),
      ),
    );
  }
}
