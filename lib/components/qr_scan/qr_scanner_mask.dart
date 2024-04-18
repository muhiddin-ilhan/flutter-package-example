import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/qr_scan/qr_scanner_clipper.dart';

import '../../utils/color_constant.dart';

class QrScannerMask extends CustomPainter {
  final QrScannerClipper clipper;

  QrScannerMask({
    Key? key,
    required this.clipper,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = VCProductColors.instance.black.withOpacity(0.75);
    const strokeWidth = 1.0;

    canvas.drawPath(
      clipper.getClip(size),
      paint,
    );

    paint
      ..color = VCProductColors.instance.scannerBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawPath(
      clipper.getBox(size, strokeWidth / 2),
      paint,
    );

    paint
      ..color = VCProductColors.instance.scannerCorners
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawPath(
      clipper.getBoxWithLines(size, strokeWidth / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
