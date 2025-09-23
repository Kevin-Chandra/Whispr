import 'package:flutter/material.dart';

import 'colors.dart';

abstract class WhisprGradient {
  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      WhisprColors.lavenderBlue,
      WhisprColors.magnolia,
      WhisprColors.lavenderWeb
    ],
  );

  static const LinearGradient purpleShadeGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      WhisprColors.lavenderWeb,
      WhisprColors.paleMagnolia,
    ],
  );

  static const LinearGradient purplePinkGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      WhisprColors.cornflowerBlue,
      WhisprColors.mauve,
    ],
  );

  static const LinearGradient blueMagentaVioletInterdimensionalBlueGradient =
      LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      WhisprColors.blueMagentaViolet,
      WhisprColors.interdimensionalBlue,
    ],
  );

  static const LinearGradient mediumPurplePaleVioletGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      WhisprColors.mediumPurple,
      WhisprColors.paleViolet,
    ],
  );

  static const LinearGradient whiteBlueWhiteGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: <Color>[
      Colors.white,
      WhisprColors.aliceBlue,
      Colors.white,
    ],
  );
}
