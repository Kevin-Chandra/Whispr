import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_dot_indicator.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/date_time_util.dart';
import 'package:whispr/util/throttler.dart';

class WhisprDateTimeline extends StatefulWidget {
  const WhisprDateTimeline({
    super.key,
    required this.minDate,
    required this.maxDate,
    required this.initialDate,
    required this.onDateChange,
    required this.selectedDate,
    this.startDayOfTheWeek = DateTime.monday,
    this.markedDates,
    this.headerBuilder,
  });

  final DateTime minDate;
  final DateTime maxDate;
  final DateTime initialDate;
  final DateTime selectedDate;
  final int startDayOfTheWeek;
  final Function(DateTime date) onDateChange;
  final Widget Function(BuildContext context, DateTime date)? headerBuilder;
  final Set<DateTime>? markedDates;

  @override
  State<WhisprDateTimeline> createState() => _WhisprDateTimelineState();
}

class _WhisprDateTimelineState extends State<WhisprDateTimeline> {
  late final PageController _controller;
  late final int initialPageIndex;
  late final int maxPageCount;
  late final DateTime firstDate;
  late final ValueNotifier<DateTime> firstDateNotifier;
  final _throttler =
      Throttler(delay: Duration(milliseconds: WhisprDuration.throttleDuration));

  @override
  void initState() {
    super.initState();

    final dayOfTheWeekDifference =
        (widget.minDate.weekday - widget.startDayOfTheWeek + 7) % 7;
    firstDate = widget.minDate.extractDate
        .subtract(Duration(days: dayOfTheWeekDifference));
    final initialDayDifference =
        widget.initialDate.differenceInDate(firstDate).inDays + 1;
    final maxDayDifference =
        widget.maxDate.differenceInDate(firstDate).inDays + 1;
    initialPageIndex = (initialDayDifference / 7).ceil() -
        1; // Minus 1 because index start from 0.
    maxPageCount = (maxDayDifference / 7).ceil();
    _controller = PageController(initialPage: initialPageIndex);
    firstDateNotifier = ValueNotifier(widget.initialDate);

    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final pageIndex = _controller.page?.round() ?? 0;
    _throttler.run(pageIndex, (p) {
      final startDate = widget.minDate.extractDate.add(Duration(days: p * 7));
      firstDateNotifier.value = startDate;
    });
  }

  @override
  void didUpdateWidget(covariant WhisprDateTimeline oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.selectedDate.isSameDate(oldWidget.selectedDate)) {
      _scrollToSelectedDate();
    }
  }

  void _scrollToSelectedDate() {
    final diff = widget.selectedDate.differenceInDate(firstDate).inDays + 1;
    final pageIndex = (diff / 7).ceil() - 1;

    if (pageIndex >= 0 && pageIndex < maxPageCount) {
      _controller.animateToPage(
        pageIndex,
        duration:
            const Duration(milliseconds: WhisprDuration.timelineScrollDuration),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.headerBuilder == null
              ? SizedBox()
              : ValueListenableBuilder<DateTime>(
                  valueListenable: firstDateNotifier,
                  builder: (context, date, _) {
                    return widget.headerBuilder!(context, date);
                  },
                ),
          SizedBox(
            height: 75,
            child: PageView.builder(
              itemCount: maxPageCount,
              controller: _controller,
              itemBuilder: (context, pageIndex) {
                final index = pageIndex - initialPageIndex;
                final dayOfTheWeekDifference = (widget.initialDate.weekday -
                        widget.startDayOfTheWeek +
                        7) %
                    7;
                final startDate = widget.initialDate.extractDate
                    .add(Duration(days: index * 7))
                    .subtract(Duration(days: dayOfTheWeekDifference));

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (i) {
                    final date = startDate.add(Duration(days: i));
                    final isDisabled = date.isAfterDate(widget.maxDate) ||
                        date.isBeforeDate(widget.minDate);
                    final isSelected = date.isSameDate(widget.selectedDate);
                    final isToday = date.isSameDate(DateTime.now());
                    final isMarked =
                        widget.markedDates?.contains(date.extractDate) == true;

                    return Flexible(
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onTap: isDisabled || isSelected
                            ? null
                            : () {
                                widget.onDateChange(date);
                              },
                        child: Container(
                          width: 48,
                          height: 72,
                          padding: EdgeInsets.only(top: 10),
                          decoration: _resolveDecoration(isSelected, isToday),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  DateTimeHelper.formatDateTime(date, 'EEE'),
                                  style: WhisprTextStyles.heading5.copyWith(
                                    color: _resolveTextColor(
                                        isSelected, isDisabled),
                                  ),
                                ),
                              ),
                              Text(
                                DateTimeHelper.formatDateTime(date, 'd'),
                                style: WhisprTextStyles.heading5.copyWith(
                                  color:
                                      _resolveTextColor(isSelected, isDisabled),
                                ),
                              ),
                              isMarked
                                  ? Container(
                                      width: 2,
                                      height: 2,
                                      decoration: WhisprDotIndicator(
                                        color: WhisprColors.vistaBlue,
                                        yOffset: -4,
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _throttler.dispose();
    _controller.removeListener(_onScroll);
  }

  Decoration? _resolveDecoration(bool isSelected, bool isToday) {
    if (isSelected) {
      return BoxDecoration(
        color: WhisprColors.magnolia.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: WhisprColors.vistaBlue),
      );
    } else if (isToday) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black26),
      );
    } else {
      return null;
    }
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
