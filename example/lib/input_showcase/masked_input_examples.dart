import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/inputs/vc_base_text_field.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';

class MaskedTextFieldExamples extends StatefulWidget {
  const MaskedTextFieldExamples({Key? key}) : super(key: key);

  @override
  State<MaskedTextFieldExamples> createState() =>
      _MaskedTextFieldExamplesState();
}

class _MaskedTextFieldExamplesState extends State<MaskedTextFieldExamples> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  String maskValue = "000 ### AAA";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Masked Text Fields",
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
                    "The \"Masked\" field will be automatically formatted according to the value you enter in the \"Mask\" field. You can see examples below."
                        "\n\n"
                        "As maskable characters. # means any possible character, A means only alphabetic character, 0 means only digits. If you enter a different character, it will be used as a separator.\n"
                        "Examples:\n"
                        "#### AA 000\n"
                        "0000 0000 00\n"
                        "AAAA00\n"),
                VCBaseTextField(
                  onChanged: (value){
                    setState(() {
                      maskValue = value;
                    });
                  },
                  controller: textEditingController,
                  initValue: maskValue,
                  label: "Mask",
                  deletable: true,
                  hintText: "000 ### AAA",
                ),
                VCProductComponents.maskedTextField(
                    title: "Masked", mask: maskValue),
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
