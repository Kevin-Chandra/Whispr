import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_dot_indicator.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/date_time_util.dart';
import 'package:whispr/util/extensions.dart';

class WhisprDateTimelinePicker extends StatelessWidget {
  const WhisprDateTimelinePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChange,
  });

  final DateTime selectedDate;
  final Function(DateTime date) onDateChange;

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLinePicker.itemBuilder(
      firstDate: DateTime.fromMicrosecondsSinceEpoch(1),
      lastDate: DateTimeHelper.findLastDateOfTheWeek(DateTime.now()),
      disableStrategy: DisableStrategyAfterToday(),
      physics: ClampingScrollPhysics(),
      focusedDate: selectedDate,
      onDateChange: onDateChange,
      monthYearPickerOptions: MonthYearPickerOptions(),
      headerOptions: HeaderOptions(headerBuilder: (context, date, onTap) {
        return SizedBox(
          height: 85,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: onTap,
                child: date.isToday
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
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
                        DateTimeHelper.formatDateTime(
                            date, DateFormatConstants.monthDateYearFormat),
                        style: WhisprTextStyles.bodyL.copyWith(
                          color: WhisprColors.spanishViolet,
                        ),
                      ),
              ),
            ],
          ),
        );
      }),
      timelineOptions: TimelineOptions(height: 80),
      itemBuilder: (context, date, isSelected, isDisabled, isToday, onTap) {
        return InkWell(
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
