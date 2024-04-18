import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class StepperShowCase extends StatefulWidget {
  const StepperShowCase({Key? key}) : super(key: key);

  @override
  State<StepperShowCase> createState() => _StepperShowCaseState();
}

class _StepperShowCaseState extends State<StepperShowCase> {
  int stepCount = 5;
  int activeStep = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VCProductColors.instance.bottomSheetBGColor,
      appBar: AppBar(
        backgroundColor: VCProductColors.instance.navyBlue,
        foregroundColor: VCProductColors.instance.white,
        title: VCProductText(
          text: "Stepper Showcase",
          type: TypographyType.label,
          textColor: VCProductColors.instance.white,
        ),
      ),
      body: Container(
        padding: context.paddingNormal,
        child: Column(
          children: [
            Container(
              padding: context.paddingNormal,
              decoration: BoxDecoration(
                color: VCProductColors.instance.white,
                borderRadius: context.lowBorderRadius,
              ),
              child: VCStepperComponent(
                infoText: "Information Text Here!",
                headlineText: "Headline",
                stepCount: stepCount,
                activeStep: activeStep,
              ),
            ),
            context.emptySizedHeightBoxNormal,
            VCProductComponents.elevatedButton(
              onPressed: () {
                setState(() {
                  stepCount += 1;
                });
              },
              text: "Add Step",
            ),
            VCProductComponents.elevatedButton(
              onPressed: () {
                setState(() {
                  stepCount -= 1;
                });
              },
              text: "Remove Step",
            ),
            context.emptySizedHeightBoxNormal,
            VCProductComponents.elevatedButton(
              onPressed: () {
                setState(() {
                  activeStep += 1;
                });
              },
              text: "Increase Step",
            ),
            VCProductComponents.elevatedButton(
              onPressed: () {
                setState(() {
                  activeStep -= 1;
                });
              },
              text: "Decrease Step",
            ),
          ],
        ),
      ),
    );
  }
}
