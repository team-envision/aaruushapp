import 'dart:ui';

import 'package:flutter/material.dart';

Widget appBarBlur() {
  return ClipRRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        color: Colors.transparent,
      ),
    ),
  );
}
