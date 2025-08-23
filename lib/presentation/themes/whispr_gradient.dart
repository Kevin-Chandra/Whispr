import 'package:flutter/material.dart';

import 'colors.dart';

abstract class WhisprGradient {
  static final LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      WhisprColors.lavenderBlue,
      WhisprColors.magnolia,
      WhisprColors.lavenderWeb
    ],
  );
}
