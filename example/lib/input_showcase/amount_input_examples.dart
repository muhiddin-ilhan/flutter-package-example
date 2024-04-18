import 'package:example/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/inputs/controller/amount_editing_controller.dart';
import 'package:vc_product_widgets/components/inputs/vc_amount_box_field.dart';


class AmountTextFieldExamples extends StatefulWidget {
  const AmountTextFieldExamples({Key? key}) : super(key: key);

  @override
  State<AmountTextFieldExamples> createState() => _AmountTextFieldExamplesState();
}

class _AmountTextFieldExamplesState extends State<AmountTextFieldExamples> {
  final _formKey = GlobalKey<FormState>();
  AmountEditingController textEditingController = AmountEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Amount Text Fields",
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Wrap(
              runSpacing: 20,
              children: [
                VCAmountBoxField(
                  maxAmount: 10000,
                  maxCheck: true,
                  minAmount: 10,
                  minCheck: true,
                  label: "Amount",
                  currency: DummyData.currency2(),
                  inputType: TextInputType.number,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Error Text";
                    }
                    return null;
                  },
                ),
                VCAmountBoxField(
                  currency: DummyData.currency2(),
                  textAlign: TextAlign.center,
                  amountController: textEditingController,
                  label: "Amount",
                  inputType: TextInputType.number,
                  buttons: const [50 , 100, 150, 200, 250],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      debugPrint("deneme");
                      return "Error Text";
                    }
                    return null;
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
