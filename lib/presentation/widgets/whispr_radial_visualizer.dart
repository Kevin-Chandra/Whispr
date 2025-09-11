import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WhisprRadialVisualizer extends StatefulWidget {
  final Stream<double?> levels; // 0..1
  final int barCount;
  final double maxBarPx;
  final Color barColor;
  final Widget? center;

  const WhisprRadialVisualizer({
    super.key,
    required this.levels,
    this.center,
    this.barCount = 150,
    this.maxBarPx = 50,
    this.barColor = Colors.white,
  });

  @override
  State<WhisprRadialVisualizer> createState() => _WhisprRadialVisualizerState();
}

class _WhisprRadialVisualizerState extends State<WhisprRadialVisualizer>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  StreamSubscription<double?>? _levelSub;
  late List<double> _targets;
  late List<double> _display;

  @override
  void initState() {
    super.initState();
    _targets = List<double>.filled(widget.barCount, 0);
    _display = List<double>.filled(widget.barCount, 0);

    _levelSub = widget.levels.listen(_onLevel);

    _ticker = createTicker((_) {
      const k = 0.18;
      bool changed = false;
      for (var i = 0; i < _display.length; i++) {
        final d = lerpDouble(_display[i], _targets[i], k)!;
        if ((d - _display[i]).abs() > 1e-4) {
          _display[i] = d;
          changed = true;
        }
      }
      if (changed && mounted) setState(() {});
    })
      ..start();
  }

  void _onLevel(double? v) {
    // Reset bars if level is null.
    if (v == null) {
      _decayToZero();
      return;
    }

    final amplifiedV = pow(v, 2);

    final ema = 0.5;
    final smoothed = ema * (_targets.first) + (1 - ema) * amplifiedV;

    for (int i = _targets.length - 1; i > 0; i--) {
      _targets[i] = _targets[i - 1];
    }
    _targets[0] = smoothed.clamp(0, 1);

    for (var i = 0; i < _targets.length; i++) {
      final jitter = 0.04 * sin(i * 0.35);
      _targets[i] = (_targets[i] + jitter).clamp(0.0, 1.0);
    }
  }

  void _decayToZero() {
    for (var i = 0; i < _targets.length; i++) {
      _targets[i] = 0.0;
    }
  }

  @override
  void dispose() {
    _ticker.stop();
    _ticker.dispose();
    _levelSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(160, 160),
          painter: _RadialBarsPainter(
            levels: _display,
            maxBarPx: widget.maxBarPx,
            barColor: widget.barColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(widget.maxBarPx),
          child: widget.center,
        ),
      ],
    );
  }
}

class _RadialBarsPainter extends CustomPainter {
  final List<double> levels; // 0..1
  final double maxBarPx;
  final Color barColor;
  final Curve curve;

  _RadialBarsPainter({
    required this.barColor,
    required this.levels,
    required this.maxBarPx,
    this.curve = Curves.easeOutSine,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final n = levels.length;
    if (n == 0) return;

    final center = size.center(Offset.zero);
    final baseRadius = min(size.width, size.height) * 0.42;
    final angleStep = 2 * pi / n;

    final paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = barColor;

    for (var i = 0; i < n; i++) {
      final a = i * angleStep - pi / 2;
      final eased = curve.transform(levels[i].clamp(0, 1));
      final len = eased * maxBarPx;

      final sx = center.dx + baseRadius * cos(a);
      final sy = center.dy + baseRadius * sin(a);
      final ex = center.dx + (baseRadius + len) * cos(a);
      final ey = center.dy + (baseRadius + len) * sin(a);

      paint.color = barColor;

      canvas.drawLine(Offset(sx, sy), Offset(ex, ey), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RadialBarsPainter old) => true;
}
