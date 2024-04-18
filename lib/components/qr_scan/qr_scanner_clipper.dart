import 'package:flutter/rendering.dart';

class QrScannerClipper extends CustomClipper<Path> {
  final double? height;

  QrScannerClipper({this.height});

  @override
  Path getClip(Size size) {
    return Path.combine(
      PathOperation.difference,
      Path()..addRRect(RRect.fromRectAndRadius(Rect.largest, Radius.zero)),
      getBox(size),
    );
  }

  Path getBox(Size size, [double padding = 0.0]) {
    final bool hasHeight = this.height == null;
    final double width = (hasHeight ? size.shortestSide : size.width) -
        (80) -
        padding;
    final double height = hasHeight ? width : 44.0 - padding;

    final Offset center = Offset(size.width / 2, size.height / 2);

    return Path()
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromCenter(
          center: center,
          width: width,
          height: height,
        ),
      ));
  }

  Path getBoxWithLines(Size size, [double padding = 0.0]) {
    final bool hasHeight = this.height == null;
    final double width = (hasHeight ? size.shortestSide : size.width) -
        (80) -
        padding;
    final double height = hasHeight ? width : 44.0 - padding;

    final Offset center = Offset(size.width / 2, size.height / 2);

    const double cornersLength = 20;

    final Path path = Path();

    // Sol üst köşe
    path.moveTo(center.dx - width / 2, center.dy - height / 2);
    path.lineTo(center.dx - width / 2 + cornersLength, center.dy - height / 2);
    path.moveTo(center.dx - width / 2, center.dy - height / 2);
    path.lineTo(center.dx - width / 2, center.dy - height / 2 + cornersLength);

    // Sağ üst köşe
    path.moveTo(center.dx + width / 2, center.dy - height / 2);
    path.lineTo(center.dx + width / 2 - cornersLength, center.dy - height / 2);
    path.moveTo(center.dx + width / 2, center.dy - height / 2);
    path.lineTo(center.dx + width / 2, center.dy - height / 2 + cornersLength);

    // Sağ alt köşe
    path.moveTo(center.dx + width / 2, center.dy + height / 2);
    path.lineTo(center.dx + width / 2 - cornersLength, center.dy + height / 2);
    path.moveTo(center.dx + width / 2, center.dy + height / 2);
    path.lineTo(center.dx + width / 2, center.dy + height / 2 - cornersLength);

    // Sol alt köşe
    path.moveTo(center.dx - width / 2, center.dy + height / 2);
    path.lineTo(center.dx - width / 2 + cornersLength, center.dy + height / 2);
    path.moveTo(center.dx - width / 2, center.dy + height / 2);
    path.lineTo(center.dx - width / 2, center.dy + height / 2 - cornersLength);

    return path;
  }
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

