import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/slider/vc_product_slider.dart';

class SliderExamples extends StatefulWidget {
  const SliderExamples({Key? key}) : super(key: key);

  @override
  State<SliderExamples> createState() => _SliderExamplesState();
}

class _SliderExamplesState extends State<SliderExamples> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            getTitle("With Divisions"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: VCProductSlider(
                prefix: "₺",
                onChanged: (newValue) {
                  setState(() {
                    debugPrint(newValue.toString());
                  });
                },
                min: 0,
                max: 10,
                divisions: 10,
              ),
            ),
            getTitle("Continuous"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: VCProductSlider(
                prefix: "₺",
                onChanged: (newValue) {
                  setState(() {
                    debugPrint(newValue.toString());
                  });
                },
                min: 0,
                max: 10,
                divisions: null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
