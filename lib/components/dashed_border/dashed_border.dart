import 'dart:math';

import 'package:flutter/material.dart';

class DashedBorder extends CustomPainter {
  final Color completeColor;
  final double width;

  DashedBorder({required this.completeColor, required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    var percent = (size.width * 0.001) / 2;

    double arcAngle = 2 * pi * percent;

    for (var i = 0; i < 16; i++) {
      var init = (-pi / 3.5) * (i / 2);

      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), init, arcAngle, false, complete);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
