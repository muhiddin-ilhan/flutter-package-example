import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class RatingStarShowcase extends StatefulWidget {
  const RatingStarShowcase({Key? key}) : super(key: key);

  @override
  State<RatingStarShowcase> createState() => _RatingStarShowcaseState();
}

class _RatingStarShowcaseState extends State<RatingStarShowcase> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: VCProductColors.instance.navyBlue,
        foregroundColor: VCProductColors.instance.white,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: context.paddingNormal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VCProductComponents.text(
                  text: "How was your Experience with our new ebanking?",
                  typographyType: TypographyType.bodyMedium14),
              context.emptySizedHeightBoxNormal,
              VCRatingStars(
                value: value,
                onValueChanged: (v) {
                  //
                  setState(() {
                    value = v;
                  });
                },
                starCount: 5,
                starSize: 50,
                maxValue: 5,
                starSpacing: 2,
                maxValueVisibility: true,
                valueLabelVisibility: false,
                starOffColor: VCProductColors.instance.labelColor,
                starColor: VCProductColors.instance.activeTileColor,
              ),
              context.emptySizedHeightBoxNormal,
              Expanded(
                child: VCBaseTextField(
                  label: "Your Feedback",
                  inputType: TextInputType.multiline,
                  counterEnabled: true,
                  deletable: true,
                  maxLength: 250,
                  expanded: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
