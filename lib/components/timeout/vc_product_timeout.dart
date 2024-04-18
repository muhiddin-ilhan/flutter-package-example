import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/timeout/vc_product_countdown.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

// ignore: must_be_immutable
class VCProductTimeout extends StatefulWidget {
  /// Duration for which the timeout popup will be displayed.
  /// Represents the time until the onTimeOut callback is triggered.
  int duration;

  /// Optional title text to be displayed at the top of the timeout popup.
  String? title;

  /// Optional description text providing additional information in the timeout popup.
  String? description;

  /// Text to be displayed on the primary button of the timeout popup.
  String? primaryButtonText;

  /// Text to be displayed on the secondary button of the timeout popup.
  String? secondaryButtonText;

  /// Style for the title text in the timeout popup.
  TextStyle? titleStyle;

  /// Style for the description text in the timeout popup.
  TextStyle? descriptionStyle;

  /// Callback function triggered when the primary button is tapped.
  /// Typically used for the action associated with the primary button.
  Function() onPrimaryButtonTap;

  /// Callback function triggered when the secondary button is tapped.
  /// Typically used for the action associated with the secondary button.
  Function() onSecondaryButtonTap;

  /// Callback function triggered when the timeout duration is reached.
  /// Typically used for handling actions when the timeout occurs.
  Function() onTimeOut;

  final String secondsText;

  VCProductTimeout({
    Key? key,
    required this.duration,
    required this.onTimeOut,
    required this.onPrimaryButtonTap,
    required this.onSecondaryButtonTap,
    this.title,
    this.titleStyle,
    this.description,
    this.descriptionStyle,
    this.primaryButtonText,
    this.secondaryButtonText,
    required this.secondsText,
  }) : super(key: key);

  @override
  State<VCProductTimeout> createState() => _VCProductTimeoutState();
}

class _VCProductTimeoutState extends State<VCProductTimeout> {
  ///All cost values given according to figma
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: VCProductColors.instance.white,
      ),
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.title ?? "",
              style: widget.titleStyle ??
                  const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Inter"),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 36),
            Text(
              widget.description ?? "",
              textAlign: TextAlign.center,
              style: widget.descriptionStyle ??
                  const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Inter"),
            ),
            const SizedBox(height: 64),
            VCProductCountdown(
                secondsText: widget.secondsText,
                duration: widget.duration,
                onTimeOut: widget.onTimeOut),
            const SizedBox(height: 64),
            VCButton(
              buttonSize: VCButtonSize.custom,
              height: 52,
              onTap: widget.onPrimaryButtonTap,
              backgroundColor: VCProductColors.instance.activeTileColor,
              buttonType: VCButtonType.primary,
              child: Text(widget.primaryButtonText ?? ""),
            ),
            const SizedBox(height: 36),
            VCButton(
              buttonSize: VCButtonSize.custom,
              height: 52,
              buttonType: VCButtonType.stroke,
              foregroundColor: VCProductColors.instance.activeTileColor,
              splashColor:
                  VCProductColors.instance.activeTileColor.withOpacity(0.5),
              onTap: widget.onSecondaryButtonTap,
              child: Text(widget.secondaryButtonText ?? ""),
            ),
          ],
        ),
      ),
    );
  }
}
