import 'package:flutter/material.dart';
import 'package:whispr/lang/generated/whispr_localizations.dart';

extension ContextExtensions on BuildContext {
  /// To access localised strings.
  /// Usage: [context.strings.yourString]
  WhisprLocalizations get strings => WhisprLocalizations.of(this)!;
}