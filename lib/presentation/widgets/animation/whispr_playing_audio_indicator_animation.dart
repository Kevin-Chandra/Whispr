import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';

class WhisprPlayingAudioIndicator extends StatefulWidget {
  const WhisprPlayingAudioIndicator({
    super.key,
    this.barCount = 3,
    this.minBarHeight = 8,
    this.maxBarHeight = 32,
    this.barWidth = 10,
    this.gap = 4,
    this.color = WhisprColors.mediumPurple,
  });

  final int barCount;
  final double minBarHeight;
  final double maxBarHeight;
  final double barWidth;
  final double gap;
  final Color color;

  @override
  State<WhisprPlayingAudioIndicator> createState() =>
      _WhisprPlayingAudioIndicatorState();
}

class _WhisprPlayingAudioIndicatorState
    extends State<WhisprPlayingAudioIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bars = List.generate(widget.barCount, (i) => i);
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Row(
          spacing: widget.gap,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: bars
              .map(
                (i) => _Bar(
                  animationValue: _controller.value,
                  index: i,
                  total: widget.barCount,
                  minHeight: widget.minBarHeight,
                  maxHeight: widget.maxBarHeight,
                  width: widget.barWidth,
                  color: widget.color,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    required this.animationValue,
    required this.index,
    required this.total,
    required this.minHeight,
    required this.maxHeight,
    required this.width,
    required this.color,
  });

  final double animationValue;
  final int index;
  final int total;
  final double minHeight, maxHeight, width;
  final Color color;

  double _height() {
    final phase = (index / total) * math.pi * 0.4;
    final freq = 2 * math.pi * (1 + index);
    final s = (math.sin(freq * animationValue + phase) + 1) / 2; // 0..1
    return lerpDouble(minHeight, maxHeight, s)!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: _height(),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
