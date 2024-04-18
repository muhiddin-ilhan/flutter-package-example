import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';
import 'package:vc_product_widgets/components/text/vc_product_text.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

import '../../utils/vc_icons.dart';
import '../text/vc_font_weight.dart';

enum RecipientBalancePosition { subTitle, end }

enum RecipientStatusType { pending, completed, error }

extension RecipientStatusTypeExtension on RecipientStatusType {
  Color? get backgroundColor {
    switch (this) {
      case RecipientStatusType.pending:
        return VCProductColors.instance.statusWarningColor;
      case RecipientStatusType.completed:
        return VCProductColors.instance.statusActiveColor;
      case RecipientStatusType.error:
        return VCProductColors.instance.statusErrorColor;
      default:
        return null;
    }
  }
}

class RecipientItem extends StatefulWidget {
  // Title TextStyles Configrations
  final String? nameText;
  final TypographyType? nameTypographyType;
  final Color? nameTextColor;
  final double? nameFontSize;
  final FontWeight? nameFontWeight;

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

  // share TextStyles Configrations
  final String? shareText;
  final TypographyType? shareTypographyType;
  final Color? shareTextColor;
  final double? shareFontSize;
  final FontWeight? shareFontWeight;
  final bool shareVisibility;

  // status TextStyles Configrations
  final String? statusText;
  final TypographyType? statusTypographyType;
  final Color? statusTextColor;
  final double? statusFontSize;
  final FontWeight? statusFontWeight;
  final bool isStatusActive;
  final RecipientStatusType statusType;
  final Color? statusColor;

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

  final RecipientBalancePosition balancePosition;

  final bool suffixVisibility;
  final dynamic suffixIcon;
  final Color? suffixColor;

  const RecipientItem({
    super.key,
    this.nameTypographyType,
    this.nameTextColor,
    this.nameFontSize,
    this.nameFontWeight,
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
    this.shareText,
    this.shareTypographyType,
    this.shareTextColor,
    this.shareFontSize,
    this.shareFontWeight,
    this.leadingIconColor,
    this.leadingIconHeight,
    this.leadingIcon,
    this.isInactive = false,
    this.isStatusActive = false,
    this.containerBackgroundColor,
    this.containerBorderRadius,
    this.isWrapContainer = false,
    this.shareVisibility = false,
    this.balanceText,
    this.balanceVisibility = false,
    this.leadingIconBackgroundColor,
    this.isSelectable = false,
    this.isSelected = false,
    this.onTap,
    this.selectedColor = const Color(0xFF316CE2),
    this.widgetPadding,
    this.subtitleText,
    this.nameText,
    this.balanceTitleText,
    this.balancePosition = RecipientBalancePosition.subTitle,
    this.suffixVisibility = false,
    this.leadingIconVisibility = true,
    this.statusTypographyType,
    this.statusTextColor,
    this.statusFontSize,
    this.statusFontWeight,
    this.statusText,
    this.statusType = RecipientStatusType.error,
    this.statusColor,
    this.suffixIcon,
    this.suffixColor,
    this.subtitle2Text,
    this.subtitle2TypographyType,
    this.subtitle2TextColor,
    this.subtitle2FontSize,
    this.subtitle2FontWeight,
  });

  @override
  State<RecipientItem> createState() => _RecipientItemState();
}

class _RecipientItemState extends State<RecipientItem> {
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
                          context.emptySizedHeightBoxLow,
                          if (widget.isStatusActive) statusCard,
                          if (!widget.isStatusActive &&
                              widget.balanceVisibility &&
                              widget.balancePosition ==
                                  RecipientBalancePosition.end)
                            balanceWidget,
                          if (!widget.isStatusActive && widget.shareVisibility)
                            shareWidget,
                        ],
                      ),
                    ],
                  ),
                ),
                if (widget.suffixVisibility) suffixButton,
              ],
            ),
          ),
        ),
      );

  Widget get suffixButton =>
      (widget.suffixIcon is IconData || widget.suffixIcon == null)
          ? Icon(
              widget.suffixIcon ?? Icons.keyboard_arrow_right_rounded,
              color: widget.suffixColor ?? VCProductColors.instance.iconColor,
            )
          : Icon(
              widget.suffixIcon,
            );

  Widget get balanceWidget => Padding(
        padding: EdgeInsets.only(right: context.semiLowValue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            VCProductText(
              text: widget.balanceTitleText ?? "Transfer Amount",
              type:
                  widget.balanceTitleTypographyType ?? TypographyType.smallText,
              textColor: widget.isSelected
                  ? widget.selectedColor
                  : (widget.balanceTitleTextColor ??
                          VCProductColors.instance.black)
                      .withOpacity(widget.isInactive ? 0.6 : 0.8),
              fontWeight: widget.balanceTitleFontWeight,
              fontSize: widget.balanceTitleFontSize,
            ),
            VCProductText(
              text: widget.balanceText ?? "\$4,500.00",
              type: widget.balanceTypographyType ??
                  TypographyType.placeholderAmount,
              textColor: widget.isSelected
                  ? widget.selectedColor
                  : widget.balanceTextColor,
              fontWeight: widget.balanceFontWeight,
              fontSize: widget.balanceFontSize,
            ),
          ],
        ),
      );

  Widget get shareWidget => InkWell(
        onTap: () {
          debugPrint("Share Active");
        },
        child: Padding(
          padding: EdgeInsets.only(top: context.semiLowValue),
          child: Row(
            children: [
              Icon(
                Icons.link,
                size: (widget.shareFontSize ??
                        (widget.shareTypographyType ??
                                TypographyType.bodyMedium14)
                            .fontSize ??
                        14) *
                    1.2,
                color: widget.isSelected
                    ? widget.selectedColor
                    : (widget.shareTextColor ??
                        VCProductColors.instance.iconColor),
              ),
              SizedBox(width: context.semiLowValue),
              VCProductText(
                text: widget.shareText ?? "Share Link",
                type: widget.shareTypographyType ?? TypographyType.bodyMedium14,
                textColor: widget.isSelected
                    ? widget.selectedColor
                    : (widget.shareTextColor ??
                        VCProductColors.instance.iconColor),
                fontWeight: widget.shareFontWeight ??
                    TypographyType.btnSmall.fontWeight,
                fontSize:
                    widget.shareFontSize ?? TypographyType.btnSmall.fontSize,
              ),
            ],
          ),
        ),
      );

  Widget get statusCard => Container(
        padding: EdgeInsets.symmetric(
            horizontal: context.lowValue, vertical: context.semiLowValue),
        decoration: BoxDecoration(
          color: widget.statusType.backgroundColor ??
              VCProductColors.instance.orange5,
          borderRadius: context.lowBorderRadius,
        ),
        child: VCProductText(
          text: widget.statusText?.toUpperCase() ??
              widget.statusType.name.toUpperCase(),
          type: widget.statusTypographyType ?? TypographyType.bodyRegular14,
          textColor: widget.statusTextColor,
          fontWeight: widget.statusFontWeight,
          fontSize: widget.statusFontSize ?? 11,
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
                text: widget.nameText ?? "Recipient Name",
                textAlign: TextAlign.start,
                maxLines: 1,
                type: widget.nameTypographyType ?? TypographyType.bodyRegular14,
                textColor: widget.isSelected
                    ? widget.selectedColor
                    : (widget.nameTextColor ?? VCProductColors.instance.black)
                        .withOpacity(widget.isInactive ? 0.6 : 1),
                fontWeight: widget.nameFontWeight,
                fontSize: widget.nameFontSize,
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
              if (widget.balanceVisibility &&
                  widget.balancePosition == RecipientBalancePosition.subTitle)
                Row(
                  children: [
                    VCProductText(
                      text: widget.balanceTitleText ?? "Amount: ",
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      type: widget.balanceTitleTypographyType ??
                          TypographyType.smallText,
                      textColor: widget.isSelected
                          ? widget.selectedColor.withOpacity(0.8)
                          : (widget.balanceTitleTextColor ??
                                  VCProductColors.instance.black)
                              .withOpacity(widget.isInactive ? 0.6 : 0.8),
                      fontWeight: widget.balanceTitleFontWeight,
                      fontSize: widget.balanceTitleFontSize,
                    ),
                    Expanded(
                      child: VCProductText(
                        text: widget.balanceText ?? "\$5,000.00",
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        type: widget.balanceTypographyType ??
                            TypographyType.placeholderAmount,
                        textColor: widget.isSelected
                            ? widget.selectedColor
                            : (widget.balanceTextColor ??
                                    VCProductColors.instance.black)
                                .withOpacity(widget.isInactive ? 0.6 : 1),
                        fontWeight: widget.balanceFontWeight,
                        fontSize: widget.balanceFontSize ?? 12,
                      ),
                    ),
                  ],
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
            child: widget.isSelectable
                ? checkbox
                : widget.leadingIcon ??
                    VCProductComponents.text(
                        text: getShortName(widget.nameText),
                        fontSize: 15,
                        fontWeight: VCFontWeights.medium),
          )),
        ),
      );

  Container get checkbox => Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.isInactive
                ? (widget.isSelected
                        ? VCProductColors.instance.activeTileColor
                        : VCProductColors.instance.strokeGray)
                    .withOpacity(0.6)
                : (widget.isSelected
                    ? VCProductColors.instance.activeTileColor
                    : VCProductColors.instance.strokeGray),
          ),
          borderRadius: BorderRadius.circular(4.0),
          color: widget.isInactive
              ? (widget.isSelected
                      ? (VCProductColors.instance.activeTileColor)
                      : VCProductColors.instance.white)
                  .withOpacity(0.6)
              : (widget.isSelected
                  ? (VCProductColors.instance.activeTileColor)
                  : VCProductColors.instance.white),
        ),
        child: widget.isSelected
            ? Container(
                margin: const EdgeInsets.all(5.0),
                child: VCIcons.ic_check_white,
              )
            : null,
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
