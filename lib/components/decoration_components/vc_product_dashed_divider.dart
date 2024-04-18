import 'package:flutter/material.dart';

class VCProductDashedDivider extends StatelessWidget {
  final double thickness;
  final double height;
  final Color color;

  const VCProductDashedDivider({
    Key? key,
    this.thickness = 1.0,
    this.height = 0.0,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomPaint(
            painter: _DashedLinePainter(
              thickness: thickness,
              height: height,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final double thickness;
  final double height;
  final Color color;

  _DashedLinePainter({
    required this.thickness,
    required this.height,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    const double startX = 0.0;
    final double startY = height / 2;
    final double endX = size.width;
    final double endY = height / 2;

    const double dashWidth = 4.5;
    const double dashSpace = 1.0;

    double currentX = startX;
    bool drawDash = true;

    while (currentX < endX) {
      if (drawDash) {
        canvas.drawLine(
          Offset(currentX, startY),
          Offset(currentX + dashWidth, endY),
          paint,
        );
      }
      currentX += dashWidth + dashSpace;
      drawDash = !drawDash;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
