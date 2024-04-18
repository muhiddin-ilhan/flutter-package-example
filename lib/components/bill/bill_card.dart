import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';
import 'package:vc_product_widgets/components/text/vc_product_text.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

class BillCard extends StatefulWidget {
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

  // Subtitle1 TextStyles Configrations
  final bool subtitle1Visibility;
  final String? subtitle1Text;
  final TypographyType? subtitle1TypographyType;
  final Color? subtitle1TextColor;
  final double? subtitle1FontSize;
  final FontWeight? subtitle1FontWeight;

  // Subtitle2 TextStyles Configrations
  final bool subtitle2Visibility;
  final String? subtitle2Text;
  final TypographyType? subtitle2TypographyType;
  final Color? subtitle2TextColor;
  final double? subtitle2FontSize;
  final FontWeight? subtitle2FontWeight;

  // balanceTitle TextStyles Configrations
  final String? balanceTitleText;
  final TypographyType? balanceTitleTypographyType;
  final Color? balanceTitleTextColor;
  final double? balanceTitleFontSize;
  final FontWeight? balanceTitleFontWeight;

  // balance TextStyles Configrations
  final String? balanceText;
  final TypographyType? balanceTypographyType;
  final Color? balanceTextColor;
  final double? balanceFontSize;
  final FontWeight? balanceFontWeight;
  final bool balanceVisibility;

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

  // Selectable Configrations
  final bool isSelectable;
  final bool isSelected;
  final Color selectedColor;
  final Function()? onTap;

  // Leading Divider Configrations
  final bool leadingDividerVisibility;
  final Color? leadingDividerColor;

  final bool suffixDownButtonVisibility;

  const BillCard({
    super.key,
    this.titleTypographyType,
    this.titleTextColor,
    this.titleFontSize,
    this.titleFontWeight,
    this.subtitleTypographyType,
    this.subtitleTextColor,
    this.subtitleFontSize,
    this.subtitleFontWeight,
    this.balanceTitleTypographyType,
    this.balanceTitleTextColor,
    this.balanceTitleFontSize,
    this.balanceTitleFontWeight,
    this.balanceTypographyType,
    this.balanceTextColor,
    this.balanceFontSize,
    this.balanceFontWeight,
    this.leadingIconColor,
    this.leadingIconHeight,
    this.leadingIcon,
    this.containerBackgroundColor,
    this.containerBorderRadius,
    this.isWrapContainer = false,
    this.balanceText,
    this.balanceVisibility = false,
    this.leadingIconBackgroundColor,
    this.isSelectable = false,
    this.isSelected = false,
    this.onTap,
    this.selectedColor = const Color(0xFF316CE2),
    this.widgetPadding,
    this.subtitleText,
    this.titleText,
    this.balanceTitleText,
    this.suffixDownButtonVisibility = false,
    this.leadingIconVisibility = true,
    this.subtitle1Text,
    this.subtitle1TypographyType,
    this.subtitle1TextColor,
    this.subtitle1FontSize,
    this.subtitle1FontWeight,
    this.subtitle2Text,
    this.subtitle2TypographyType,
    this.subtitle2TextColor,
    this.subtitle2FontSize,
    this.subtitle2FontWeight,
    this.subtitle1Visibility = false,
    this.subtitle2Visibility = false,
    this.leadingDividerVisibility = false,
    this.leadingDividerColor,
  });

  @override
  State<BillCard> createState() => _BillCardState();
}

class _BillCardState extends State<BillCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.isWrapContainer) {
      return Ink(
        decoration: BoxDecoration(
          color: widget.containerBackgroundColor ?? VCProductColors.instance.white,
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
        child: Padding(
          padding: widget.widgetPadding ?? context.paddingNormal,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.leadingDividerVisibility) leadingDivider,
                if (widget.leadingIconVisibility) ...[leadingIcon, context.emptySizedWidthBoxLow],
                titleAndSubTitles,
                context.emptySizedHeightBoxLow,
                if (widget.balanceVisibility) balanceWidget,
                if (widget.suffixDownButtonVisibility) suffixDownButton,
              ],
            ),
          ),
        ),
      );

  Widget get leadingDivider => Container(
        margin: context.onlyRightPaddingLow,
        decoration: BoxDecoration(
          color: widget.leadingDividerColor ?? VCProductColors.instance.navyBlue,
          borderRadius: context.highBorderRadius,
        ),
        width: 4,
      );

  Widget get suffixDownButton => IconButton(
        onPressed: () {},
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
      );

  Widget get balanceWidget => Padding(
        padding: EdgeInsets.only(right: context.semiLowValue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            VCProductText(
              text: widget.balanceTitleText ?? "Outstanding",
              type: widget.balanceTitleTypographyType ?? TypographyType.smallText,
              textColor: widget.isSelected ? widget.selectedColor : widget.balanceTitleTextColor,
              fontWeight: widget.balanceTitleFontWeight,
              fontSize: widget.balanceTitleFontSize,
            ),
            VCProductText(
              text: widget.balanceText ?? "\$4,500.00",
              type: widget.balanceTypographyType ?? TypographyType.placeholderAmount,
              textColor: widget.isSelected ? widget.selectedColor : widget.balanceTextColor,
              fontWeight: widget.balanceFontWeight,
              fontSize: widget.balanceFontSize,
            ),
          ],
        ),
      );

  Widget get titleAndSubTitles => Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.semiLowValue / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VCProductText(
                text: widget.titleText ?? "My Current Account",
                textAlign: TextAlign.start,
                maxLines: 1,
                type: widget.titleTypographyType ?? TypographyType.bodyMedium14,
                textColor: widget.isSelected ? widget.selectedColor : (widget.titleTextColor ?? VCProductColors.instance.black),
                fontWeight: widget.titleFontWeight,
                fontSize: widget.titleFontSize,
              ),
              VCProductText(
                text: widget.subtitleText ?? "Bill Type",
                textAlign: TextAlign.start,
                maxLines: 1,
                type: widget.subtitleTypographyType ?? TypographyType.smallText,
                textColor: widget.isSelected ? widget.selectedColor : (widget.subtitleTextColor ?? VCProductColors.instance.black),
                fontWeight: widget.subtitleFontWeight,
                fontSize: widget.subtitleFontSize,
              ),
              if (widget.subtitle1Visibility)
                VCProductText(
                  text: widget.subtitle1Text ?? "Expires: 23 May 2024",
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  type: widget.subtitle1TypographyType ?? TypographyType.smallText,
                  textColor:
                      widget.isSelected ? widget.selectedColor.withOpacity(0.8) : (widget.subtitle1TextColor ?? VCProductColors.instance.black),
                  fontWeight: widget.subtitle1FontWeight,
                  fontSize: widget.subtitle1FontSize,
                ),
              if (widget.subtitle2Visibility)
                VCProductText(
                  text: widget.subtitle2Text ?? "Outstanding: \$100.00",
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  type: widget.subtitle2TypographyType ?? TypographyType.smallText,
                  textColor:
                      widget.isSelected ? widget.selectedColor.withOpacity(0.8) : (widget.subtitle2TextColor ?? VCProductColors.instance.black),
                  fontWeight: widget.subtitle2FontWeight,
                  fontSize: widget.subtitle2FontSize,
                ),
            ],
          ),
        ),
      );

  double get getLeadingIconHeight {
    if (widget.leadingIconHeight != null) {
      return widget.leadingIconHeight!;
    }

    double titleTextHeight = (widget.titleFontSize ?? (widget.titleTypographyType ?? TypographyType.bodyRegular14).fontSize ?? 14) * 1.2;
    double subtitleTextHeight = (widget.subtitleFontSize ?? (widget.subtitleTypographyType ?? TypographyType.smallText).fontSize ?? 14) * 1.2;
    double titleWidgetPaddings = 10;

    return titleTextHeight + subtitleTextHeight + titleWidgetPaddings;
  }

  Container get leadingIcon => Container(
        height: getLeadingIconHeight,
        padding: context.paddingLow,
        decoration: BoxDecoration(
          color: widget.leadingIconBackgroundColor ?? VCProductColors.instance.bottomSheetBGColor,
          borderRadius: BorderRadius.circular(context.lowValue),
        ),
        child: FittedBox(
          child: widget.isSelected
              ? Icon(
                  Icons.done,
                  color: widget.selectedColor,
                )
              : widget.isSelectable
                  ? const Icon(
                      Icons.check_box_outline_blank_rounded,
                    )
                  : widget.leadingIcon ??
                      Icon(
                        Icons.wallet_outlined,
                        color: widget.leadingIconColor,
                      ),
        ),
      );
}
