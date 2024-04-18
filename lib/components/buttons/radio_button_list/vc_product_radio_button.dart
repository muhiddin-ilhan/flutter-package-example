// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../../utils/color_constant.dart';

/// A custom radio button widget used within the VCProductWidgets library.
class VCProductRadioButton<T> extends StatelessWidget {
  /// Callback function called when the radio button is selected.
  final void Function()? onSelected;

  /// Flag indicating whether the radio button is currently selected.
  final bool isSelected;

  /// Flag indicating whether the radio button is disabled.
  final bool isDisable;

  /// Text style applied when the radio button is disabled.
  final TextStyle? disabledTextStyle;

  /// Text style applied to the radio button's label.
  final TextStyle? textStyle;

  /// Background color applied when the radio button is selected.
  final Color? selectedColor;

  /// Border color applied when the radio button is unselected.
  final Color? unselectedBorderColor;

  /// Size of the outline around the radio button.
  final double? radioButtonOutlineSize;

  /// Width of the outline around the radio button.
  final double? radioButtonOutlineWidth;

  /// Size of the inner inline part of the radio button.
  final double? radioButtonInlineSize;

  /// Opacity of the color when the radio button is disabled.
  final double disabledColorOpacity;

  final double? width;

  final EdgeInsets? radioButtonPadding;

  /// The value associated with the radio button.
  final T? value;

  final Decoration? radioButtonWidgetDecoration;
  final Widget Function(T)? radioButtonTextWidget;

  //final T? groupValue;

  VCProductRadioButton(
      {Key? key,
      required this.onSelected,
      this.value,
      required this.isSelected,
      required this.isDisable,
      this.textStyle,
      this.disabledTextStyle,
      this.selectedColor,
      this.unselectedBorderColor,
      this.radioButtonOutlineSize,
      this.radioButtonInlineSize,
      this.radioButtonOutlineWidth,
      this.width,
      this.radioButtonWidgetDecoration,
      this.radioButtonTextWidget,
      this.radioButtonPadding,
      this.disabledColorOpacity = 0.7})
      : super(key: key);

  bool get isEnabled => !isDisable;

  TextStyle defaultTextStyle = TextStyle(
    color: VCProductColors.instance.black,
    fontSize: 14,
  );
  TextStyle defaultDisableTextStyle = TextStyle(
    color: VCProductColors.instance.black.withOpacity(0.7),
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    return isDisable
        ? _radioButtonDesign()
        : InkWell(
            onTap: onSelected,
            child: _radioButtonDesign(),
          );
  }

  Widget _radioButtonDesign() {
    double outlineSize = radioButtonOutlineSize ?? 24;

    ///given according to figma design

    double outlineWidth = radioButtonOutlineWidth ?? 1;

    ///given according to figma design

    double inlineSize = radioButtonInlineSize ?? 12;

    ///given according to figma design

    Color borderColor = isSelected
        ? selectedColor ?? VCProductColors.instance.activeTileColor
        : VCProductColors.instance.labelColor;

    ///given according to figma design

    Color circleInlineColor =
        selectedColor ?? VCProductColors.instance.activeTileColor;

    ///given according to figma design

    return Container(
      width: width,
      padding: radioButtonPadding ?? const EdgeInsets.symmetric(vertical: 5),
      decoration: radioButtonWidgetDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: outlineSize,
              width: outlineSize,
              padding: const EdgeInsets.all(6),

              ///given according to figma design
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(outlineSize),
                border: Border.all(
                  width: outlineWidth,
                  color: isEnabled
                      ? borderColor
                      : borderColor.withOpacity(disabledColorOpacity),
                ),
              ),

              ///given according to figma design
              child: isSelected
                  ? Container(
                      height: inlineSize,
                      width: inlineSize,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(inlineSize)),
                        color: isEnabled
                            ? circleInlineColor
                            : circleInlineColor
                                .withOpacity(disabledColorOpacity),
                      ),
                    )
                  : null),
          value != null
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),

                    ///given according to figma,
                    child: radioButtonTextWidget != null
                        ? radioButtonTextWidget!(value!)
                        : Text(value.toString(),
                            style: isEnabled
                                ? textStyle ?? defaultTextStyle
                                : disabledTextStyle ?? defaultDisableTextStyle),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
