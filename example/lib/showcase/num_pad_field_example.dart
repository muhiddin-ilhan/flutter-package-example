import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/inputs/controller/amount_editing_controller.dart';
import 'package:vc_product_widgets/components/inputs/vc_amount_box_field.dart';
import 'package:vc_product_widgets/components/inputs/formatters/amount_input_formatter.dart';
import 'package:vc_product_widgets/components/numpad/vc_num_pad_field.dart';

import '../data/dummy_data.dart';

class NumPadFieldExamples extends StatefulWidget {
  const NumPadFieldExamples({Key? key}) : super(key: key);

  @override
  State<NumPadFieldExamples> createState() => _NumPadFieldExamplesState();
}

class _NumPadFieldExamplesState extends State<NumPadFieldExamples> {
  AmountEditingController textEditingController = AmountEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Numpad Fields",
      )),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
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
                const SizedBox(height: 50,),
                VCNumPadField(
                  controller: textEditingController,
                  formatter: AmountInputFormatter(decimal: 2, currency: DummyData.currency2()),
                ),
                const Divider(height: 100),
                VCNumPadField(
                  controller: textEditingController,
                  formatter: AmountInputFormatter(decimal: 2, currency: DummyData.currency2()),
                  mainAxisAlignment: MainAxisAlignment.center,
                  runSpace: 0,
                  isFingerPrintActive: true,
                ),
                const Divider(height: 100),
                VCNumPadField(
                  controller: textEditingController,
                  formatter: AmountInputFormatter(decimal: 2, currency: DummyData.currency2()),
                  radius: 10,
                  backgroundColor: Colors.blue,
                ),
              ],
            )),
      ),
    );
  }
}
