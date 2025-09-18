import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';

abstract class WhisprThemes {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: WhisprColors.spanishViolet),
    textTheme: WhisprTextStyles.whisprTextTheme,
    filledButtonTheme: FilledButtonThemeData(style: filledButtonTheme),
    outlinedButtonTheme:
        const OutlinedButtonThemeData(style: outlinedButtonTheme),
  );

  static final filledButtonTheme = ButtonStyle(
    iconColor: const WidgetStatePropertyAll(Colors.white),
    foregroundColor: const WidgetStatePropertyAll(Colors.white),
  );

  static const outlinedButtonTheme = ButtonStyle();

  static const textButtonTheme = ButtonStyle();
}
