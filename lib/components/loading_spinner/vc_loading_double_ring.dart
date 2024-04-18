import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class VCLoadingDoubleRing extends StatefulWidget {
  const VCLoadingDoubleRing({
    Key? key,
    required this.color1,
    required this.color2,
    this.lineWidth = 4.0,
    this.size = 40.0,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  }) : super(key: key);

  final Color color1;
  final Color color2;
  final double lineWidth;
  final double size;
  final Duration duration;
  final AnimationController? controller;

  @override
  State<VCLoadingDoubleRing> createState() => _VCLoadingDoubleRingState();
}

class _VCLoadingDoubleRingState extends State<VCLoadingDoubleRing> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ?? AnimationController(vsync: this, duration: widget.duration))
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      })
      ..repeat();
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
          alignment: AlignmentDirectional.center,
        children: [
          Transform(
            transform: Matrix4.identity()..rotateZ((_animation.value) * math.pi * 2),
            alignment: FractionalOffset.center,
            child: CustomPaint(
              painter: _VCLoadingDoubleRingPainter(
                angle: 180,
                paintWidth: widget.lineWidth,
                color: widget.color1,
              ),
              child: SizedBox.fromSize(size: Size.square(widget.size)),
            ),
          ),
          Transform(
              transform: Matrix4.identity()..rotateZ(-(_animation.value) * math.pi * 2),
              alignment: FractionalOffset.center,
              child: CustomPaint(
                painter: _VCLoadingDoubleRingPainter(
                  angle: 180,
                  paintWidth: widget.lineWidth,
                  color: widget.color2,
                ),
                child: SizedBox.fromSize(size: Size.square(widget.size*(widget.size-(widget.lineWidth*4))/widget.size)),
              ),
            ),

        ],
      ),
    );
  }
}

class _VCLoadingDoubleRingPainter extends CustomPainter {
  _VCLoadingDoubleRingPainter({
    required this.angle,
    required double paintWidth,
    required Color color,
  }) : ringPaint = Paint()
    ..color = color
    ..strokeWidth = paintWidth
    ..style = PaintingStyle.stroke;

  final Paint ringPaint;
  final double angle;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromPoints(Offset.zero, Offset(size.width, size.height));
    canvas.drawArc(rect, 0.0, getRadian(angle), false, ringPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  double getRadian(double angle) => math.pi / 180 * angle;
}