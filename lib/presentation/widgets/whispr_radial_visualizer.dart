import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WhisprRadialVisualizer extends StatefulWidget {
  /// Normalized level in [0..1]. Pass `null` to decay to zero.
  final double? level;

  final int barCount;
  final Color barColor;
  final Widget? center;
  final double smoothingFactor;
  final double ema;
  final double amplificationFactor;
  final Curve curve;

  const WhisprRadialVisualizer({
    super.key,
    required this.level,
    this.center,
    this.barCount = 150,
    this.barColor = Colors.white,
    this.smoothingFactor = 0.1,
    this.amplificationFactor = 3,
    this.ema = 0.5,
    this.curve = Curves.easeOutSine,
  }) : assert(barCount > 0);

  @override
  State<WhisprRadialVisualizer> createState() => _WhisprRadialVisualizerState();
}

class _WhisprRadialVisualizerState extends State<WhisprRadialVisualizer>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  late List<double> _targets;
  late List<double> _display;

  @override
  void initState() {
    super.initState();
    _targets = List<double>.filled(widget.barCount, 0);
    _display = List<double>.filled(widget.barCount, 0);

    _ticker = createTicker((_) {
      // Ease display toward targets
      bool changed = false;
      for (var i = 0; i < _display.length; i++) {
        final d = lerpDouble(_display[i], _targets[i], widget.smoothingFactor)!;
        if ((d - _display[i]).abs() > 1e-4) {
          _display[i] = d;
          changed = true;
        }
      }
      if (changed && mounted) {
        setState(() {});
      }
    })
      ..start();

    _ingestLevel(widget.level);
  }

  @override
  void didUpdateWidget(covariant WhisprRadialVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.level != widget.level) {
      _ingestLevel(widget.level);
    }
  }

  void _ingestLevel(double? level) {
    // Null level -> decay all bars toward zero target
    if (level == null) {
      _decayToZero();
      return;
    }

    // Perceptual boost: emphasize louder parts a bit
    final amplifiedV =
        pow(level.clamp(0.0, 1.0), widget.amplificationFactor).toDouble();

    // Simple EMA against the "head" of the bar buffer
    final smoothed =
        widget.ema * (_targets.first) + (1 - widget.ema) * amplifiedV;

    // Shift right (like an oscilloscope/radial sweep)
    for (int i = _targets.length - 1; i > 0; i--) {
      _targets[i] = _targets[i - 1];
    }
    _targets[0] = smoothed.clamp(0.0, 1.0);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final minSide = min(constraints.maxWidth, constraints.maxHeight);

        return Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size.square(minSide), // Follows parent constraints
              painter: _RadialBarsPainter(
                levels: _display,
                barColor: widget.barColor,
                curve: widget.curve,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: widget.center,
            ),
          ],
        );
      },
    );
  }
}

class _RadialBarsPainter extends CustomPainter {
  final List<double> levels; // 0..1
  final double barToBaseRatio;
  final Color barColor;
  final Curve curve;

  _RadialBarsPainter({
    required this.levels,
    required this.barColor,
    required this.curve,
    this.barToBaseRatio = 0.5,
  })  : assert(barToBaseRatio < 1),
        assert(barToBaseRatio >= 0);

  @override
  void paint(Canvas canvas, Size size) {
    final n = levels.length;
    if (n == 0) return;

    final center = size.center(Offset.zero);
    final baseRadius = size.height * (1 - barToBaseRatio) / 2;
    final angleStep = 2 * pi / n;
    final maxBarPx = size.height * barToBaseRatio / 2;

    final paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = barColor;

    for (var i = 0; i < n; i++) {
      final a = i * angleStep - pi / 2;
      final eased = curve.transform(levels[i].clamp(0.0, 1.0));
      final len = eased * maxBarPx;

      final sx = center.dx + baseRadius * cos(a);
      final sy = center.dy + baseRadius * sin(a);
      final ex = center.dx + (baseRadius + len) * cos(a);
      final ey = center.dy + (baseRadius + len) * sin(a);

      canvas.drawLine(Offset(sx, sy), Offset(ex, ey), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RadialBarsPainter oldDelegate) => true;
}
