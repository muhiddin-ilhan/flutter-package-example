import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vc_product_network/vc_product_network.dart';

/// Flutter plugin for currency text input formatter.
class AmountInputFormatter extends TextInputFormatter {
  /// Builds an AmountInputFormatter with the following parameters.
  ///
  /// [decimal] argument is used to decimalDigits of NumberFormat currency.
  ///
  /// [customPattern] argument is used to locale of NumberFormat currency.
  ///
  /// [turnOffGrouping] argument is used to locale of NumberFormat currency.
  ///
  /// [enableNegative] argument is used to enable negative value.
  ///
  /// [minAmount] argument is used to set min value.
  ///
  /// [maxAmount] argument is used to set max value.
  ///
  /// [maxLength] argument is used to set max length.
  ///
  /// [onChange] argument is used to set callback when value is changed.
  ///
  /// [currency] argument is used to set currency symbol.
  AmountInputFormatter(
      {this.decimal,
      this.customPattern,
      this.turnOffGrouping = false,
      this.enableNegative = true,
      this.minAmount,
      this.maxAmount,
      this.onChange,
      this.currency,
      this.maxLength = 21}) {
    _format = NumberFormat.currency(
      symbol: currency?.symbol,
      decimalDigits: decimal,
      customPattern: customPattern,
    );
    if (turnOffGrouping) {
      _format.turnOffGrouping();
    }
  }

  /// Defaults `decimalDigits` is null.
  final int? decimal;

  /// Defaults `customPattern` is null.
  ///
  /// Can be used to specify a particular format.
  /// This is useful if you have your own locale data which includes unsupported formats
  /// (e.g. accounting format for currencies.)
  final String? customPattern;

  /// Defaults `turnOffGrouping` is false.
  ///
  /// Explicitly turn off any grouping (e.g. by thousands) in this format.
  /// This is used in compact number formatting, where we omit the normal grouping.
  /// Best to know what you're doing if you call it.
  final bool turnOffGrouping;

  /// Defaults `enableNegative` is true.
  ///
  /// Set to false if you want to disable negative numbers.
  final bool enableNegative;

  /// Defaults `minAmount` is null.
  final num? minAmount;

  /// Defaults `maxAmount` is null.
  final num? maxAmount;

  /// Defaults `maxLength` is 21.
  final num? maxLength;

  /// Defaults `currency` is null.
  final Currency? currency;

  /// Callback when value is changed.
  /// You can use this to listen to value changes.
  /// e.g. onChange: (value) => print(value);
  final Function(String)? onChange;

  late NumberFormat _format;
  num _newNum = 0;
  String _newString = '';
  bool _isNegative = false;

  void _formatter(String newText, int decimal) {
    _format = NumberFormat.currency(
      symbol: currency?.symbol,
      decimalDigits: decimal,
      customPattern: customPattern,
    );
    _newNum = num.tryParse(newText) ?? 0;
    if (_format.decimalDigits! > 0) {
      // _newNum /= pow(10, _format.decimalDigits!);
    }
    _newString = (_isNegative ? '-' : '') + _format.format(_newNum).trim();
  }

  bool _isLessThanMinValue() {
    if (minAmount == null) {
      return false;
    }
    return _newNum < minAmount!;
  }

  bool _isMoreThanMaxValue() {
    if (maxAmount == null) {
      return false;
    }
    return _newNum > maxAmount!;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    int dotIndexOld = oldValue.text.indexOf('.');
    String afterDotOld =
        dotIndexOld != -1 ? oldValue.text.substring(dotIndexOld + 1) : "";
    int dotIndexNew = newValue.text.indexOf('.');
    String afterDotNew =
        dotIndexNew != -1 ? newValue.text.substring(dotIndexNew + 1) : "";

    final bool isRemovedCharacter =
        oldValue.text.length - 1 == newValue.text.length &&
            oldValue.text.startsWith(newValue.text);

    final bool isFirstCharacter =
        !isRemovedCharacter && newValue.text.length == 1;

    if (afterDotOld.length == decimal && !isRemovedCharacter) {
      return oldValue;
    }

    if (enableNegative) {
      _isNegative = newValue.text.startsWith('-');
    } else {
      _isNegative = false;
    }

    String newText = newValue.text.replaceAll(
        (afterDotNew.isEmpty && isRemovedCharacter) ? RegExp('[^0-9]') : RegExp('[^0-9.]'), '');


    if (newText.replaceAll(".", "").length > (maxLength ?? double.infinity)) {
      return oldValue;
    }

    if (_lastCharacterIsDot(newText)) {
      return TextEditingValue(
        text: _newString + ".",
        selection: TextSelection.collapsed(offset: _newString.length),
      );
    }
    _formatter(newText, afterDotNew.length);


    if (_isLessThanMinValue() || _isMoreThanMaxValue()) {
      return oldValue;
    }

    if (newText.trim() == '' || newText == '00' || newText == '000') {
      return TextEditingValue(
        text: _isNegative ? '-' : '',
        selection: TextSelection.collapsed(offset: _isNegative ? 1 : 0),
      );
    }

    /// Call onChange callback
    if (onChange != null) {
      onChange!(_newString);
    }

    return TextEditingValue(
      text: _newString,
      selection: TextSelection.collapsed(offset: _newString.length),
    );

  }

  static bool _lastCharacterIsDigit(String text) {
    final String lastChar = text.substring(text.length - 1);
    return RegExp('[0-9]').hasMatch(lastChar);
  }

  static bool _lastCharacterIsDot(String text) {
    if(text.isNotEmpty){
      final String lastChar = text.substring(text.length - 1);
      return text.endsWith(".");
    }
   return false;
  }

  /// Get String type value with format such as `$ 2,000.00`
  String getFormattedValue() {
    return _newString;
  }

  /// Get num type value without format such as `2000.00`
  num getUnformattedValue() {
    return _isNegative ? (_newNum * -1) : _newNum;
  }

  bool isZero(String value) {
    try{
      double parsedDouble = double.parse(value.replaceAll(
          RegExp('[^0-9.]'), ''));
      return parsedDouble!=0;
    }catch(e){
      return true;
    }
  }

  double? unFormat(String value){
    try{
      final String newText = value.replaceAll(RegExp('[^0-9.]'), '');
      return double.parse(newText);
    } catch(e){
      return null;
    }
  }

  /// Method for formatting value.
  /// You can use initialValue with this method.
  String format(String value, int decimal) {
    if (enableNegative) {
      _isNegative = value.startsWith('-');
    } else {
      _isNegative = false;
    }

    final String newText = value.replaceAll(RegExp('[^0-9.]'), '');
    _formatter(newText, decimal);
    return _newString;
  }

  /// Method for formatting value.
  /// You can use initialValue(double) with this method.
  String formatDouble(double value) {
    if (enableNegative) {
      _isNegative = value.isNegative;
    } else {
      _isNegative = false;
    }

    final String newText =
        value.toStringAsFixed(decimal ?? 0).replaceAll(RegExp('[^0-9]'), '');
    _formatter(newText, decimal ?? 0);
    return _newString;
  }
}