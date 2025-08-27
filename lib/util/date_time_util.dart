import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  String get toUtcTime => toUtc().toIso8601String();
}

abstract class DateTimeHelper {
  static String getTimestamp(String format) {
    return DateFormat(format).format(DateTime.now());
  }
}
