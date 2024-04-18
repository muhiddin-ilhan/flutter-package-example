import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/timeout/vc_product_login_countdown_circle_widget.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

enum CountDownType { login, product }

class VCProductCountdown extends StatefulWidget {
  /// Size of the circular countdown widget.
  final double circleSize;

  /// Size of the text inside the countdown widget.
  final double? textSize;

  /// Color of the circular progress indicator.
  final Color? color;

  /// Color of the circular progress indicator.
  final Color? textColor;

  /// Background color of the circular countdown widget.
  final Color? backgroundColor;

  /// Style for the text inside the countdown widget.
  final TextStyle? textStyle;

  /// Style for the number text inside the countdown widget.
  final TextStyle? numberTextStyle;

  /// Width of the circular progress indicator.
  final double strokeWidth;

  /// Duration for which the countdown will run.
  final int duration;

  /// Callback function triggered when the countdown reaches zero.
  final Function onTimeOut;

  final String secondsText;

  final CountDownType countDownType;

  const VCProductCountdown(
      {super.key,
      this.circleSize = 150,
      this.textSize,
      this.color,
      this.backgroundColor,
      this.textStyle,
      this.textColor,
      this.numberTextStyle,
      this.strokeWidth = 8,
      required this.duration,
      required this.onTimeOut,
      required this.secondsText,
      this.countDownType = CountDownType.product});

  @override
  VCProductCountdownState createState() => VCProductCountdownState();
}

class VCProductCountdownState extends State<VCProductCountdown>
    with TickerProviderStateMixin {
  late Color primaryColor;
  late Color warningColor;
  late Color errorColor;
  late Color? backgroundColor;
  late AnimationController controller;
  bool isRefreshedLoginCountdown = false;
  String get countText {
    var count =(controller.duration!.inSeconds *  controller.value ).ceil();
    return count.toString();

    ///'${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  int get count {
    var count =controller.duration! * controller.value ;
    return count.inSeconds;
  }

  double progress = 0;

  void notify() {
    widget.onTimeOut();
  }

  @override
  void initState() {
    super.initState();

    primaryColor = widget.color ?? VCProductColors.instance.activeTileColor;
    warningColor =
        widget.color ?? VCProductColors.instance.countdownWarningColor;
    errorColor = widget.color ?? VCProductColors.instance.statusErrorColor;

    backgroundColor =
        widget.backgroundColor ?? VCProductColors.instance.widgetBorderColor;

    startCountdown();
  }

  void startCountdown() {
    progress = 0;
    isRefreshedLoginCountdown = !isRefreshedLoginCountdown;
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );

    controller.addListener(() {
      if (controller.isAnimating) {
        setState(() {
          progress = 1 - controller.value;
        });
      } else if (progress != 0) {
        setState(() {
          notify();
        });
      }
    });

    controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (count <= 10) {
      primaryColor = errorColor;
    } else if (count <= 30) {
      primaryColor = warningColor;
    } else {
      primaryColor = widget.color ?? VCProductColors.instance.activeTileColor;
    }
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            if (widget.countDownType == CountDownType.product)
              SizedBox(
                width: widget.circleSize,
                height: widget.circleSize,
                child: CircularProgressIndicator(
                  backgroundColor: backgroundColor,
                  color: primaryColor,
                  value: progress,
                  strokeWidth: widget.strokeWidth,
                  strokeCap: StrokeCap.round,
                ),
              ),
            if (widget.countDownType == CountDownType.login)
              TweenAnimationBuilder<double>(
                key: ValueKey(isRefreshedLoginCountdown),
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(seconds: widget.duration),
                builder: (context, value, child) {
                  return CustomPaint(
                    size: Size.square(widget.circleSize),
                    painter: VCProductLoginCountdownCircle(
                        progress: value, circleSize: widget.circleSize),
                  );
                },
              ),
            GestureDetector(
              onTap: () {
                if (controller.isDismissed) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => CupertinoTimerPicker(
                      initialTimerDuration: controller.duration!,
                      onTimerDurationChanged: (time) {
                        setState(() {
                          controller.duration = time;
                        });
                      },
                    ),
                  );
                }
              },
              child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) => Wrap(
                        direction: Axis.vertical,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            countText,
                            style: widget.textStyle ??
                                TextStyle(
                                  color: widget.textColor ?? primaryColor,
                                  fontSize: widget.textSize ??
                                      widget.circleSize / 3.5,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            widget.secondsText,
                            style: widget.numberTextStyle ??
                                TextStyle(
                                  color: VCProductColors.instance.black75,
                                  fontSize:
                                      widget.textSize ?? widget.circleSize / 8,
                                ),
                          ),
                        ],
                      )),
            ),
          ],
        ),
      ],
    );
  }
}
