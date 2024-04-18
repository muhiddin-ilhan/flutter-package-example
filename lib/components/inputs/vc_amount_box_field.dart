// ignore_for_file: must_be_immutable, annotate_overrides

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import '../buttons/selectable_button_list/controllers/selectable_button_controller.dart';
import '../buttons/selectable_button_list/vc_product_selectable_button_list.dart';
import '../numpad/vc_num_pad_sheet.dart';
import 'controller/amount_editing_controller.dart';
import 'formatters/amount_input_formatter.dart';
import 'vc_masked_text_field.dart';

class VCAmountBoxField extends VCMaskedTextField {
  /// The mask for formatting the input value.
  // ignore: overridden_fields
  final String? mask;

  /// The maximum allowed amount for input validation.
  final double? maxAmount;

  /// The minimum allowed amount for input validation.
  final double? minAmount;

  /// Flag to enable or disable maximum amount check.
  final bool maxCheck;

  /// Flag to enable or disable minimum amount check.
  final bool minCheck;

  /// The currency associated with the input value.
  final Currency? currency;

  /// The amounts list associated with the input value.
  final List<int>? buttons;

  /// SelectableButtonController.
  final SelectableButtonController? buttonController;

  /// A callback that is called when the input value changes.
  final Function(Amount)? onChangedAmount;

  final AmountEditingController? amountController;

  VCAmountBoxField(
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
       this.amountController,
      validator,
      onSaved,
      isSecure,
      deletable = false,
      enabled = true,
      counterEnabled = false,
      autoFocus = false,
      inputFormatters,
      maskedType,
      hasBorderBottom,
      hasBorderTop,
      readOnly = false,
      Function()? onTap,
      super.id,
      super.showError,
      this.mask,
      this.maxAmount,
      this.minAmount,
      this.maxCheck = false,
      this.minCheck = false,
      this.currency,
      this.buttons,
      this.buttonController,
      this.onChangedAmount})
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
            controller: amountController,
            validator: validator,
            onSaved: onSaved,
            isSecure: isSecure ?? false,
            deletable: deletable,
            enabled: enabled,
            counterEnabled: counterEnabled,
            autoFocus: autoFocus,
            readOnly: readOnly,
            hasBorderBottom: hasBorderBottom,
            hasBorderTop: hasBorderTop,
            inputFormatters: inputFormatters,
            onTap: onTap);

  @override
  State<VCAmountBoxField> createState() => _AmountBoxFieldState();
}

class _AmountBoxFieldState extends MaskedTextFieldState<VCAmountBoxField> {
  AmountEditingController _controller = AmountEditingController();

  @override
  void initState() {
    super.initState();
    _controller = widget.amountController ?? AmountEditingController();
  }

  @override
  Widget build(BuildContext context) {
    super.widget.inputColor = VCProductColors.instance.widgetTextColor;
    if (widget.onTap == null) {
      super.widget.onTap = () async {
        await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            useRootNavigator: true,
            barrierColor: Colors.transparent,
            builder: (context) => VCNumPadSheet(
                  controller: _controller,
                  currency: widget.currency,
                )).then((value) {
          super
              .widget
              .onChanged
              ?.call((widget.controller ?? TextEditingController()).text);
          if (widget.id != null && widget.willValidate) {
            ValidatorService.validate<String>(
                componentId: widget.id!,
                value: (widget.controller ?? TextEditingController()).text,
                showError: widget.showError,
                checkOthers: widget.checkOthers);
          }
          if(widget.onChangedAmount!=null){
            try{
              AmountInputFormatter formatter = (super.widget.inputFormatters?.first as AmountInputFormatter);
              Amount amount = Amount(value: formatter.unFormat(_controller.text),currency: widget.currency);
              widget.onChangedAmount?.call(amount);
            }
            catch(e){
              debugPrint(e.toString());
            }

          }
        });
      };
      widget.readOnly = true;
    }

    super.widget.textAlign = widget.textAlign ?? TextAlign.end;
    super.widget.inputFormatters = widget.inputFormatters ??
        [
          AmountInputFormatter(
              decimal: 2,
              currency: widget.currency,
              maxAmount: widget.maxCheck ? widget.maxAmount : null,
              minAmount: widget.minCheck ? widget.minAmount : null)
        ];
    super.widget.hint =
        widget.currency != null ? "${widget.currency?.symbol}0.00" : "0.00";

    if (widget.textAlign != TextAlign.center){
      super.widget.style = TextStyle(
        color: VCProductColors.instance.black,
        fontWeight: FontWeight.w600,
      );
    }
    else if (widget.textAlign == TextAlign.center) {
      super.widget.style ??= const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      );
    }
    if(widget.onChangedAmount!=null){
      super.widget.onChanged = (value) {
        AmountInputFormatter formatter = (super.widget.inputFormatters?.first as AmountInputFormatter);
        Amount amount = Amount(value: formatter.unFormat(value),currency: widget.currency);
        widget.onChangedAmount?.call(amount);
      };
    }
    return Column(
      children: [
        super.build(context),
        if (widget.buttons?.isNotEmpty == true) ...[
          VCProductSelectableButtonList(
            controller: widget.buttonController,
            buttons: widget.buttons!,
            textAlign: TextAlign.center,
            padding: const EdgeInsets.symmetric(vertical: 10),
            isRadio: true,
            onSelected: (value, index, selected) {
              debugPrint(value.toString());
              _setAmount(value);
            },
          )
        ]
      ],
    );
  }

  void _setAmount(int amount) {
    if (super.widget.controller != null) {
      final controller = super.widget.controller;
      controller?.text = super.widget.inputFormatters != null &&
              super.widget.inputFormatters!.isNotEmpty
          ? super
              .widget
              .inputFormatters!
              .first
              .formatEditUpdate(TextEditingValue(text: amount.toString()),
                  TextEditingValue(text: amount.toString()))
              .text
          : amount.toString();
    }
  }
}
