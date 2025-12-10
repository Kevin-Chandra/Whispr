import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/extensions.dart';

extension DateTimeUtils on DateTime {
  String get toUtcTime => toUtc().toIso8601String();

  String get formattedJsonTime => toIso8601String();

  String get formattedTime =>
      DateFormat(DateFormatConstants.timeFormat).format(this);

  String get formattedDate =>
      DateFormat(DateFormatConstants.dateFormat).format(this);

  String get createdAtFormattedTime =>
      DateFormat(DateFormatConstants.createdAtFormat).format(this);

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

  DateTime get extractDate {
    return DateTime(year, month, day);
  }

  String displayTimeAgo({required BuildContext context}) {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inSeconds < 60) {
      return context.strings.justNow;
    } else if (diff.inMinutes < 60) {
      return context.strings.minutesAgo(diff.inMinutes);
    } else if (diff.inHours < 24) {
      return context.strings.hoursAgo(diff.inHours);
    } else {
      return context.strings.daysAgo(diff.inDays);
    }
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
