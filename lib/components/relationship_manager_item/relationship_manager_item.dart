import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';
import 'package:vc_product_widgets/components/text/vc_product_text.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import '../text/vc_font_weight.dart';

class RelationshipManagerItem extends StatefulWidget {
  // Title TextStyles Configrations
  final String? titleText;
  final TypographyType? titleTypographyType;
  final Color? titleTextColor;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;

  // Subtitle TextStyles Configrations
  final String? subtitleText;
  final TypographyType? subtitleTypographyType;
  final Color? subtitleTextColor;
  final double? subtitleFontSize;
  final FontWeight? subtitleFontWeight;

  // Subtitle2 TextStyles Configrations
  final String? subtitle2Text;
  final TypographyType? subtitle2TypographyType;
  final Color? subtitle2TextColor;
  final double? subtitle2FontSize;
  final FontWeight? subtitle2FontWeight;

  // leadingIcon Configrations
  final Color? leadingIconColor;
  final double? leadingIconHeight;
  final Widget? leadingIcon;
  final Color? leadingIconBackgroundColor;
  final bool leadingIconVisibility;

  // Widget Container Configrations
  final Color? containerBackgroundColor;
  final BorderRadius? containerBorderRadius;
  final bool isWrapContainer;
  final EdgeInsets? widgetPadding;

  final bool isInactive;

  // Selectable Configrations
  final bool isSelectable;
  final bool isSelected;
  final Color selectedColor;
  final Function()? onTap;

  const RelationshipManagerItem({
    super.key,
    this.titleTypographyType,
    this.titleTextColor,
    this.titleFontSize,
    this.titleFontWeight,
    this.subtitleTypographyType,
    this.subtitleTextColor,
    this.subtitleFontSize,
    this.subtitleFontWeight,
    this.leadingIconColor,
    this.leadingIconHeight,
    this.leadingIcon,
    this.isInactive = false,
    this.containerBackgroundColor,
    this.containerBorderRadius,
    this.isWrapContainer = false,
    this.leadingIconBackgroundColor,
    this.isSelectable = false,
    this.isSelected = false,
    this.onTap,
    this.selectedColor = const Color(0xFF316CE2),
    this.widgetPadding,
    this.subtitleText,
    this.titleText,
    this.leadingIconVisibility = true,
    this.subtitle2Text,
    this.subtitle2TypographyType,
    this.subtitle2TextColor,
    this.subtitle2FontSize,
    this.subtitle2FontWeight,
  });

  @override
  State<RelationshipManagerItem> createState() =>
      _RelationshipManagerItemState();
}

class _RelationshipManagerItemState extends State<RelationshipManagerItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.isWrapContainer) {
      return Ink(
        decoration: BoxDecoration(
          color:
              widget.containerBackgroundColor ?? VCProductColors.instance.white,
          borderRadius: widget.containerBorderRadius ?? context.lowBorderRadius,
        ),
        child: body,
      );
    } else {
      return body;
    }
  }

  Widget get body => InkWell(
        borderRadius: widget.containerBorderRadius ?? context.lowBorderRadius,
        onTap: widget.onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 52),
          child: Padding(
            padding: widget.widgetPadding ?? context.paddingNormal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (widget.leadingIconVisibility) leadingIcon,
                          if (widget.leadingIconVisibility)
                            context.emptySizedWidthBoxLow,
                          titleAndSubTitle,
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget get titleAndSubTitle => Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.semiLowValue / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              VCProductText(
                text: widget.titleText ?? "Recipient Name",
                textAlign: TextAlign.start,
                maxLines: 1,
                type:
                    widget.titleTypographyType ?? TypographyType.bodyRegular14,
                textColor: widget.isSelected
                    ? widget.selectedColor
                    : (widget.titleTextColor ?? VCProductColors.instance.black)
                        .withOpacity(widget.isInactive ? 0.6 : 1),
                fontWeight: widget.titleFontWeight,
                fontSize: widget.titleFontSize,
              ),
              if (widget.subtitleText?.isNotEmpty == true)
                VCProductText(
                  text: widget.subtitleText.toString(),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  type:
                      widget.subtitleTypographyType ?? TypographyType.smallText,
                  textColor: widget.isSelected
                      ? widget.selectedColor
                      : (widget.subtitleTextColor ??
                              VCProductColors.instance.black)
                          .withOpacity(widget.isInactive ? 0.6 : 1),
                  fontWeight: widget.subtitleFontWeight,
                  fontSize: widget.subtitleFontSize,
                ),
              if (widget.subtitle2Text?.isNotEmpty == true)
                VCProductText(
                  text: widget.subtitle2Text.toString(),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  type: widget.subtitle2TypographyType ??
                      TypographyType.smallText,
                  textColor: widget.isSelected
                      ? widget.selectedColor
                      : (widget.subtitle2TextColor ??
                              VCProductColors.instance.black)
                          .withOpacity(widget.isInactive ? 0.4 : 0.6),
                  fontWeight: widget.subtitle2FontWeight,
                  fontSize: widget.subtitle2FontSize,
                ),
            ],
          ),
        ),
      );

  Container get leadingIcon => Container(
        width: 42,
        height: 42,
        padding: context.paddingMini,
        decoration: BoxDecoration(
          color: widget.leadingIconBackgroundColor ??
              VCProductColors.instance.bottomSheetBGColor,
          borderRadius: BorderRadius.circular(context.lowValue),
        ),
        child: Opacity(
          opacity: widget.isInactive ? 0.6 : 1,
          child: FittedBox(
              child: Padding(
            padding: context.paddingLow,
            child: widget.leadingIcon ??
                VCProductComponents.text(
                    text: getShortName(widget.titleText),
                    fontSize: 15,
                    fontWeight: VCFontWeights.medium),
          )),
        ),
      );
      

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
