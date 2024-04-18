import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/terms_and_conditions/vc_terms_and_conditions.dart';

class TermAndConditionsExamples extends StatefulWidget {
  const TermAndConditionsExamples({Key? key}) : super(key: key);

  @override
  State<TermAndConditionsExamples> createState() => _TermAndConditionsExamplesState();
}

class _TermAndConditionsExamplesState extends State<TermAndConditionsExamples> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "TermS And Conditions",
      )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Wrap(
              runSpacing: 20,
              children: [
                VCProductTermsAndConditions(
                  executingTransactionName: "CustomerEnrollment"
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

