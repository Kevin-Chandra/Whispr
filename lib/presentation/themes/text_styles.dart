import 'package:flutter/material.dart';

class WhisprTextStyles {
  /*
   *  Heading
   */
  static const TextStyle heading = TextStyle(
    fontFamily: 'Nunito',
  );

  static final TextStyle heading1 = heading.copyWith(
    fontSize: 30.0,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle heading2 = heading.copyWith(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle heading3 = heading.copyWith(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle heading4 = heading.copyWith(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle heading5 = heading.copyWith(
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle heading6 = heading.copyWith(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
  );

  /*
   *  Body
   */
  static const TextStyle body = TextStyle(
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w400,
  );

  static final TextStyle bodyL = body.copyWith(
    fontSize: 18.0,
  );

  static final TextStyle bodyM = body.copyWith(
    fontSize: 16.0,
  );

  static final TextStyle bodyS = body.copyWith(
    fontSize: 14.0,
  );

  /*
   *  Subtitle
   */
  static const TextStyle subtitle = TextStyle(
    fontFamily: 'Nunito',
  );

  static final TextStyle subtitle1 = subtitle.copyWith(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle subtitle2 = subtitle.copyWith(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle subtitle3 = subtitle.copyWith(
    fontSize: 10.0,
    fontWeight: FontWeight.w600,
  );

  /*
   *  Button
   */
  static const TextStyle button = TextStyle(
    fontFamily: 'Nunito',
  );

  static final TextStyle buttonL = subtitle.copyWith(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle buttonM = subtitle.copyWith(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle buttonS = subtitle.copyWith(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
  );

  static TextTheme whisprTextTheme = TextTheme(
    bodyLarge: bodyL,
    bodyMedium: bodyM,
    bodySmall: bodyS,
    labelLarge: buttonL,
    labelMedium: buttonM,
    labelSmall: buttonS,
    displayLarge: heading1,
    displayMedium: heading2,
    displaySmall: heading3,
    titleLarge: heading4,
    titleMedium: heading5,
    titleSmall: heading6,
  );
}
