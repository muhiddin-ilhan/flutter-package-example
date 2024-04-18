import 'package:flutter/material.dart';
import 'package:vc_product_network/vc_product_network.dart';

import '../formatters/amount_input_formatter.dart';

class AmountEditingController extends TextEditingController {
  Currency? currency;
  AmountInputFormatter? formatter;

  AmountEditingController({this.currency, this.formatter, text}) : super(text: text);

  Amount getAmount({Currency? currency}) {
    AmountInputFormatter formatter = this.formatter ?? AmountInputFormatter();
    return Amount(value: formatter.unFormat(text), currency: currency ?? this.currency);
  }
}