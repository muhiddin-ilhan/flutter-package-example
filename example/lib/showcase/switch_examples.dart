import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/Switch/vc_product_Switch.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

class SwitchExamples extends StatefulWidget {
  const SwitchExamples({Key? key}) : super(key: key);

  @override
  State<SwitchExamples> createState() => _SwitchExamplesState();
}

class _SwitchExamplesState extends State<SwitchExamples> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  String text = "Please open the switch.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Switch",
      )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Wrap(
              runSpacing: 20,
              children: [
                VCProductSwitch(),
                VCProductSwitch(
                    text: text,
                    onChanged: (isChecked) {
                      setState(() {
                        if (isChecked == true) {
                          text = "Please close the switch.";
                        } else {
                          text = "Please open the switch.";
                        }
                      });
                    }),
                VCProductSwitch(
                  text: "Please open the switch.",
                ),
                VCProductSwitch(
                  disabled: true,
                  text: "Please open the switch.",
                ),
                VCProductSwitch(
                  disabled: true,
                  text: "Please close the switch.",
                  isSelected: true,
                ),
                VCProductSwitch(
                  onOffDisable: false,
                ),

                VCProductSwitch(
                  disabled: true,
                  text: "Please open the switch.",
                  onOffDisable: false,
                ),
                VCProductSwitch(
                  disabled: true,
                  text: "Please close the switch.",
                  isSelected: true,
                  onOffDisable: false,
                ),
                VCProductSwitch(
                  onOffDisable: false,
                  offText: "CLOSE",
                  onText: "OPEN",
                  selectedColor: VCProductColors.instance.navyBlue,
                  backgroundColor: VCProductColors.instance.strokeGray,
                ),
                VCProductSwitch(
                  text: "Please open the switch.",
                  onOffDisable: false,
                  offText: "CLOSE",
                  onText: "OPEN",
                  selectedColor: VCProductColors.instance.navyBlue,
                  backgroundColor: VCProductColors.instance.strokeGray,
                ),
                VCProductSwitch(
                  disabled: true,
                  text: "Please open the switch.",
                  onOffDisable: false,
                  offText: "CLOSE",
                  onText: "OPEN",
                  selectedColor: VCProductColors.instance.navyBlue,
                  backgroundColor: VCProductColors.instance.strokeGray,
                ),
                VCProductSwitch(
                  disabled: true,
                  text: "Please close the switch.",
                  isSelected: true,
                  onOffDisable: false,
                  offText: "CLOSE",
                  onText: "OPEN",
                  selectedColor: VCProductColors.instance.navyBlue,
                  backgroundColor: VCProductColors.instance.strokeGray,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
