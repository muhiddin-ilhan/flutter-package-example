import 'package:flutter/material.dart';

enum InputType {
  cardNumber(title: "Card Number", hint: "0000 0000 0000 0000"),
  ibanNumber(title: "Iban Number", hint: "TR00 0000 0000 0000 0000 0000 00", maxLength: 32),
  expirationDate(title: "Expiration Date", hint: "00/00"),
  cvv(title: "CVV", hint: "000"),
  amount(title: "Amount", hint: "0.00"),
  mobileNumber(title: "Mobile Number");


  final String? title;
  final String? hint;
  final int? maxLength;

  const InputType({this.title, this.hint,this.maxLength});

}
