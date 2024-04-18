import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';

class PassPinTextFieldExamples extends StatefulWidget {
  const PassPinTextFieldExamples({Key? key}) : super(key: key);

  @override
  State<PassPinTextFieldExamples> createState() => _PassPinTextFieldExamplesState();
}

class _PassPinTextFieldExamplesState extends State<PassPinTextFieldExamples> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Password&Pin Text Fields",
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Wrap(
              runSpacing: 20,
              children: [

                VCProductComponents.passwordTextField(),
                VCProductComponents.pinTextField(
                  pinController: textEditingController,
                  pinLength: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
