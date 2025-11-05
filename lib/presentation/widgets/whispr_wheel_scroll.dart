import 'package:flutter/material.dart';

import 'base_widget/wheel_picker.dart';
import 'base_widget/wheel_picker_style.dart';

class WhisprWheelScroll<T> extends StatefulWidget {
  const WhisprWheelScroll({
    super.key,
    required this.items,
    required this.onSelected,
    required this.selectedWidget,
    required this.unselectedWidget,
    this.itemSize = 75,
    this.squeeze = 1,
    this.diameterRatio = 1,
    this.magnification = 1,
    this.initialIndex,
    this.selectedLabel,
    this.selectedLabelStyle,
    this.looping = false,
    this.scrollDirection = Axis.horizontal,
  });

  final int? initialIndex;
  final double itemSize;
  final double squeeze;
  final double magnification;
  final double diameterRatio;
  final bool looping;
  final List<T> items;
  final Axis scrollDirection;
  final Function(T) onSelected;
  final String Function(T)? selectedLabel;
  final Widget Function(T) selectedWidget;
  final Widget Function(T, int, int) unselectedWidget;
  final TextStyle? selectedLabelStyle;

  @override
  State<WhisprWheelScroll<T>> createState() => _WhisprWheelScrollState<T>();
}

class _WhisprWheelScrollState<T> extends State<WhisprWheelScroll<T>> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        WheelPicker(
          itemCount: widget.items.length,
          builder: (context, index) => _currentIndex == index
              ? widget.selectedWidget(widget.items[index])
              : widget.unselectedWidget(
                  widget.items[index], _currentIndex, index),
          onIndexChanged: (index, _) {
            _currentIndex = index;
            setState(() {});
            widget.onSelected(widget.items[index]);
          },
          initialIndex: widget.initialIndex,
          looping: widget.looping,
          scrollDirection: widget.scrollDirection,
          style: WheelPickerStyle(
            diameterRatio: widget.diameterRatio,
            itemExtent: widget.itemSize,
            magnification: widget.magnification,
            squeeze: widget.squeeze,
          ),
        ),
        SizedBox(
          height: widget.selectedLabel != null ? 8 : 0,
        ),
        widget.selectedLabel != null
            ? Text(
                widget.selectedLabel!(widget.items[_currentIndex]),
                style: widget.selectedLabelStyle,
              )
            : SizedBox()
      ],
    );
  }
}
