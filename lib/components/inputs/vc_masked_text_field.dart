// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/inputs/formatters/mobile_number_input_formatter.dart';
import 'package:vc_product_widgets/components/inputs/vc_base_text_field.dart';
import 'package:vc_product_widgets/components/inputs/formatters/amount_input_formatter.dart';
import 'package:vc_product_widgets/components/inputs/formatters/credit_card_cvv_input_formatter.dart';
import 'package:vc_product_widgets/components/inputs/formatters/credit_card_expiration_date_input_formatter.dart';
import 'package:vc_product_widgets/components/inputs/formatters/masked_input_formatter.dart';
import 'package:vc_product_widgets/components/inputs/input_type.dart';

import 'formatters/credit_card_number_input_formatter.dart';
import 'formatters/iban_mask_text_input_formatter.dart';

class VCMaskedTextField extends VCBaseTextField {
  InputType? maskedType;
  final String? mask;

  VCMaskedTextField(
      {Key? key,
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
      style,
      controller,
      validator,
      onChanged,
      onSaved,
      isSecure,
      deletable = false,
      enabled = true,
      counterEnabled = false,
      autoFocus = false,
      inputFormatters,
      hasBorderTop = true,
      hasBorderBottom = true,
      readOnly = false,
      Function()? onTap,
      super.id,
      super.showError,
      this.maskedType,
      super.showErrorMessage,
      super.errorColor,
      super.labelColor,
      super.inputColor,
      this.mask})
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
            style: style,
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            readOnly: readOnly,
            onSaved: onSaved,
            isSecure: isSecure ?? false,
            deletable: deletable,
            enabled: enabled,
            counterEnabled: counterEnabled,
            autoFocus: autoFocus,
            hasBorderBottom: hasBorderBottom ?? true,
            hasBorderTop: hasBorderTop ?? true,
            inputFormatters: inputFormatters,
            onTap: onTap);

  @override
  State<VCMaskedTextField> createState() => MaskedTextFieldState();
}

class MaskedTextFieldState<T extends VCMaskedTextField>
    extends VCBaseTextFieldState<T> {
  @override
  Widget build(BuildContext context) {
    switch (widget.maskedType) {
      case InputType.cardNumber:
        super.widget.inputFormatters = [CreditCardNumberInputFormatter()];
      case InputType.ibanNumber:
        super.widget.inputFormatters = [IbanMaskTextInputFormatter()];
      case InputType.expirationDate:
        super.widget.inputFormatters = [CreditCardExpirationDateFormatter()];
      case InputType.cvv:
        super.widget.inputFormatters = [CreditCardCvcInputFormatter()];
      case InputType.mobileNumber:
        super.widget.inputFormatters = [MobilePhoneMaskFormatter()];
      case InputType.amount:
        super.widget.inputFormatters = [AmountInputFormatter(decimal: 2)];
      default:
        super.widget.inputFormatters =
            widget.mask != null && super.widget.inputFormatters == null
                ? [MaskedInputFormatter(widget.mask!)]
                : super.widget.inputFormatters;
    }
    super.widget.label = widget.label ?? widget.maskedType?.title;
    super.widget.hintText = widget.hint ?? widget.maskedType?.hint;
    super.widget.maxLength =
        widget.maskedType?.maxLength ?? super.widget.maxLength;

    return super.build(context);
  }
}
