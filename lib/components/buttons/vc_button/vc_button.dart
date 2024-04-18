import 'package:flutter/material.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/components/base/base_component.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

enum VCButtonSize { large, medium, small, custom }

enum VCButtonType { primary, secondary, stroke, ghost }

class VCButton extends BaseComponent {
  final bool disabled;
  final Function() onTap;

  final Color? backgroundColor;
  final Color? disableBackgroundColor;
  final Color? foregroundColor;
  final Color? disabledForegroundColor;
  final Color? highlightForegroundColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final Color? splashColor;

  final double elevation;
  final bool clickElevationEnabled;
  final BorderRadius borderRadius;
  final BorderSide? borderSide;
  final BorderSide? disableBorderSide;

  final VCButtonSize buttonSize;
  final VCButtonType buttonType;

  final double? width;
  final double? height;
  final EdgeInsets padding;

  final Widget child;

  final Widget? prefixWidget;
  final Widget? suffixWidget;

  const VCButton({
    super.key,
    super.showError = false,
    this.disabled = false,
    required this.onTap,
    required this.child,
    this.backgroundColor,
    this.disableBackgroundColor,
    this.foregroundColor,
    this.disabledForegroundColor,
    this.highlightForegroundColor,
    this.buttonSize = VCButtonSize.medium,
    this.buttonType = VCButtonType.primary,
    this.height,
    this.width = double.infinity,
    this.padding = EdgeInsets.zero,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.elevation = 0,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.borderSide,
    this.disableBorderSide,
    this.clickElevationEnabled = false,
    this.prefixWidget,
    this.suffixWidget,
  });

  @override
  State<VCButton> createState() => _VCButtonState();
}

class _VCButtonState extends State<VCButton> {
  bool _isHighlightButton = false;
  bool _hasAnyError = false;

  @override
  Widget build(BuildContext context) {
    return ValidatorBuilder(builder: (_) {
      if (widget.showError) {
        _hasAnyError = ValidatorService.hasAnyError();
      }
      return SizedBox(
        height: getHeight,
        child: MaterialButton(
          onPressed: widget.disabled
              ? null
              : _hasAnyError
                  ? null
                  : widget.onTap,
          color: getColor,
          disabledColor: getDisabledColor,
          textColor: _isHighlightButton
              ? widget.highlightForegroundColor
              : getForegroundColor,
          disabledTextColor: getForegroundColor,
          onHighlightChanged: (value) {
            setState(() {
              _isHighlightButton = value;
            });
          },
          focusColor: widget.focusColor,
          hoverColor: widget.hoverColor,
          splashColor: getSplashColor,
          highlightColor: getHighlightColor,
          elevation: widget.elevation,
          focusElevation: widget.clickElevationEnabled ? null : 0,
          highlightElevation: widget.clickElevationEnabled ? null : 0,
          hoverElevation: widget.clickElevationEnabled ? null : 0,
          shape: RoundedRectangleBorder(
            borderRadius: widget.borderRadius,
            side: getBorderSide,
          ),
          height: getHeight,
          minWidth: widget.width,
          child: SizedBox(
            height: getHeight,
            child: Padding(
              padding: widget.padding,
              child: childContainer(
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget childContainer(Widget child) {
    if (widget.prefixWidget != null || widget.suffixWidget != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.prefixWidget ?? const SizedBox(),
          child,
          widget.suffixWidget ?? const SizedBox(),
        ],
      );
    }

    return child;
  }

  double get getHeight {
    switch (widget.buttonSize) {
      // TODO
      case VCButtonSize.small:
        return 34;
      case VCButtonSize.medium:
        return 52;
      case VCButtonSize.large:
        return 60;
      case VCButtonSize.custom:
        return widget.height ?? 48;
    }
  }

  Color get getColor {
    switch (widget.buttonType) {
      case VCButtonType.primary:
        return widget.backgroundColor ?? VCProductColors.instance.navyBlue;
      case VCButtonType.secondary:
        return widget.backgroundColor ??
            VCProductColors.instance.bottomSheetBGColor;
      case VCButtonType.stroke:
        return widget.backgroundColor ?? Colors.transparent;
      case VCButtonType.ghost:
        return widget.backgroundColor ?? Colors.transparent;
    }
  }

  Color get getDisabledColor {
    switch (widget.buttonType) {
      case VCButtonType.primary:
        return widget.disableBackgroundColor ??
            VCProductColors.instance.widgetBorderColor;
      case VCButtonType.secondary:
        return widget.disableBackgroundColor ??
            VCProductColors.instance.widgetBorderColor;
      case VCButtonType.stroke:
        return widget.disableBackgroundColor ?? Colors.transparent;
      case VCButtonType.ghost:
        return widget.disableBackgroundColor ?? Colors.transparent;
    }
  }

  Color get getForegroundColor {
    switch (widget.buttonType) {
      case VCButtonType.primary:
        if (widget.disabled) {
          return widget.disabledForegroundColor ??
              const Color.fromARGB(166, 100, 116, 139);
        } else {
          return widget.foregroundColor ?? VCProductColors.instance.white;
        }
      case VCButtonType.secondary:
        if (widget.disabled) {
          return widget.disabledForegroundColor ??
              const Color.fromARGB(166, 100, 116, 139);
        } else {
          return widget.foregroundColor ?? VCProductColors.instance.black;
        }
      case VCButtonType.stroke:
        if (widget.disabled) {
          return widget.disabledForegroundColor ??
              const Color.fromARGB(166, 100, 116, 139);
        } else {
          return widget.foregroundColor ?? VCProductColors.instance.navyBlue;
        }
      case VCButtonType.ghost:
        if (widget.disabled) {
          return widget.disabledForegroundColor ??
              const Color.fromARGB(166, 100, 116, 139);
        } else {
          return widget.foregroundColor ?? VCProductColors.instance.navyBlue;
        }
    }
  }

  Color? get getSplashColor {
    switch (widget.buttonType) {
      case VCButtonType.primary:
        return widget.splashColor;
      case VCButtonType.secondary:
        return widget.splashColor;
      case VCButtonType.stroke:
        return widget.splashColor ?? VCProductColors.instance.navyBlue;
      case VCButtonType.ghost:
        return widget.splashColor ?? VCProductColors.instance.navyBlue;
    }
  }

  Color? get getHighlightColor {
    switch (widget.buttonType) {
      case VCButtonType.primary:
        return widget.splashColor;
      case VCButtonType.secondary:
        return widget.splashColor;
      case VCButtonType.stroke:
        return widget.splashColor ?? VCProductColors.instance.navyBlue;
      case VCButtonType.ghost:
        return widget.splashColor ?? VCProductColors.instance.navyBlue;
    }
  }

  BorderSide get getBorderSide {
    switch (widget.buttonType) {
      case VCButtonType.primary:
        if (widget.disabled) {
          return widget.disableBorderSide ??
              (widget.borderSide ?? BorderSide.none);
        } else {
          return widget.borderSide ?? BorderSide.none;
        }
      case VCButtonType.secondary:
        if (widget.disabled) {
          return widget.disableBorderSide ??
              (widget.borderSide ?? BorderSide.none);
        } else {
          return widget.borderSide ?? BorderSide.none;
        }
      case VCButtonType.stroke:
        if (widget.disabled) {
          return widget.disableBorderSide ??
              (widget.borderSide ??
                  const BorderSide(width: 2, color: Color(0xFFC9D9DD)));
        } else {
          return widget.borderSide ??
              BorderSide(
                  width: 2,
                  color: widget.foregroundColor ??
                      VCProductColors.instance.backgroundGradientStart);
        }
      case VCButtonType.ghost:
        if (widget.disabled) {
          return widget.disableBorderSide ??
              (widget.borderSide ?? BorderSide.none);
        } else {
          return widget.borderSide ?? BorderSide.none;
        }
    }
  }
}
