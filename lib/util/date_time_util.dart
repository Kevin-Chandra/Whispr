import 'package:intl/intl.dart';
import 'package:whispr/util/constants.dart';

extension DateTimeUtils on DateTime {
  String get toUtcTime => toUtc().toIso8601String();

  String get formattedJsonTime => toIso8601String();

  String get formattedTime =>
      DateFormat(DateFormatConstants.timeFormat).format(this);
}

extension DurationUtils on Duration {
  String get durationDisplay {
    final h = inHours;
    final m = inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = inSeconds.remainder(60).toString().padLeft(2, '0');

    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:$m:$s';
    } else {
      return '$m:$s';
    }
  }
}

abstract class DateTimeHelper {
  static String getCurrentTimestamp(String format) {
    return DateFormat(format).format(DateTime.now());
  }

  static String formatDateTime(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }
}
