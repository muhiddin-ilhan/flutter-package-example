import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

enum CustomCardBackgroundSizeEnum {
  low(60),
  normal(125),
  high(150);

  final double value;

  const CustomCardBackgroundSizeEnum(this.value);
}

class CustomCardBackground extends StatelessWidget {
  final Widget child;
  final CustomCardBackgroundSizeEnum customHeightEnum;
  const CustomCardBackground(
      {super.key,
      required this.child,
      this.customHeightEnum = CustomCardBackgroundSizeEnum.normal});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: customHeightEnum.value,
          width: double.infinity,
          child: ColoredBox(
              color: VCProductColors.instance.backgroundGradientStart),
        ),
        child,
      ],
    );
  }
}
