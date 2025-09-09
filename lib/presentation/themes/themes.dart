import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/text_styles.dart';

abstract class WhisprThemes {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
    textTheme: WhisprTextStyles.whisprTextTheme,
  );
}
