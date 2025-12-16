import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_date_picker.dart';
import 'package:whispr/presentation/widgets/whispr_date_timeline.dart';
import 'package:whispr/util/date_time_util.dart';

class JournalHeader extends StatefulWidget {
  const JournalHeader({
    super.key,
    required this.markedDates,
    required this.onDateChange,
    required this.minDate,
  });

  final DateTime minDate;
  final Set<DateTime> markedDates;
  final Function(DateTime) onDateChange;

  @override
  State<JournalHeader> createState() => _JournalHeaderState();
}

class _JournalHeaderState extends State<JournalHeader> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WhisprDateTimeline(
      minDate: widget.minDate,
      maxDate: DateTime.now(),
      initialDate: DateTime.now(),
      selectedDate: selectedDate,
      onDateChange: onDateChange,
      markedDates: widget.markedDates,
      headerBuilder: (context, date) {
        return GestureDetector(
          onTap: () async {
            WhisprDatePicker(
              initialDate: selectedDate.extractDate,
              minDate: widget.minDate,
              maxDate: DateTime.now().extractDate,
              markedDate: widget.markedDates.toList(),
              onDateSelected: (date) {
                if (date == null) {
                  return;
                }
                onDateChange(date);
              },
            ).show(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateTimeHelper.formatDateTime(date, 'yyyy'),
                style: WhisprTextStyles.heading4.copyWith(
                    color: WhisprColors.spanishViolet.withValues(alpha: 0.75)),
              ),
              Text(
                DateTimeHelper.formatDateTime(date, 'MMMM'),
                style: WhisprTextStyles.heading1.copyWith(
                  color: WhisprColors.spanishViolet,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        );
      },
    );
  }

  void onDateChange(DateTime date) {
    widget.onDateChange(date);
    setState(() {
      selectedDate = date;
    });
  }
}
