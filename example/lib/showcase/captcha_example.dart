import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/captcha/vc_product_captcha.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

class CaptchaExamples extends StatefulWidget {
  const CaptchaExamples({Key? key}) : super(key: key);

  @override
  State<CaptchaExamples> createState() => _CaptchaExamplesState();
}

class _CaptchaExamplesState extends State<CaptchaExamples> {
  final _formKey = GlobalKey<FormState>();
  var apiUrl = "https://vcmbibv8newui.demo.veripark.com/";
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Captcha",
      )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Wrap(
              runSpacing: 20,
              children: [
                
               VCProductCaptcha(
                apiUrl: apiUrl,
                
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Error Text";
                  }
                  return  "Error Text";
                },
               ),
               VCProductCaptcha(
                apiUrl: apiUrl,
                hintText: "smwm",
                
               ),
               VCProductCaptcha(
                apiUrl: apiUrl,
                initTextValue: "smwm",
                buttonColor: VCProductColors.instance.navyBlue,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Error Text";
                  }
                  return  "Error Text";
                },
               ),

               VCProductCaptcha(
                apiUrl: apiUrl,
                initTextValue: "smwm",
                disabled: true,
                buttonColor: VCProductColors.instance.navyBlue,
               ),

               VCProductCaptcha(
                apiUrl: apiUrl,
                disabled: true
               ),
               VCProductComponents.elevatedButton(
                    text: "Validate",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          
                        });
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
