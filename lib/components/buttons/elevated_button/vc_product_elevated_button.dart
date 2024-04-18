import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/components/buttons/elevated_button/button_size.dart';
import 'package:vc_product_widgets/components/buttons/elevated_button/button_type.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';

class VCProductElevatedButton extends StatelessWidget {
  /// The text to display on the button (optional).

  final String? text;

  /// A custom widget to use as the button's child (optional).

  final Widget? child;

  /// The type of the button (e.g., standard or disabled).

  final ButtonType? type;

  /// Callback function when the button is pressed.

  final VoidCallback onPressed;

  /// The background color of the button (optional).

  final Color? backgroundColor;

  /// The size of the button (e.g., small, medium, large) (optional).

  final ButtonSize? size;

  final Size? fixedSize;

  final double? fontSize;

  final Color? borderColor;
  final TypographyType? typogaphyType;

  const VCProductElevatedButton({
    super.key,
    this.text,
    this.child,
    required this.onPressed,
    this.type = ButtonType.standart,
    this.backgroundColor = const Color(0xFF15284B), //navyBlue color
    this.size = ButtonSize.medium,
    this.fontSize,
    this.fixedSize,
    this.borderColor,
    this.typogaphyType,
  });

  @override
  Widget build(BuildContext context) {
    try {
      switch (type) {
        case ButtonType.standart:
          return buildElevatedButton(
              context: context,
              buttonSize: fixedSize,
              typogaphyType: typogaphyType);

        case ButtonType.disabled:
          return buildElevatedButton(
              disable: true,
              context: context,
              buttonSize: fixedSize,
              typogaphyType: typogaphyType);

        case ButtonType.outlined:
          return buildOutlinedButton(
              typogaphyType: typogaphyType,
              context: context,
              buttonSize: fixedSize,
              borderColor: borderColor);

        case ButtonType.outlinedDisabled:
          return buildOutlinedButton(
              typogaphyType: typogaphyType,
              disable: true,
              context: context,
              buttonSize: fixedSize,
              borderColor: borderColor);

        default:
          return buildElevatedButton(context: context, buttonSize: fixedSize);
      }
    } catch (e) {
      return const Text(
          "Please provide at least one of the 'text' or 'child' parameters.");
    }
  }

  ElevatedButton buildElevatedButton(
      {bool? disable,
      required BuildContext context,
      Size? buttonSize,
      TypographyType? typogaphyType}) {
    return ElevatedButton(
        onPressed: disable == true ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          fixedSize: buttonSize ?? ButtonSizeLabel().size(size, context),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: context.lowBorderRadius,
          ),
        ),
        child: child ??
            VCProductComponents.text(
                fontSize: fontSize,
                text: text!,
                textAlign: TextAlign.center,
                textColor: VCProductColors.instance.white,
                typographyType:TypographyType.btnTab));
  }

  OutlinedButton buildOutlinedButton(
      {bool? disable,
      required BuildContext context,
      Size? buttonSize,
      TypographyType? typogaphyType,
      Color? borderColor}) {
    return OutlinedButton(
        onPressed: disable == true ? null : onPressed,
        style: OutlinedButton.styleFrom(
          elevation: 0,
          fixedSize: buttonSize ?? ButtonSizeLabel().size(size, context),
          backgroundColor: VCProductColors.instance.white,
          shape: RoundedRectangleBorder(
            borderRadius: context.lowBorderRadius,
          ),
          side: BorderSide(
              color: borderColor ?? VCProductColors.instance.green, width: 1),
        ),
        child: child ??
            VCProductComponents.text(
                fontSize: fontSize,
                textAlign: TextAlign.center,
                text: text!,
                textColor: disable == true
                    ? VCProductColors.instance.disabledGrey
                    : VCProductColors.instance.activeTileColor,
                typographyType: TypographyType.btnTab));
  }
}
