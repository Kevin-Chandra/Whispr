import 'package:intl/intl.dart';
import 'package:whispr/util/constants.dart';

extension DateTimeUtils on DateTime {
  String get toUtcTime => toUtc().toIso8601String();

  String get formattedJsonTime => toIso8601String();

  String get formattedTime =>
      DateFormat(DateFormatConstants.timeFormat).format(this);
}

abstract class DateTimeHelper {
  static String getTimestamp(String format) {
    return DateFormat(format).format(DateTime.now());
  }
}
