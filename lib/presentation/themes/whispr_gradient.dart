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

  static final LinearGradient purpleShadeGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      WhisprColors.lavenderWeb,
      WhisprColors.paleMagnolia,
    ],
  );

  static final LinearGradient purplePinkGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      WhisprColors.cornflowerBlue,
      WhisprColors.mauve,
    ],
  );
}
