// ignore_for_file: must_be_immutable, overridden_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/utils/vc_icons.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class VCPasswordTextField extends VCBaseTextField {
  bool showSecurityPointText;
  bool allowSpace;

  @override
  bool isSecure = true;
  Color? iconColor;
  bool? showViewIcon;
  bool? showDeleteIcon;
  String? weakStatusText;
  String? mediumStatusText;
  String? strongStatusText;
  Function(String value)? onChangedPassword;

  VCPasswordTextField({
    Key? key,
    label,
    helperText,
    errorText,
    hintText,
    obscureText = false,
    maxLength = 500,
    hint,
    inputType,
    initValue,
    suffixIcon,
    prefix,
    textAlign,
    controller,
    validator,
    this.onChangedPassword,
    onSaved,
    deletable = false,
    enabled = true,
    counterEnabled = false,
    autoFocus = false,
    inputFormatters,
    hasBorderBottom = true,
    hasBorderTop = true,
    lowValidationViewEnabled = false,
    Color? backgroundColor,
    double? backgroundOpacity,
    Color? borderColor,
    Color? inputColor,
    String? id,
    bool showError = true,
    this.allowSpace = false,
    this.showSecurityPointText = false,
    this.isSecure = true,
    this.iconColor,
    this.showViewIcon = true,
    this.showDeleteIcon = false,
    this.weakStatusText,
    this.mediumStatusText,
    this.strongStatusText,
    super.onChanged,
  }) : super(
            key: key,
            label: label,
            helperText: helperText,
            errorText: errorText,
            hintText: hintText,
            obscureText: obscureText,
            maxLength: maxLength,
            hint: hint,
            inputType: inputType,
            initValue: initValue,
            suffixIcon: suffixIcon,
            prefix: prefix,
            textAlign: textAlign,
            controller: controller,
            validator: validator,
            onSaved: onSaved,
            isSecure: isSecure,
            deletable: deletable,
            enabled: enabled,
            counterEnabled: counterEnabled,
            autoFocus: autoFocus,
            inputFormatters: inputFormatters,
            backgroundColor: backgroundColor,
            backgroundOpacity: backgroundOpacity,
            hasBorderBottom: hasBorderBottom,
            hasBorderTop: hasBorderTop,
            borderColor: borderColor,
            id: id,
            showError: showError,
            loginValidationViewEnabled: lowValidationViewEnabled,
            inputColor: inputColor);

  @override
  State<VCPasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState
    extends VCBaseTextFieldState<VCPasswordTextField> {
  late bool _passwordVisibility;
  int point = -1;

  @override
  void initState() {
    _passwordVisibility = false;
    super.initState();

    if (widget.showSecurityPointText == true) {
      super.widget.onChanged = (String value) {
        setState(() {
          point = calculatePasswordSecurityPoint(value);

          if (point == 0 || point == 1) {
            super.widget.suffix = _getStatusWidget(
                context: context,
                statusColor: VCProductColors.instance.statusWeakColor,
                statusText: widget.weakStatusText ?? "WEAK",
                textColor: VCProductColors.instance.white);
            //"passwordStrengthEnum.Weak".tr(context);
          } else if (point == 2 || point == 3) {
            super.widget.suffix = _getStatusWidget(
                context: context,
                statusColor: VCProductColors.instance.statusWarningColor,
                statusText: widget.mediumStatusText ?? "MEDIUM");
            //"passwordStrengthEnum.Medium".tr(context);
          } else if (point == 4 || point == 5) {
            super.widget.suffix = _getStatusWidget(
                context: context,
                statusColor: VCProductColors.instance.statusActiveColor,
                statusText: widget.strongStatusText ?? "STRONG");
            //"passwordStrengthEnum.Strong".tr(context);
          }
          super.widget.bottomWidget =
              Positioned(bottom: -1, child: _getBottomWidget(context));
        });

        if (widget.onChangedPassword != null) {
          widget.onChangedPassword!.call(value);
        }
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    super.widget.obscureText = !_passwordVisibility;
    super.widget.isSecure = widget.isSecure;
    if (widget.showViewIcon == true) {
      super.widget.suffixIcon = getPasswordSecureSuffixIcon();
    }

    return super.build(context);
  }

  Widget getPasswordSecureSuffixIcon() {
    return widget.isSecure
        ? IconButton(
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            padding: EdgeInsets.zero,
            icon: _passwordVisibility
                ? Icon(
                    CupertinoIcons.eye_fill,
                    color: widget.iconColor,
                  )
                : Icon(
                    CupertinoIcons.eye_slash_fill,
                    color: widget.iconColor,
                  ),
            onPressed: () {
              setState(() {
                _passwordVisibility = !_passwordVisibility;
              });
            },
          )
        : const SizedBox.shrink();
  }

  Widget getPasswordDeleteIcon() {
    return InkWell(
      onTap: () {
        super.widget.controller?.text = "";
      },
      child: SizedBox(
        width: 24,
        height: 24,
        child: VCIcons.deleteCrossCircular,
      ),
    );
  }

  int calculatePasswordSecurityPoint(String data) {
    int point = 0;

    if (data.isNotEmpty) {
      bool hasLower = caseControl(data, false);
      bool hasUpper = caseControl(data, true);

      if (!data.contains(" ") && data.length >= 6) {
        point = point + 1;

        if (data.length > 12) {
          point = point + 1;
        }
      }
      if (hasLower && hasUpper) {
        point = point + 1;
      }
      if (hasNumber(data)) {
        point = point + 1;
      }
      if (hasSpecialCharacter(data)) {
        point = point + 1;
      }
    }
    return point;
  }

  bool caseControl(String data, bool isUpper) {
    String character;
    bool result = false;

    for (int i = 0; i < data.length; i++) {
      character = data[i];
      if (!isNumber(character) && !hasSpecialCharacter(character)) {
        if (isUpper) {
          if (character == character.toUpperCase()) {
            result = true;
            break;
          }
        } else {
          if (character == character.toLowerCase()) {
            result = true;
            break;
          }
        }
      }
    }
    return result;
  }

  bool hasNumber(String data) {
    String character;
    bool result = false;

    for (int i = 0; i < data.length; i++) {
      character = data[i];
      if (isNumber(character)) {
        result = true;
        break;
      }
    }
    return result;
  }

  bool isNumber(String data) {
    try {
      int.parse(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool hasSpecialCharacter(String data) {
    RegExp regex = RegExp(r"^[A-Za-z0-9 ]+$");
    bool result = !regex.hasMatch(data);
    return result;
  }

  Widget _getStatusWidget(
      {required BuildContext context,
      required Color? statusColor,
      required String statusText,
      Color? textColor}) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: context.spacing4, horizontal: context.spacing8),
      decoration: BoxDecoration(
        borderRadius: context.radiusSmall,
        color: statusColor,
      ),
      child: Text(
        statusText,
        style: TextStyle(
            color: textColor, fontWeight: FontWeight.normal, fontSize: 12),
      ),
    );
  }

  Widget _getBottomWidget(BuildContext context) {
    var radius = Radius.circular(context.spacing8);
    var width = MediaQuery.of(context).size.width * 0.275;
    var weakStatus = Container(
      height: 4,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: radius, bottomLeft: radius),
        color: VCProductColors.instance.red2,
      ),
    );
    var mediumStatus = Container(
      height: 4,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      color: VCProductColors.instance.yellow3,
    );
    var strongStatus = Container(
        height: 4,
        width: width,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.only(topRight: radius, bottomRight: radius),
          color: VCProductColors.instance.green,
        ));

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (point >= 0) weakStatus,
          if (point >= 2) mediumStatus,
          if (point >= 4) strongStatus,
        ],
      ),
    );
  }
}
