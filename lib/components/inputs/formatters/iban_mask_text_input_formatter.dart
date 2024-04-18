import 'package:flutter/services.dart';

import 'masked_input_formatter.dart';

class IbanMaskTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String newText =
        newValue.text.toUpperCase().replaceAll(RegExp(r'\s'), '');

    if (newText.length == 1) {
      ///First letter check
      if (!structures.keys.any((code) => code.startsWith(newText[0]))) {
        return oldValue;
      }
    } else if (newText.length == 2) {
      ///Second letter check
      final String firstLetter = newText[0];
      final String secondLetter = newText[1];
      if (!structures.keys.any(
          (code) => code.startsWith(firstLetter) && code[1] == secondLetter)) {
        return oldValue;
      }
    } else if (newText.length > 2) {
      ///mask generate from structure tokens
      String mask = getSplitTokensMask(newText.substring(0, 2));
      String maskedText = MaskedInputFormatter(mask).formatEditUpdate(oldValue, newValue).text;
      return TextEditingValue(text: maskedText, selection: TextSelection.fromPosition(TextPosition(offset: maskedText.length)));
    }
    return TextEditingValue(text: newText, selection: TextSelection.fromPosition(TextPosition(offset: newText.length)));
  }

  String getSplitTokensMask(String countryCode) {
    String mask = "AA";
    RegExp regex2 = RegExp(r'(\d+)!([nac])');
    Iterable<Match> matches = regex2.allMatches(structures[countryCode]!);

    for (Match match in matches) {
      int count = int.parse(match.group(1)!);
      String type = match.group(2)!;
      mask = addLettersToEnd(mask, count, tokenCodes[type]!);
    }

    return mask;
  }

  String addLettersToEnd(String input, int numberOfLetters, String letter) {
    for (int i = 0; i < numberOfLetters; i++) {
      input += letter;
    }
    return "$input ";
  }

  static final Map<String, String> structures = {
    'AL': 'AL2!n8!n16!c',
    'AD': 'AD2!n4!n4!n12!c',
    'AT': 'AT2!n5!n11!n',
    'BH': 'BH2!n4!a14!c',
    'BE': 'BE2!n3!n7!n2!n',
    'BA': 'BA2!n3!n3!n8!n2!n',
    'BG': 'BG2!n4!a4!n2!n8!c',
    'HR': 'HR2!n7!n10!n',
    'CY': 'CY2!n3!n5!n16!c',
    'CZ': 'CZ2!n4!n6!n10!n',
    'DK': 'DK2!n4!n9!n1!n FO2!n4!n9!n1!n GL2!n4!n9!n1!n',
    'DO': 'DO2!n4!c20!n',
    'EE': 'EE2!n2!n2!n11!n1!n',
    'FI': 'FI2!n6!n7!n1!n',
    'FR': 'FR2!n5!n5!n11!c2!n',
    'GE': 'GE2!n2!a16!n',
    'DE': 'DE2!n8!n10!n',
    'GI': 'GI2!n4!a15!c:',
    'GR': 'GR2!n3!n4!n16!c',
    'HU': 'HU2!n3!n4!n1!n15!n1!n',
    'IS': 'IS2!n4!n2!n6!n10!n',
    'IE': 'IE2!n4!a6!n8!n',
    'IL': 'IL2!n3!n3!n13!n',
    'IT': 'IT2!n1!a5!n5!n12!c',
    'KZ': '2!a2!n3!n13!c',
    'KW': 'KW2!n4!a22!',
    'LV': 'LV2!n4!a13!c',
    'LB': 'LB2!n4!n20!c',
    'LI': 'LI2!n5!n12!c',
    'LT': 'LT2!n5!n11!n',
    'LU': 'LU2!n3!n13!c',
    'MK': 'MK2!n3!n10!c2!n',
    'MT': 'MT2!n4!a5!n18!c',
    'MR': 'MR135!n5!n11!n2!n',
    'MU': 'MU2!n4!a2!n2!n12!n3!n3!a',
    'MC': 'MC2!n5!n5!n11!c2!n',
    'ME': 'ME2!n3!n13!n2!n',
    'NL': 'NL2!n4!a10!n',
    'NO': 'NO2!n4!n6!n1!n',
    'PL': 'PL2!n8!n16n',
    'PT': 'PT2!n4!n4!n11!n2!n',
    'RO': 'RO2!n4!a16!c',
    'SM': 'SM2!n1!a5!n5!n12!c',
    'SA': 'SA2!n2!n18!c',
    'RS': 'RS2!n3!n13!n2!n',
    'SK': 'SK2!n4!n6!n10!n',
    'SI': 'SI2!n5!n8!n2!n',
    'ES': 'ES2!n4!n4!n1!n1!n10!n',
    'SE': 'SE2!n3!n16!n1!n',
    'CH': 'CH2!n5!n12!c',
    'TN': 'TN592!n3!n13!n2!n',
    'TR': 'TR2!n5!n1!c16!c',
    'AE': 'AE2!n3!n16!n',
    'GB': 'GB2!n4!a6!n8!n'
  };

  ///  from MaskedInputFormatter
  ///  final String _anyCharMask = '#'; -> c
  ///  final String _onlyCharMask = 'A'; -> a
  ///  final String _onlyDigitMask = '0'; -> n
  static final Map<String, String> tokenCodes = {'a': 'A', 'n': '0', 'c': '#'};
}
