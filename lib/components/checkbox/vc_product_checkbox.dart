// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/components/base/base_component.dart';
import 'package:vc_product_widgets/components/error_text/error_text_widget.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import '../../utils/vc_icons.dart';

class VCProductCheckBox extends BaseComponent {
  VCProductCheckBox({
    Key? key,

    /// Text to be displayed next to the checkbox
    this.text = "",

    /// Callback function when the checkbox state changes
    this.onChanged,

    /// Flag to determine if the checkbox is disabled
    this.disabled = false,

    /// Flag to determine if the checkbox is checked
    this.isChecked = false,

    /// Radius of the checkbox border
    ///given according to figma design
    this.borderRadius = 4.0,

    /// Width of the checkbox
    ///given according to figma design
    this.width = 24.0,

    /// Height of the checkbox
    ///given according to figma design
    this.height = 24.0,

    /// Size of the check icon inside the checkbox
    this.iconSize,

    /// Color of the check icon
    this.checkColor,

    /// Color of the text
    this.textColor,

    /// Widget to replace the default check icon
    this.icon,

    /// Widget to replace the default text
    this.widget,

    this.expandableWidget,

    /// Margin around the check icon
    ///given according to figma design
    this.iconMargin = const EdgeInsets.all(5.0),
    this.isWidgetTapEnabled = true,
    super.id,
    super.showError,
    super.checkOthers,
    super.willValidate,
  }) : super(key: key);

  final double width;
  final double height;
  final double borderRadius;
  final double? iconSize;
  final Color? checkColor;
  final Color? textColor;
  final EdgeInsets iconMargin;
  final Widget? widget;
  final Widget? expandableWidget;
  final Widget? icon;
  final Function(bool?)? onChanged;
  final bool isWidgetTapEnabled;
  String text;
  bool disabled;
  bool isChecked;
  double disabledColorOpacity = 0.7;

  @override
  State<VCProductCheckBox> createState() => _VCProductCheckBoxState();
}

class _VCProductCheckBoxState extends State<VCProductCheckBox> {
  bool isChecked = false;
  String? validatorErrorText;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  /// Function to set the disabled state
  setDisabled(bool value) {
    setState(() {
      widget.disabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Determine the border color based on the checkbox state
    final Color borderColor = isChecked
        ? (widget.checkColor ?? VCProductColors.instance.activeTileColor)
        : VCProductColors.instance.strokeGray;

    /// Determine the text color based on the checkbox state and disabled status
    final Color textColor = widget.disabled
        ? (widget.textColor ?? VCProductColors.instance.black)
            .withOpacity(widget.disabledColorOpacity)
        : (widget.textColor ?? VCProductColors.instance.black);

    /// Determine the selected color based on the checkbox state and disabled status
    final Color checkedColor = isChecked
        ? (widget.checkColor ?? VCProductColors.instance.activeTileColor)
        : VCProductColors.instance.white;

    return ValidatorBuilder(builder: (_) {
      if (widget.id != null && widget.showError) {
        validatorErrorText = ValidatorService.getErrorMessage(widget.id!);
      }
      return Column(
        children: [
          GestureDetector(
            onTap: widget.isWidgetTapEnabled
                ? widget.disabled
                    ? null
                    : () {
                        setState(() => isChecked = !isChecked);
                        widget.onChanged?.call(isChecked);
                        if (widget.id != null && widget.willValidate) {
                          ValidatorService.validate(
                            componentId: widget.id!,
                            value: isChecked,
                            showError: widget.showError,
                            checkOthers: widget.checkOthers,
                          );
                        }
                      }
                : null,
            child: Row(
              children: [
                GestureDetector(
                  onTap: widget.disabled
                      ? null
                      : () {
                          setState(() => isChecked = !isChecked);
                          widget.onChanged?.call(isChecked);
                          if (widget.id != null && widget.willValidate) {
                            ValidatorService.validate(
                              componentId: widget.id!,
                              value: isChecked,
                              showError: widget.showError,
                              checkOthers: widget.checkOthers,
                            );
                          }
                        },
                  child: Container(
                    width: widget.width,
                    height: widget.height,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: validatorErrorText != null
                            ? VCProductColors.instance.errorWidgetColor
                            : widget.disabled
                                ? borderColor
                                    .withOpacity(widget.disabledColorOpacity)
                                : borderColor,
                      ),
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      color: widget.disabled
                          ? checkedColor
                              .withOpacity(widget.disabledColorOpacity)
                          : checkedColor,
                    ),
                    child: isChecked
                        ? Container(
                            margin: widget.iconMargin,
                            child: widget.icon ?? VCIcons.ic_check_white,
                          )
                        : null,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),

                    ///given according to figma design
                    child: widget.widget ??
                        Text(
                          widget.text,
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                  ),
                )
              ],
            ),
          ),
          if (validatorErrorText != null)
            ErrorTextWidget(errorText: validatorErrorText!),
            Padding(
            padding: context.onlyTopPaddingNormal,
            child: widget.expandableWidget ??  const SizedBox(),
          )
        ],
      );
    });
  }
}
