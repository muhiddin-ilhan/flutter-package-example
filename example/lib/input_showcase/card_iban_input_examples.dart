import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';

class CardIbanTextFieldExamples extends StatefulWidget {
  const CardIbanTextFieldExamples({Key? key}) : super(key: key);

  @override
  State<CardIbanTextFieldExamples> createState() =>
      _CardIbanTextFieldExamplesState();
}

class _CardIbanTextFieldExamplesState extends State<CardIbanTextFieldExamples> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Card&Iban Text Fields",
      )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Wrap(
              runSpacing: 20,
              children: [
                _buildInfoText(
                    "The Card Number field is formatted according to the first characters entered. The first characters can only take valid card system codes."
                    "\n\n"
                    "Examples:\n"
                    "DINERS_CLUB	-> 3600 000000 0000\n"
                    "MASTERCARD -> 5000 0000 0000 0000\n"
                    "MAESTRO ->	6700 0000 0000 0000 0\n"),
                VCProductComponents.cardNumberTextField(),
                _buildInfoText(
                    "The Iban field is formatted according to the first two characters entered. The first two characters can only take valid iban country codes."
                    "\n\n"
                    "As maskable characters. # means any possible character, A means only alphabetic character, 0 means only digits. \n"
                    "Examples:\n"
                    "Turkey	-> TR00 00000 # ################\n"
                    "Bulgaria -> BG00 AAAA 0000 00 ########\n"
                    "Germany ->	DE00 00000000 0000000000\n"),
                VCProductComponents.ibanNumberTextField(),
                Row(
                  children: [
                    Expanded(
                      child: VCProductComponents.expirationDateTextField(),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: VCProductComponents.cvvTextField(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoText(String infoText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.warning_amber_sharp,
          color: Colors.black54,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            infoText,
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
