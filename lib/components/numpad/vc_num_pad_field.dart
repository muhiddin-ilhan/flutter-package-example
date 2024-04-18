import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'vc_num_pad_button.dart';

class VCNumPadField extends StatelessWidget {
  /// Callback when number pressed
  final void Function(String number)? onType;

  /// Callback when left action pressed
  final void Function(String number)? onLeftAction;

  /// Callback when right action pressed
  final void Function()? onDeleteAction;

  /// for spacing horizontal default [MainAxisAlignment.spaceBetween]
  final MainAxisAlignment mainAxisAlignment;

  /// padding over the whole layout default [horizontal = 30]
  final EdgeInsets? padding;

  /// on Holding pressed any number default [Color(0xFFC9C9C9)]
  final Color? highlightColor;

  /// on button background color default [Colors.white]
  final Color? backgroundColor;

  /// spacing vertical default [40]
  final double runSpace;

  /// custom number style
  final TextStyle? numberStyle;

  /// radius for the shape of the number default [45]
  final double? radius;

  /// fingerprint button left bottom default false
  final bool isFingerPrintActive;

  /// editable field controller to edit
  final TextEditingController? controller;

  /// formatter to format controller
  final TextInputFormatter? formatter;

  const VCNumPadField(
      {Key? key,
      this.onType,
      this.onLeftAction,
      this.onDeleteAction,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.padding,
      this.highlightColor,
      this.backgroundColor,
      this.runSpace = 40,
      this.numberStyle,
      this.radius,
      this.isFingerPrintActive = false,
      this.controller,
      this.formatter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              for (int number = 1; number <= 3; number++)
                VCNumPadButton(
                  number: number.toString(),
                  highlightColor: highlightColor,
                  backgroundColor: backgroundColor,
                  numberStyle: numberStyle,
                  radius: radius,
                  onTap: () => onTypeNumber(number.toString()),
                ),
            ],
          ),
          SizedBox(
            height: runSpace,
          ),
          Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              for (int number = 4; number <= 6; number++)
                VCNumPadButton(
                  number: number.toString(),
                  highlightColor: highlightColor,
                  backgroundColor: backgroundColor,
                  numberStyle: numberStyle,
                  radius: radius,
                  onTap: () => onTypeNumber(number.toString()),
                ),
            ],
          ),
          SizedBox(
            height: runSpace,
          ),
          Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              for (int number = 7; number <= 9; number++)
                VCNumPadButton(
                  number: number.toString(),
                  highlightColor: highlightColor,
                  backgroundColor: backgroundColor,
                  numberStyle: numberStyle,
                  radius: radius,
                  onTap: () => onTypeNumber(number.toString()),
                ),
            ],
          ),
          SizedBox(
            height: runSpace,
          ),
          Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              if (isFingerPrintActive) ...[
                VCNumPadButton(
                  number: ".",
                  highlightColor: highlightColor,
                  backgroundColor: backgroundColor,
                  numberStyle: numberStyle,
                  radius: radius,
                  onTap: () => {},
                  icon: Icons.fingerprint,
                ),
              ] else ...[
                VCNumPadButton(
                  number: ".",
                  highlightColor: highlightColor,
                  backgroundColor: backgroundColor,
                  numberStyle: numberStyle,
                  radius: radius,
                  onTap: () => onTypeNumber("."),
                ),
              ],
              VCNumPadButton(
                number: "0",
                highlightColor: highlightColor,
                backgroundColor: backgroundColor,
                numberStyle: numberStyle,
                radius: radius,
                onTap: () => onTypeNumber("0"),
              ),
              VCNumPadButton(
                number: "",
                highlightColor: highlightColor,
                backgroundColor: backgroundColor,
                numberStyle: numberStyle,
                radius: radius,
                onTap: () => onDeleteNumber(),
                icon: Icons.backspace_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onTypeNumber(String number) {
    if (onType != null) {
      onType!(number);
    } else if (controller != null) {
      controller?.text =
          formatter != null?
          formatter!
          .formatEditUpdate(controller!.value,
              TextEditingValue(text: controller!.text + number))
          .text : controller!.text + number;
    }
  }

  void onDeleteNumber() {
    if (onDeleteAction != null) {
      onDeleteAction!();
    } else if (controller != null) {
      if (controller!.text.isNotEmpty) {
        controller!.text = formatter != null
            ? formatter!
                .formatEditUpdate(
                    controller!.value,
                    TextEditingValue(
                        text: controller!.text
                            .substring(0, controller!.text.length - 1)))
                .text
            : controller!.text.substring(0, controller!.text.length - 1);
      }
    }
  }
}
