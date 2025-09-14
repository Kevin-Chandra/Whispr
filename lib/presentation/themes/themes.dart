import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';

abstract class WhisprThemes {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: WhisprColors.spanishViolet),
    textTheme: WhisprTextStyles.whisprTextTheme,
    tabBarTheme: navigationTabTheme,
  );

  static final navigationTabTheme = TabBarThemeData(
    dividerHeight: 0,
    labelColor: WhisprColors.vistaBlue,
    unselectedLabelColor: WhisprColors.paleLavenderWeb,
    indicatorSize: TabBarIndicatorSize.label,
    indicatorColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    tabAlignment: TabAlignment.fill,
    filledButtonTheme: FilledButtonThemeData(style: filledButtonTheme),
    outlinedButtonTheme:
        const OutlinedButtonThemeData(style: outlinedButtonTheme),
    dialogTheme: dialogTheme,
    inputDecorationTheme: inputDecorationTheme,
  );

  static final filledButtonTheme = ButtonStyle(
    iconColor: const WidgetStatePropertyAll(Colors.white),
    foregroundColor: const WidgetStatePropertyAll(Colors.white),
  );

  static const outlinedButtonTheme = ButtonStyle();
  static const textButtonTheme = ButtonStyle();
  static const dialogTheme = DialogThemeData(
    backgroundColor: Colors.white,
  );

  static final inputDecorationTheme = InputDecorationTheme(
    errorStyle: WhisprTextStyles.bodyS,
    helperStyle: WhisprTextStyles.bodyS,
    hintStyle: WhisprTextStyles.bodyM.copyWith(color: WhisprColors.spanishGray),
  );
}
