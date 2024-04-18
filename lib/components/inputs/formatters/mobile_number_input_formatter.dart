import 'package:flutter/services.dart';

class MobilePhoneMaskFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Get the text to be masked
    String text = newValue.text;

    // Keep only digit characters
    String cleanedText = text.replaceAll(RegExp(r'\D'), '');

    // Create the masked text
    StringBuffer maskedText = StringBuffer();
    int index = 0;

    // First 2 characters
    if (cleanedText.length > 2) {
      maskedText.write(cleanedText.substring(0, 2));
      index = 2;
    } else {
      maskedText.write(cleanedText.substring(0, cleanedText.length));
      return TextEditingValue(
        text: maskedText.toString(),
        selection: TextSelection.collapsed(offset: maskedText.length),
      );
    }

    // Next 4 characters
    if (cleanedText.length > 6) {
      maskedText.write(' ${cleanedText.substring(2, 6)}');
      index = 6;
    } else {
      maskedText.write(' ${cleanedText.substring(2, cleanedText.length)}');
      return TextEditingValue(
        text: maskedText.toString(),
        selection: TextSelection.collapsed(offset: maskedText.length),
      );
    }

    // Remaining characters
    if (cleanedText.length > 6) {
      maskedText.write(' ${cleanedText.substring(6)}');
    }

    return TextEditingValue(
      text: maskedText.toString(),
      selection: TextSelection.collapsed(offset: index + 1),
    );
  }
}
