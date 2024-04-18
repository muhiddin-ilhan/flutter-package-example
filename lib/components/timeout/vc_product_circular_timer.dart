// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

// ignore: must_be_immutable
class VCProductCountdown extends StatefulWidget {
  VCProductCountdown({
  Key? key, 
  required this.onTimeOut,
  required this.duration,
  this.backgroundColor, 
  this.circleSize = 150, 
  this.strokeWidth = 8,
  this.color, 
  this.textSize , 
  this.textStyle}) : super(key: key);

  double circleSize;
  double? textSize;
  Color? color;
  Color? backgroundColor;
  TextStyle? textStyle;
  double strokeWidth;
  int duration;
  Function onTimeOut;

  @override
  _VCProductCountdownState createState() => _VCProductCountdownState();
}

class _VCProductCountdownState extends State<VCProductCountdown>
    with TickerProviderStateMixin {

late Color color;
late Color? backgroundColor;
late AnimationController controller;
  String get countText {
    var count = controller.duration! * controller.value;
    return count.inSeconds.toString();//'${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 0;

  void notify() {
      widget.onTimeOut();
  }

  @override
  void initState() {
    super.initState();

  color = widget.color ?? VCProductColors.instance.activeTileColor;
  backgroundColor = widget.backgroundColor ?? VCProductColors.instance.widgetBorderColor;

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );

    controller.addListener(() { 
      if (controller.isAnimating) {
        setState(() {
          progress = 1 - controller.value;
        });
      }else if(progress != 0){
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
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: widget.circleSize,
              height: widget.circleSize,
              child: CircularProgressIndicator(
                backgroundColor: backgroundColor,
                color: color,
                value: progress,
                strokeWidth: widget.strokeWidth,
                strokeCap: StrokeCap.round,
              ),
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
                  children: [Text(
                  countText,
                  style: widget.textStyle ??
                      TextStyle(
                        color: color,
                        fontSize: widget.textSize ?? widget.circleSize / 3,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  "Seconds",
                  style: widget.textStyle ??
                      TextStyle(
                        color: VCProductColors.instance.black75,
                        fontSize: widget.textSize ?? widget.circleSize / 8,
                      ),
                ),],
                )
              ),
            ),
          ],
        ),
       
      ],
    );
  }
}
