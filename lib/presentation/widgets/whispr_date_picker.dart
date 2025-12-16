import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_dot_indicator.dart';

class WhisprDatePicker extends StatefulWidget {
  const WhisprDatePicker({
    super.key,
    this.minDate,
    this.maxDate,
    this.initialDate,
    this.selectionMode = DatePickerSelectionMode.single,
    this.onDateSelected,
    this.onDateRangeSelected,
    this.showTodayButton = false,
    this.markedDate,
  });

  final bool showTodayButton;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? initialDate;
  final DatePickerSelectionMode selectionMode;
  final List<DateTime>? markedDate;
  final Function(DateTime?)? onDateSelected;
  final Function(List<DateTime>)? onDateRangeSelected;

  @override
  State<WhisprDatePicker> createState() => _WhisprDatePickerState();

  void show(BuildContext context) {
    showDialog(
      context: context,
      fullscreenDialog: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(20.0)), // Set your desired radius here
        ),
        child: LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            width: constraints.maxWidth * 0.85,
            height: constraints.maxHeight * 0.55,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: this,
            ),
          ),
        ),
      ),
    );
  }
}

class _WhisprDatePickerState extends State<WhisprDatePicker> {
  final controller = DateRangePickerController();

  @override
  void initState() {
    super.initState();
    controller.displayDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      controller: controller,
      backgroundColor: Colors.transparent,
      minDate: widget.minDate,
      maxDate: widget.maxDate,
      showActionButtons: true,
      showNavigationArrow: true,
      showTodayButton: widget.showTodayButton,
      initialSelectedDate: widget.initialDate,
      view: DateRangePickerView.month,
      selectionMode: _resolveSelectionMode(),
      headerStyle: DateRangePickerHeaderStyle(
          backgroundColor: Colors.transparent,
          textStyle: WhisprTextStyles.heading4
              .copyWith(color: WhisprColors.spanishViolet)),
      monthViewSettings:
          DateRangePickerMonthViewSettings(specialDates: widget.markedDate),
      monthCellStyle: DateRangePickerMonthCellStyle(
        specialDatesDecoration: WhisprDotIndicator(
            color: WhisprColors.vistaBlue, radius: 3, yOffset: 6),
      ),
      onSubmit: (value) {
        switch (widget.selectionMode) {
          case DatePickerSelectionMode.single:
            widget.onDateSelected
                ?.call(value == null ? null : value as DateTime);
            break;
          case DatePickerSelectionMode.range:
            widget.onDateRangeSelected?.call(value as List<DateTime>);
            break;
        }
        context.router.maybePop();
      },
      onCancel: () {
        context.router.maybePop();
      },
    );
  }

  DateRangePickerSelectionMode _resolveSelectionMode() {
    return switch (widget.selectionMode) {
      DatePickerSelectionMode.single => DateRangePickerSelectionMode.single,
      DatePickerSelectionMode.range => DateRangePickerSelectionMode.range,
    };
  }
}

enum DatePickerSelectionMode { single, range }
