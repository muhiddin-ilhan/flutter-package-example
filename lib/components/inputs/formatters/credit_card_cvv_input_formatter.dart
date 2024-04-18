import 'masked_input_formatter.dart';

class CreditCardCvcInputFormatter extends MaskedInputFormatter {
  CreditCardCvcInputFormatter({bool isAmericanExpress = false})
      : super(
    isAmericanExpress ? '0000' : '000',
  );
}