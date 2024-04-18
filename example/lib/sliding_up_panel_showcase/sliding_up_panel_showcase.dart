import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class SlidingUpPanelShowcase extends StatefulWidget {
  const SlidingUpPanelShowcase({Key? key}) : super(key: key);

  @override
  State<SlidingUpPanelShowcase> createState() => _SlidingUpPanelShowcaseState();
}

class _SlidingUpPanelShowcaseState extends State<SlidingUpPanelShowcase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Sliding Up Panel Showcase",
      )),
      body: VCSlidingUpPanel(
        minHeight: 48,
        panel: Column(
          children: [
            VCProductComponents.text(
              text: "Sliding Up Panel content",
              typographyType: TypographyType.bodyBlack16,
            ),
          ],
        ),
        body: VCProductComponents.text(
          text: "Sliding Up Panel Body",
          typographyType: TypographyType.bodyBlack16,
        ),
      ),
    );
  }
}
