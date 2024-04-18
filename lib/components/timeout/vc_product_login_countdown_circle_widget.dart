import 'package:flutter/material.dart';
import 'dart:math' as math;

class VCProductLoginCountdownCircle extends CustomPainter {
  final double progress;
  final double? strokeWidth;
  final double? filledLineLength;
  final double? nonFilledLineLength;
  final double circleSize;

  VCProductLoginCountdownCircle(
      {required this.progress,
      this.circleSize = 150,
      this.strokeWidth,
      this.filledLineLength,
      this.nonFilledLineLength});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth ?? (1 + circleSize / 80)
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    const int numTicks = 36; // according to figma design
    const double tickSpacing = (2 * math.pi) / numTicks;

    const double startAngle = -math.pi / 2;

    for (int i = 0; i < numTicks; i++) {
      final double angle = startAngle + (i * tickSpacing);
      final double x1 = center.dx + radius * math.cos(angle);
      final double y1 = center.dy + radius * math.sin(angle);

      final double lineLength = (i / numTicks <= progress)
          ? nonFilledLineLength ?? (circleSize / 11)
          : filledLineLength ?? (circleSize / 7);
      final double x2 =
          center.dx + (radius - 1.5 - lineLength) * math.cos(angle);
      final double y2 =
          center.dy + (radius - 1.5 - lineLength) * math.sin(angle);

      final Color color = (i / numTicks <= progress)
          ? _getGradientColor(i / numTicks)
          : const Color(0xFF6B88D2); // color accordig to figma design
      paint.color = color;
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  Color _getGradientColor(double progress) {
    // color accordig to figma design
    List<Color> colors = const [
      Color(0xFF4EEBD5),
      Color(0xFF50BFA5),
      Color(0xFFB36CEF),
      Color(0xFFCF2D8E),
      Color(0xFFCF2D8E),
    ];

    List<double> stops = [0.0, 0.1759, 0.3101, 0.4984, 0.6713];

    for (int i = 0; i < stops.length - 1; i++) {
      if (progress >= stops[i] && progress <= stops[i + 1]) {
        final double ratio = (progress - stops[i]) / (stops[i + 1] - stops[i]);
        return Color.lerp(colors[i], colors[i + 1], ratio)!;
      }
    }

    return colors.last;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
