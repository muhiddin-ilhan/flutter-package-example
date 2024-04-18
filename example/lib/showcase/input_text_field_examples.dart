import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/buttons/elevated_button/button_size.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';

import '../input_showcase/amount_input_examples.dart';
import '../input_showcase/card_iban_input_examples.dart';
import '../input_showcase/default_input_examples.dart';
import '../input_showcase/masked_input_examples.dart';
import '../input_showcase/password_pin_input_examles.dart';


class InputTextFieldExamples extends StatefulWidget {
  const InputTextFieldExamples({Key? key}) : super(key: key);

  @override
  State<InputTextFieldExamples> createState() => _InputTextFieldExamplesState();
}

class _InputTextFieldExamplesState extends State<InputTextFieldExamples> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Input Text Fields",
      )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Wrap(
              runSpacing: 20,
              children: [
                VCProductComponents.elevatedButton(
                  size: ButtonSize.large,
                  text: "Default Input Fields",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DefaultTextFieldExamples(),
                      ),
                    );
                  },
                ),
                VCProductComponents.elevatedButton(
                  size: ButtonSize.large,
                  text: "Password&Pin Input Fields",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PassPinTextFieldExamples(),
                      ),
                    );
                  },
                ),
                VCProductComponents.elevatedButton(
                  size: ButtonSize.large,
                  text: "Card&Iban Input Fields",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CardIbanTextFieldExamples(),
                      ),
                    );
                  },
                ),
                VCProductComponents.elevatedButton(
                  size: ButtonSize.large,
                  text: "Masked Input Fields",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MaskedTextFieldExamples(),
                      ),
                    );
                  },
                ),
                VCProductComponents.elevatedButton(
                  size: ButtonSize.large,
                  text: "Amount Input Fields",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AmountTextFieldExamples(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
