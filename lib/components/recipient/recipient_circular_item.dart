import 'package:flutter/material.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';

import '../../utils/color_constant.dart';
import '../text/typography_type.dart';
import '../text/vc_font_weight.dart';
import '../text/vc_product_text.dart';
import '../vc_product_components.dart';

class RecipientCircularItem extends StatefulWidget {
  // Title TextStyles Configrations
  final String? nameText;
  final TypographyType? nameTypographyType;
  final Color? nameTextColor;
  final double? nameFontSize;
  final FontWeight? nameFontWeight;
  final Widget? icon;
  final Function()? onTap;
  final double? height;
  final double? width;


  // Widget Container Configrations
  final Color? containerBackgroundColor;
  final BorderRadius? containerBorderRadius;
  final EdgeInsets? widgetPadding;

  const RecipientCircularItem(
      {Key? key,
      this.containerBackgroundColor,
      this.containerBorderRadius,
      this.widgetPadding,
      this.nameText,
      this.nameTypographyType,
      this.nameTextColor,
      this.nameFontSize,
      this.nameFontWeight,
      this.icon,
      this.onTap,
      this.height,
      this.width})
      : super(key: key);

  @override
  State<RecipientCircularItem> createState() => _RecipientCircularItemState();
}

class _RecipientCircularItemState extends State<RecipientCircularItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        children: [
          Ink(
            height: widget.height ?? 52,
            width: widget.width ?? 52,
            decoration: BoxDecoration(
              color:
              widget.containerBackgroundColor ?? VCProductColors.instance.white,
              borderRadius: widget.containerBorderRadius ?? context.circleBorderRadius,
            ),
            child:  FittedBox(
                child: Padding(
                    padding: context.paddingLow,
                    child:widget.icon ?? VCProductComponents.text(
                        text: getShortName(widget.nameText),
                        fontSize: 15,
                        fontWeight: VCFontWeights.medium)
                )),
          ),
          context.emptySizedHeightBoxLow,
          VCProductText(
            text: widget.nameText ?? "Recipient Name",
            textAlign: TextAlign.start,
            maxLines: 1,
            type: widget.nameTypographyType ?? TypographyType.bodyRegular14,
            textColor: (widget.nameTextColor ?? VCProductColors.instance.black),
            fontWeight: widget.nameFontWeight,
            fontSize: widget.nameFontSize,
          ),
        ],
      ),
    );
  }


  String getShortName(String? name) {
    List<String> splitted = name?.split(' ') ?? [];

    String result = '';

    if (splitted.isNotEmpty) {
      result += splitted.first[0].toUpperCase();
    }
    if (splitted.length >= 2) {
      result += splitted.last[0].toUpperCase();
    }

    return result;
  }
}
