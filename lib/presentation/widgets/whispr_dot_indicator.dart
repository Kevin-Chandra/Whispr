import 'package:flutter/material.dart';

class WhisprDotIndicator extends Decoration {
  const WhisprDotIndicator({
    required this.color,
    this.radius = 3.5,
    this.yOffset = 6, // distance from the bottom edge
  });

  final Color color;
  final double radius;
  final double yOffset;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _DotPainter(color, radius, yOffset);
}

class _DotPainter extends BoxPainter {
  _DotPainter(this.color, this.radius, this.yOffset);

  final Color color;
  final double radius;
  final double yOffset;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    if (cfg.size == null) return;
    final rect = offset & cfg.size!;
    final center = Offset(rect.center.dx, rect.bottom - yOffset);
    final paint = Paint()
      ..color = color
      ..isAntiAlias = true;
    canvas.drawCircle(center, radius, paint);
  }
}
