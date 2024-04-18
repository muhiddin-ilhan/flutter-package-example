import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/checkbox/vc_product_checkbox.dart';

class CheckBoxExamples extends StatefulWidget {
  const CheckBoxExamples({Key? key}) : super(key: key);

  @override
  State<CheckBoxExamples> createState() => _CheckBoxExamplesState();
}

class _CheckBoxExamplesState extends State<CheckBoxExamples> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  String text = "Please confirm the Agreement.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "CheckBox",
      )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Wrap(
              runSpacing: 20,
              children: [
                VCProductCheckBox(text: text, onChanged: (isChecked) {
                  setState(() {
                    if(isChecked == true){
                      text = "Contract Approved.";
                    }else{
                      text = "Please confirm the Agreement.";
                    }
                  });
                }),
                VCProductCheckBox(text: "Contract Approved.", isChecked: true, disabled: true,),

                VCProductCheckBox(text: "Please confirm the Agreement", disabled: true,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
