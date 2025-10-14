import 'package:intl/intl.dart';
import 'package:whispr/util/constants.dart';

extension DateTimeUtils on DateTime {
  String get toUtcTime => toUtc().toIso8601String();

  String get formattedJsonTime => toIso8601String();

  String get formattedTime =>
      DateFormat(DateFormatConstants.timeFormat).format(this);

  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isWithinThisMonth {
    final now = DateTime.now();
    return now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    return day == tomorrow.day &&
        month == tomorrow.month &&
        year == tomorrow.year;
  }
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

  static DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  static DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  static DateTime getEndOfDay(DateTime dateTime) {
    return DateTime(
        dateTime.year, dateTime.month, dateTime.day, 23, 59, 59, 999, 999);
  }
}
