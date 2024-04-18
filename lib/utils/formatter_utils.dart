import 'package:flutter/foundation.dart';


final RegExp _digitRegExp = RegExp(r'[-0-9]+');
final RegExp _positiveDigitRegExp = RegExp(r'[0-9]+');
final RegExp _digitWithPeriodRegExp = RegExp(r'[-0-9]+(\.[0-9]+)?');
final RegExp _oneDashRegExp = RegExp(r'[-]{2,}');
final RegExp _startPlusRegExp = RegExp(r'^\+{1}[)(\d]+');
final RegExp _maskContentsRegExp = RegExp(r'^[-0-9)( +]{3,}$');
final RegExp _isMaskSymbolRegExp = RegExp(r'^[-\+ )(]+$');
// final RegExp _repeatingDotsRegExp = RegExp(r'\.{2,}');
final _spaceRegex = RegExp(r'[\s]+');

/// [errorText] if you don't want this method to throw any
/// errors, pass null here
/// [allowAllZeroes] might be useful e.g. for phone masks
String toNumericString(
    String? inputString, {
      bool allowPeriod = false,
      bool allowHyphen = true,
      String mantissaSeparator = '.',
      String? errorText,
      bool allowAllZeroes = false,
      int? mantissaLength,
    }) {
  if (inputString == null) {
    return '';
  } else if (inputString == '+') {
    return inputString;
  }
  if (mantissaLength != null) {
    if (mantissaLength < 1) {
      inputString = inputString.replaceAll('.', '');
    }
  }
  if (mantissaSeparator == '.') {
    inputString = inputString.replaceAll(',', '');
  } else if (mantissaSeparator == ',') {
    final fractionSep = _detectFractionSeparator(inputString);
    if (fractionSep != null) {
      inputString = inputString.replaceAll(fractionSep, '%FRAC%');
    }
    inputString = inputString.replaceAll('.', '').replaceAll('%FRAC%', '.');
  }
  var startsWithPeriod = numericStringStartsWithOrphanPeriod(
    inputString,
  );

  var regexWithoutPeriod = allowHyphen ? _digitRegExp : _positiveDigitRegExp;
  var regExp = allowPeriod ? _digitWithPeriodRegExp : regexWithoutPeriod;
  var result = inputString.splitMapJoin(
    regExp,
    onMatch: (m) => m.group(0)!,
    onNonMatch: (nm) => '',
  );
  if (startsWithPeriod && allowPeriod) {
    result = '0.$result';
  }
  if (result.isEmpty) {
    return result;
  }
  try {
    result = _toDoubleString(
      result,
      allowPeriod: allowPeriod,
      errorText: errorText,
      allowAllZeroes: allowAllZeroes,
    );
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  return result;
}

String toNumericStringByRegex(
    String? inputString, {
      bool allowPeriod = false,
      bool allowHyphen = true,
    }) {
  if (inputString == null) return '';
  var regexWithoutPeriod = allowHyphen ? _digitRegExp : _positiveDigitRegExp;
  var regExp = allowPeriod ? _digitWithPeriodRegExp : regexWithoutPeriod;
  return inputString.splitMapJoin(
    regExp,
    onMatch: (m) => m.group(0)!,
    onNonMatch: (nm) => '',
  );
}

String _toDoubleString(
    String input, {
      bool allowPeriod = true,
      String? errorText = 'Invalid number',
      bool allowAllZeroes = false,
    }) {
  const period = '.';
  const zero = '0';
  const dash = '-';
  // final allowedSymbols = ['-', period];
  final temp = <String>[];
  if (input.startsWith(period)) {
    if (allowPeriod) {
      temp.add(zero);
    } else {
      return zero;
    }
  }
  bool periodUsed = false;

  for (var i = 0; i < input.length; i++) {
    final char = input[i];
    if (!isDigit(char, positiveOnly: true)) {
      if (char == dash) {
        if (i > 0) {
          if (errorText != null) {
            throw errorText;
          } else {
            continue;
          }
        }
      } else if (char == period) {
        if (!allowPeriod) {
          break;
        } else if (periodUsed) {
          continue;
        }
        periodUsed = true;
      }
    }
    temp.add(char);
  }
  if (temp.contains(period)) {
    while (temp.isNotEmpty && temp[0] == zero) {
      temp.removeAt(0);
    }
    if (temp.isEmpty) {
      return zero;
    } else if (temp[0] == period) {
      temp.insert(0, zero);
    }
  } else {
    if (!allowAllZeroes) {
      while (temp.length > 1) {
        if (temp.first == zero) {
          temp.removeAt(0);
        } else {
          break;
        }
      }
    }
  }
  return temp.join();
}

bool numericStringStartsWithOrphanPeriod(String string) {
  var result = false;
  for (var i = 0; i < string.length; i++) {
    var char = string[i];
    if (isDigit(char)) {
      break;
    }
    if (char == '.' || char == ',') {
      result = true;
      break;
    }
  }
  return result;
}

void checkMask(String mask) {
  if (_oneDashRegExp.hasMatch(mask)) {
    throw ('A mask cannot contain more than one dash (-) symbols in a row');
  }
  if (!_startPlusRegExp.hasMatch(mask)) {
    throw ('A mask must start with a + sign followed by a digit of a rounded brace');
  }
  if (!_maskContentsRegExp.hasMatch(mask)) {
    throw ('A mask can only contain digits, a plus sign, spaces and dashes');
  }
}

final RegExp _possibleFractionRegExp = RegExp(r'[,.]');
String? _detectFractionSeparator(String value) {
  final index = value.lastIndexOf(_possibleFractionRegExp);
  if (index < 0) {
    return null;
  }
  final separator = value[index];
  int numOccurrences = 0;
  for (var i = 0; i < value.length; i++) {
    final char = value[i];
    if (char == separator) {
      numOccurrences++;
    }
  }
  if (numOccurrences == 1) {
    return separator;
  }
  return null;
}


bool isUnmaskableSymbol(String? symbol) {
  if (symbol == null || symbol.length > 1) {
    return false;
  }
  return _isMaskSymbolRegExp.hasMatch(symbol);
}

bool isDigit(
    String? character, {
      bool positiveOnly = false,
    }) {
  if (character == null || character.isEmpty || character.length > 1) {
    return false;
  }
  if (positiveOnly) {
    return _positiveDigitRegExp.stringMatch(character) != null;
  }
  return _digitRegExp.stringMatch(character) != null;
}

bool isAlphabetic(String character) {
  if (character.length != 1) {
    return false;
  }

  final RegExp regex = RegExp(r'[a-zA-Z]');
  return regex.hasMatch(character);
}

String toCurrencyString(
    String value, {
      int mantissaLength = 2,
      String leadingSymbol = '',
      String trailingSymbol = '',
      bool useSymbolPadding = false,
    }) {
  bool isNegative = false;
  if (value.startsWith('-')) {
    value = value.replaceAll(RegExp(r'^[-+]+'), '');
    isNegative = true;
  }
  value = value.replaceAll(_spaceRegex, '');
  if (value.isEmpty) {
    value = '0';
  }
  String mSeparator = ".";
  String tSeparator = ",";

  value = toNumericString(
    value,
    allowAllZeroes: true,
    allowHyphen: true,
    allowPeriod: true,
    mantissaSeparator: mSeparator,
    mantissaLength: mantissaLength,
  );
  String? fractionalSeparator = _detectFractionSeparator(value);
  // mantissaLength > 0 ? _detectFractionSeparator(value) : null;

  var sb = StringBuffer();
  bool addedMantissaSeparator = false;
  for (var i = 0; i < value.length; i++) {
    final char = value[i];
    if (char == '-') {
      if (i > 0) {
        continue;
      }
      sb.write(char);
    }
    if (isDigit(char, positiveOnly: true)) {
      sb.write(char);
    }
    if (char == fractionalSeparator) {
      if (!addedMantissaSeparator) {
        sb.write('.');
        addedMantissaSeparator = true;
      } else {
        continue;
      }
    }
  }

  final str = sb.toString();
  final evenPart =
  addedMantissaSeparator ? str.substring(0, str.indexOf('.')) : str;

  int skipEvenNumbers = 0;
  String shorteningName = '';
  bool ignoreMantissa = skipEvenNumbers > 0;

  final fractionalPart =
  addedMantissaSeparator ? str.substring(str.indexOf('.') + 1) : '';
  final reversed = evenPart.split('').reversed.toList();
  List<String> temp = [];
  bool skippedLast = false;
  for (var i = 0; i < reversed.length; i++) {
    final char = reversed[i];
    if (skipEvenNumbers > 0) {
      skipEvenNumbers--;
      skippedLast = true;
      continue;
    }
    if (i > 0) {
      if (i % 3 == 0) {
        if (!skippedLast) {
          temp.add(tSeparator);
        }
      }
    }
    skippedLast = false;
    temp.add(char);
  }
  value = temp.reversed.join('');
  sb = StringBuffer();
  for (var i = 0; i < mantissaLength; i++) {
    if (i < fractionalPart.length) {
      sb.write(fractionalPart[i]);
    } else {
      sb.write('0');
    }
  }

  final fraction = sb.toString();
  if (value.isEmpty) {
    value = '0';
  }
  if (ignoreMantissa) {
    value = '$value$shorteningName';
  } else {
    value = '$value$mSeparator$fraction';
  }

  // print(value);

  /// add leading and trailing
  sb = StringBuffer();
  for (var i = 0; i < value.length; i++) {
    if (i == 0) {
      if (leadingSymbol.isNotEmpty) {
        sb.write(leadingSymbol);
        if (useSymbolPadding) {
          sb.write(' ');
        }
      }
    }
    sb.write(value[i]);
    if (i == value.length - 1) {
      if (trailingSymbol.isNotEmpty) {
        if (useSymbolPadding) {
          sb.write(' ');
        }
        sb.write(trailingSymbol);
      }
    }
  }
  value = sb.toString();
  if (isNegative) {
    return '-$value';
  }
  return value;
}