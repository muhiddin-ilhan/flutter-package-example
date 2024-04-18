// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/components/error_text/error_text_widget.dart';

import 'vc_base_text_field.dart';

class VCPinInputTextField extends VCBaseTextField {
  /// Represents the length of the PIN code. default [6]
  int pinLength;

  /// Controller for handling PIN code input.
  TextEditingController? pinController;

  VCPinInputTextField(
      {Key? key,
      this.pinLength = 6,
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
      this.pinController,
      validator,
      onChanged,
      onSaved,
      isSecure = true,
      deletable = false,
      enabled = true,
      counterEnabled = false,
      autoFocus = false,
      inputFormatters,
      super.id,
      super.showError,
      super.checkOthers,
      super.willValidate,
      Color? backgroundColor,
      double? backgroundOpacity,
      Color? borderColor,
      Color? inputColor})
      : super(
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
            validator: validator,
            onChanged: onChanged,
            onSaved: onSaved,
            isSecure: isSecure,
            deletable: deletable,
            enabled: enabled,
            counterEnabled: counterEnabled,
            autoFocus: autoFocus,
            inputFormatters: inputFormatters,
            backgroundColor: backgroundColor,
            backgroundOpacity: backgroundOpacity,
            borderColor: borderColor,
            inputColor: inputColor);

  @override
  State<VCPinInputTextField> createState() => _PinInputTextFieldState();
}

class _PinInputTextFieldState
    extends VCBaseTextFieldState<VCPinInputTextField> {
  List<TextEditingController> textEditingControllers = [];
  late List<String> pinValues = [];
  String _passText = "";
  String? validatorErrorText;

  @override
  void initState() {
    super.initState();
    // widget.pinController?.addListener(_pinChanged);

    pinValues = List<String>.filled(widget.pinLength, '');

    if ((widget.initValue ?? "").length == pinValues.length) {
      for (int i = 0; i < pinValues.length; i++) {
        pinValues[i] = widget.initValue![i];
      }
    }
  }

  void setMainTextEditingController() {
    _passText = "";
    for (int i = 0; i < widget.pinLength; i++) {
      _passText += pinValues[i];
    }

    setState(() {
      widget.pinController?.text = _passText;
    });
    widget.onChanged?.call(_passText);
    if (widget.id != null && widget.willValidate) {
      debugPrint(_passText);
      ValidatorService.validate(
        componentId: widget.id!,
        value: _passText.length < widget.pinLength ? "" : _passText,
        showError: widget.showError,
        checkOthers: widget.checkOthers,
      );
    }
  }

  /* void _pinChanged() {
    setState(() => {});
  }*/

  @override
  Widget build(BuildContext context) {
    super.widget.maxLength = 1;
    super.widget.inputType = TextInputType.number;
    return ValidatorBuilder(builder: (_) {
      if (widget.id != null && widget.showError) {
        validatorErrorText = ValidatorService.getErrorMessage(widget.id!);
      }
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              children: List<Widget>.generate(
                widget.pinLength,
                (i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: IntrinsicWidth(
                      stepWidth: 40,
                      child: VCBaseTextField(
                        willValidate: widget.willValidate,
                        showError: widget.showError,
                        key: widget.key,
                        label: widget.label,
                        helperText: widget.helperText,
                        errorText: validatorErrorText != null ? "" : null,
                        hintText: widget.hintText,
                        obscureText: true,
                        maxLength: widget.maxLength,
                        hint: widget.hint,
                        inputType: widget.inputType,
                        controller: widget.controller,
                        initValue:
                            (widget.initValue?.length ?? 0) < widget.pinLength
                                ? widget.initValue
                                : widget.initValue?[i],
                        suffixIcon: widget.suffixIcon,
                        prefix: widget.prefix,
                        textAlign: TextAlign.center,
                        validator: widget.validator,
                        onChanged: (value) {
                          if (value.length == 1 && i != widget.pinLength - 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (value.isEmpty && i != 0) {
                            FocusScope.of(context).previousFocus();
                          }
                          pinValues[i] = value;
                          setMainTextEditingController();
                        },
                        onSaved: widget.onSaved,
                        isSecure: widget.isSecure,
                        deletable: widget.deletable,
                        enabled: widget.enabled,
                        counterEnabled: widget.counterEnabled,
                        autoFocus: widget.autoFocus,
                        inputFormatters: widget.inputFormatters,
                        isDense: true,
                        fontSize: 20,
                        fontHeight: 1,
                        containerPadding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 3),
                        backgroundColor: widget.backgroundColor,
                        backgroundOpacity: widget.backgroundOpacity,
                        borderColor: widget.borderColor,
                        inputColor: widget.inputColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (validatorErrorText != null)
            ErrorTextWidget(errorText: validatorErrorText!),
        ],
      );
    });
  }
}
