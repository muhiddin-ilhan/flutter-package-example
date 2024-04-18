// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

import '../text/typography_type.dart';
import '../vc_product_components.dart';

/// `VCProductSwitch` is a customizable switch widget with various properties like initial state, disabled state, ON/OFF text,
/// custom widget, callback function on state change, and color customization options.
/// It supports dynamic width calculation based on the length of ON and OFF text when onOffDisable is set to false.

class VCProductSwitch extends StatefulWidget {
  /// Initial state of the switch
  final bool isSelected;

  /// Whether the switch is interactable or not
  final bool disabled;

  /// Text for ON and OFF states
  final String onText;
  final String offText;

  /// Whether to disable the display of ON and OFF state texts
  final bool onOffDisable;

  /// Color to be used when the switch is in the selected (ON) state
  Color? selectedColor;

  /// Background color of the switch
  Color? backgroundColor;

  /// Color of the circle inside the switch
  Color? circleColor;

  /// Text associated with the switch
  String? text;

  /// Event that occurs when the switch is interacted with
  final ValueChanged<bool>? onChanged;

  /// Text color associated with the switch
  Color? textColor;

  /// Custom widget associated with the switch
  final Widget? widget;

  double disabledColorOpacity = 0.7;

  VCProductSwitch({
    Key? key,
    this.isSelected = false,
    this.disabled = false,
    this.text,
    this.onChanged,
    this.onOffDisable = true,
    this.onText = "ON",
    this.offText = "OFF",
    this.widget,
    this.textColor,
    this.selectedColor,
    this.backgroundColor,
    this.circleColor,
  }) : super(key: key);

  @override
  State<VCProductSwitch> createState() => _VCProductSwitchState();
}

class _VCProductSwitchState extends State<VCProductSwitch> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    widget.selectedColor =
        widget.selectedColor ?? VCProductColors.instance.activeTileColor;
    widget.backgroundColor =
        widget.backgroundColor ?? VCProductColors.instance.widgetBorderColor;
    widget.circleColor = widget.circleColor ?? VCProductColors.instance.white;

    /// Calculate the width dynamically based on the length of onText and offText
    var textLength = widget.onText.length > widget.offText.length
        ? widget.onText.length
        : widget.offText.length;
    var switchWidth = widget.onOffDisable ? 47.0 : 38.0 + textLength * 6;

    ///given according to figma design

    return GestureDetector(
        onTap: () {
          if (!widget.disabled) {
            setState(() {
              _isSelected = !_isSelected;
              widget.onChanged?.call(_isSelected);
            });
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: switchWidth,
              height: 26.0,

              ///given according to figma design
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: widget.disabled
                    ? _isSelected
                        ? widget.selectedColor!
                            .withOpacity(widget.disabledColorOpacity)
                        : widget.backgroundColor!
                            .withOpacity(widget.disabledColorOpacity)
                    : _isSelected
                        ? widget.selectedColor
                        : widget.backgroundColor,
              ),
              child: Row(
                mainAxisAlignment: !widget.onOffDisable
                    ? MainAxisAlignment.spaceBetween
                    : _isSelected
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                children: [
                  if (!widget.onOffDisable && !_isSelected)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),

                        ///given according to figma design
                        child: Text(
                          widget.offText,
                          style: TextStyle(
                            fontSize: 10,
                            color: widget.selectedColor,
                          ),
                        ),
                      ),
                    ),
                  Container(
                    width: 22.0,

                    ///given according to figma design
                    height: 22.0,

                    ///given according to figma design
                    margin: const EdgeInsets.fromLTRB(3.0, 2.0, 3.0, 2.0),

                    ///given according to figma design
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.circleColor,
                    ),
                  ),
                  if (!widget.onOffDisable && _isSelected)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0),

                        ///given according to figma design
                        child: Text(
                          widget.onText,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            color: widget.backgroundColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            _getCustomWidget(),
          ],
        ));
  }

  Widget _getCustomWidget() {
    if (widget.widget == null && widget.text == null) {
      return const SizedBox.shrink();
    }

    /// Determine the text color based on the checkbox state and disabled status
    final Color textColor = widget.disabled
        ? (widget.textColor ?? VCProductColors.instance.black)
            .withOpacity(widget.disabledColorOpacity)
        : (widget.textColor ?? VCProductColors.instance.black);
    return Expanded(
      child: widget.widget ??
          Padding(
            padding:
                EdgeInsets.fromLTRB(widget.text != null ? 8.0 : 0, 0, 0, 0),

            ///given according to figma design
            child: VCProductComponents.text(
              text: widget.text ?? "",
              textColor: textColor,
              typographyType: TypographyType.label,
              textAlign: TextAlign.start,
            ),
          ),
    );
  }
}
