// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';

import '../../../utils/color_constant.dart';

/// Custom selectable button widget used within the VCProductWidgets library.
class VCProductSelectableButton extends StatelessWidget {
  /// The text displayed on the button.
  final String text;

  /// Callback function invoked when the button is pressed.
  final void Function()? onPressed;

  /// Flag indicating whether the button is currently selected.
  final bool isSelected;

  /// Flag indicating whether the button is disabled.
  final bool isDisable;

  /// The text style applied when the button is selected.
  final TextStyle? selectedTextStyle;

  /// The text style applied when the button is unselected.
  final TextStyle? unselectedTextStyle;

  /// The background color applied when the button is selected.
  final Color? selectedColor;

  /// The background color applied when the button is unselected.
  final Color? unselectedColor;

  /// The border radius of the button.
  double borderRadius = 4;

  /// The height of the button.
  final double? height;

  /// The width of the button.
  final double? width;

  /// The fontSize of the button.
  final double? fontSize;

  /// The horizontal alignment of the button text.
  final TextAlign? textAlign;

  /// The alignment of the button within its parent widget.
  final AlignmentGeometry? alignment;

  /// The elevation of the button.
  final double? elevation;

  /// Opacity of the color when the button is disabled.
  final double disabledColorOpacity;

  /// Flag indicating whether the border of the button is visible.
  final bool isBorderVisible;

  /// The padding of the button within its parent widget.
  final EdgeInsetsGeometry? padding;

  final Widget? icon;

  VCProductSelectableButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.isSelected,
      required this.isDisable,
      this.selectedTextStyle,
      this.unselectedTextStyle,
      this.selectedColor,
      this.unselectedColor,
      this.borderRadius = 4,
      this.disabledColorOpacity = 0.7,
      this.height,
      this.width,
      this.textAlign,
      this.alignment,
      this.elevation,
      this.isBorderVisible = false,
      this.fontSize,
      this.padding,
      this.icon})
      : super(key: key);

  bool get isEnabled => !isDisable;

  late TextStyle defaultTextStyle;

  late TextStyle defaultSelectedTextStyle;

  @override
  Widget build(BuildContext context) {
    var defaultSelectedTextStyleColor =
        unselectedColor ?? VCProductColors.instance.white;
    defaultSelectedTextStyle = TextStyle(
      color: isEnabled
          ? defaultSelectedTextStyleColor
          : defaultSelectedTextStyleColor.withOpacity(disabledColorOpacity),
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w600,
    );

    var defaultTextStyleColor =
        selectedColor ?? VCProductColors.instance.activeTileColor;
    defaultTextStyle = TextStyle(
      color: isEnabled
          ? defaultTextStyleColor
          : defaultTextStyleColor.withOpacity(disabledColorOpacity),
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w600,
    );
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: !isDisable
          ? _customButton(context, onPressed)
          : GestureDetector(
              onTap: onPressed,
              child: _customButton(context, null),
            ),
    );
  }

  Widget _customButton(BuildContext context, void Function()? onPressed) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation ?? 0.0,
        // ignore: deprecated_member_use
        backgroundColor: _getBackgroundColor(theme),
        disabledBackgroundColor: _getBackgroundColor(theme),
        shape: _buildShape(),
        padding: padding ?? EdgeInsets.zero,
        alignment: (width != null || height != null) ? alignment : null,
      ),
      child: icon == null
          ? Text(
              text,
              textAlign: textAlign,
              style: isSelected
                  ? selectedTextStyle ?? defaultSelectedTextStyle
                  : unselectedTextStyle ?? defaultTextStyle,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon!,
                Text(
                  text,
                  textAlign: textAlign,
                  style: isSelected
                      ? selectedTextStyle ?? defaultSelectedTextStyle
                      : unselectedTextStyle ?? defaultTextStyle,
                ),
              ]
                  .map((Widget child) => Padding(
                        padding: context.onlyRightPaddingLow,
                        child: child,
                      ))
                  .toList(),
            ),
    );
  }

  Color? _getBackgroundColor(ThemeData theme) {
    final themePrimaryColor = VCProductColors.instance.activeTileColor;
    const themeSecondaryColor = Colors.white;

    var selectedColorBuffer = selectedColor;
    var unselectedColorBuffer = unselectedColor;

    selectedColorBuffer ??= themePrimaryColor;
    unselectedColorBuffer ??= themeSecondaryColor;

    final color = isSelected ? selectedColorBuffer : unselectedColorBuffer;
    return isEnabled ? color : color.withOpacity(disabledColorOpacity);
  }

  OutlinedBorder? _buildShape() {
    var borderColor = selectedColor ?? VCProductColors.instance.activeTileColor;
    borderColor =
        isEnabled ? borderColor : borderColor.withOpacity(disabledColorOpacity);

    return isBorderVisible
        ? RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          )
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          );
  }
}
