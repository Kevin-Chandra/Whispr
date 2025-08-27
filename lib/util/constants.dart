import 'package:logger/logger.dart';

abstract class Constants {
  static Logger logger = Logger();
}

abstract class WhisprDuration {
  static const int navigationTransitionDuration = 400;
  static const int stateFadeTransitionMillis = 400;
}

abstract class DateFormatConstants {
  static const String fileTimestamp = 'yyyyMMdd_HHmmss';
}
