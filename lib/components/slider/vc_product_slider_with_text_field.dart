import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/slider/vc_product_slider.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

import '../inputs/controller/amount_editing_controller.dart';

class VCProductSliderWithTextField extends StatefulWidget {
  final String title;
  final double? value;
  final double min;
  final double max;
  final int? divisions;
  final String? suffix;
  final String? prefix;
  final String textFiledLabel;
  final Function(double) onChanged;

  const VCProductSliderWithTextField({
    Key? key,
    required this.min,
    required this.max,
    this.value,
    this.divisions,
    required this.onChanged,
    this.prefix,
    this.suffix,
    required this.textFiledLabel,
    required this.title,
  }) : super(key: key);

  @override
  VCProductSliderWithTextFieldState createState() =>
      VCProductSliderWithTextFieldState();
}

class VCProductSliderWithTextFieldState
    extends State<VCProductSliderWithTextField> {
  late AmountEditingController _textEditingController;
  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.value ?? widget.min;
    _textEditingController =
        AmountEditingController(text: widget.value.toString());
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: VCProductColors.instance.white,
        borderRadius: context.defaultBorderRadius,
        border: Border.all(
          color: VCProductColors.instance.widgetBorderColor,
          width: 1,
        ),
      ),
      child: Padding(
        padding: context.paddingNormal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getTitle(),
            context.emptySizedHeightBoxNormal,
            _getSlider(),
            _getAmountTextField(),
          ],
        ),
      ),
    );
  }

  Widget _getTitle() {
    return VCProductText(
      textAlign: TextAlign.start,
      text: widget.title,
      type: TypographyType.bodyMedium14,
      textColor: VCProductColors.instance.black,
    );
  }

  Widget _getSlider() {
    return VCProductSlider(
      value: _sliderValue,
      min: widget.min,
      max: widget.max,
      onChanged: (newValue) {
        setState(() {
          _sliderValue = newValue;
          _textEditingController.text = newValue.toString();
        });
        widget.onChanged(newValue);
      },
      divisions: widget.divisions,
      suffix: widget.suffix,
    );
  }

  Widget _getAmountTextField() {
    return VCAmountBoxField(
      label: widget.textFiledLabel,
      amountController: _textEditingController,
      onChangedAmount: (newValue) {
        setState(() {
          double parsedValue = newValue.value?.toDouble() ?? widget.min;
          if (parsedValue < widget.min) {
            parsedValue = widget.min;
          } else if (parsedValue > widget.max) {
            parsedValue = widget.max;
          }
          _sliderValue = parsedValue;
          widget.onChanged(parsedValue);
        });
      },
    );
  }
}
