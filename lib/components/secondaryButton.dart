import 'package:AARUUSH_CONNECT/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.text,
    this.icon,
    this.onPressed,
    this.isPrimary = true,
    super.key,
  });

  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isPrimary; // To distinguish between different button styles if needed

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {}, // Fallback to an empty function if onPressed is null
      child: Container(
        height: 43,
        width: 153,
        decoration: BoxDecoration(
          color: Get.theme.colorPrimary,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) // If an icon is provided, display it
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 43,
                  width: 33,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.black,
                    size: 21,
                  ),
                ),
              ),
            const SizedBox(width: 2), // Adds spacing between the icon and text
            Text(
              text,
              style: TextStyle(
                fontSize: isPrimary ? 9.5 : 13.5,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
