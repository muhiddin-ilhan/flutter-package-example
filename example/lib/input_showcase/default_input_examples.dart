import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/inputs/vc_base_text_field.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';

class DefaultTextFieldExamples extends StatefulWidget {
  const DefaultTextFieldExamples({Key? key}) : super(key: key);

  @override
  State<DefaultTextFieldExamples> createState() => _DefaultTextFieldExamplesState();
}

class _DefaultTextFieldExamplesState extends State<DefaultTextFieldExamples> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Default Text Fields",
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Wrap(
              runSpacing: 20,
              children: [
                //Text Field Components
                VCBaseTextField(
                    label: "Default",
                    deletable: true,
                    hintText: "Hint",
                    suffixIcon: const Icon(Icons.person),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Error Text";
                      }
                      return null;
                    }),
                VCBaseTextField(
                  label: "Default",
                  suffixIcon: const Icon(Icons.person),
                  enabled: false,
                ),
                VCBaseTextField(
                  label: "Multiline",
                  inputType: TextInputType.multiline,
                  counterEnabled: true,
                  deletable: true,
                ),
                VCProductComponents.elevatedButton(
                    text: "Validate",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
