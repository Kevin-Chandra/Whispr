import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_dot_indicator.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/date_time_util.dart';
import 'package:whispr/util/extensions.dart';

class WhisprDateTimelinePicker extends StatefulWidget {
  const WhisprDateTimelinePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChange,
  });

  final DateTime selectedDate;
  final Function(DateTime date) onDateChange;

  @override
  State<WhisprDateTimelinePicker> createState() =>
      _WhisprDateTimelinePickerState();
}

class _WhisprDateTimelinePickerState extends State<WhisprDateTimelinePicker> {
  final startDate = DateTime.fromMicrosecondsSinceEpoch(0);
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top header showing month.
        SizedBox(
          height: 70,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: date.isWithinThisMonth
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateTimeHelper.formatDateTime(
                            date, DateFormatConstants.monthDateYearFormat),
                        style: WhisprTextStyles.bodyS.copyWith(
                          color: WhisprColors.vistaBlue,
                        ),
                      ),
                      Text(
                        context.strings.today,
                        style: WhisprTextStyles.heading1.copyWith(
                          color: WhisprColors.spanishViolet,
                        ),
                      ),
                    ],
                  )
                : Text(
                    DateTimeHelper.formatDateTime(date, 'MMMM'),
                    style: WhisprTextStyles.heading1.copyWith(
                      color: WhisprColors.spanishViolet,
                    ),
                    textAlign: TextAlign.start,
                  ),
          ),
        ),
        // Date Timeline picker.
        ListViewObserver(
          onObserve: (model) {
            final index = model.firstChild?.index ?? 0;
            final firstIndexDate = startDate.add(Duration(days: index));

            if (date.month != firstIndexDate.month) {
              date = firstIndexDate;
              setState(() {});
            }
          },
          child: EasyDateTimeLinePicker.itemBuilder(
            firstDate: startDate,
            lastDate: DateTimeHelper.findLastDateOfTheWeek(DateTime.now()),
            disableStrategy: DisableStrategyAfterToday(),
            physics: ClampingScrollPhysics(),
            focusedDate: widget.selectedDate,
            onDateChange: widget.onDateChange,
            monthYearPickerOptions: MonthYearPickerOptions(),
            headerOptions: HeaderOptions(headerBuilder: (context, date, onTap) {
              return SizedBox();
            }),
            timelineOptions: TimelineOptions(height: 80),
            itemBuilder:
                (context, date, isSelected, isDisabled, isToday, onTap) {
              return InkWell(
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onTap: isDisabled ? null : onTap,
                child: Container(
                  decoration: isSelected
                      ? BoxDecoration(
                          color: WhisprColors.magnolia.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: WhisprColors.vistaBlue),
                        )
                      : null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateTimeHelper.formatDateTime(date, 'EEE'),
                        style: WhisprTextStyles.heading5.copyWith(
                          color: _resolveTextColor(isSelected, isDisabled),
                        ),
                      ),
                      Text(
                        DateTimeHelper.formatDateTime(date, 'd'),
                        style: WhisprTextStyles.heading5.copyWith(
                          color: _resolveTextColor(isSelected, isDisabled),
                        ),
                      ),
                      isSelected
                          ? Container(
                              width: 6,
                              height: 8,
                              decoration: WhisprDotIndicator(
                                  color: WhisprColors.vistaBlue, yOffset: -2),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              );
            },
            itemExtent: 50,
          ),
        ),
      ],
    );
  }

  Color _resolveTextColor(bool isSelected, bool isDisabled) {
    if (isDisabled) {
      return WhisprColors.spanishGray;
    } else if (isSelected) {
      return WhisprColors.vistaBlue;
    } else {
      return WhisprColors.spanishViolet;
    }
  }
}
