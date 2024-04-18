import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';
import 'package:vc_product_widgets/components/text/vc_font_weight.dart';
import 'package:vc_product_widgets/components/text/vc_product_text.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/utils/vc_icons.dart';

class VCProductEmptyContainer extends StatelessWidget {
  final String? title;
  final String? description;
  final Widget? icon;
  const VCProductEmptyContainer(
      {super.key, this.title, this.description, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: context.paddingLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          context.emptySizedHeightBoxLow,
          icon ?? VCIcons.emptyContainerIcon,
          context.emptySizedHeightBoxLow,
          title != null
              ? VCProductText(
                  text: title!,
                  type: TypographyType.bodyMedium16,
                  textColor: VCProductColors.instance.widgetTextColor,
                )
              : const SizedBox.shrink(),
          context.emptySizedHeightBoxLow,
          description != null
              ? VCProductText(
                  text: description!,
                  fontWeight: VCFontWeights.regular,
                  fontSize: 13,
                  textColor: VCProductColors.instance.labelColor,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
