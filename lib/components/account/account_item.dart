import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/checkbox/vc_product_checkbox.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';
import 'package:vc_product_widgets/components/text/vc_product_text.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

import '../switch/vc_product_switch.dart';

enum AccountItemType { type1, type2 }

enum AccountTitleType { from, to, none }

class AccountItem extends StatefulWidget {
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
  final bool isSubtitlePrefixVisible;
  final Color? subtitlePrefixWidgetColor;
  final Widget? subtitlePrefixIcon;

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
  final TypographyType? shareTypographyType;
  final Color? shareTextColor;
  final double? shareFontSize;
  final FontWeight? shareFontWeight;
  final bool shareVisibility;

  // cardType TextStyles Configrations
  final String? cardTypeText;
  final TypographyType? cardTypeTypographyType;
  final Color? cardTypeTextColor;
  final double? cardTypeFontSize;
  final FontWeight? cardTypeFontWeight;
  final bool cardTypeVisibility;

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
  final ValueChanged<bool>? onChangeSwitch;
  //for multiSelect
  final Function(bool? isSelect)? onSelect;

  final AccountItemType type;
  final AccountTitleType titleType;
  final bool suffixDownButtonVisibility;
  final bool suffixRightButtonVisibility;
  final bool switchVisibility;
  final bool switchValue;
  final bool isSwitchDisabled;
  final bool isMultiSelect;

  const AccountItem(
      {super.key,
      this.isSwitchDisabled = false,
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
      this.shareTypographyType,
      this.shareTextColor,
      this.shareFontSize,
      this.shareFontWeight,
      this.leadingIconColor,
      this.leadingIconHeight,
      this.leadingIcon,
      this.cardTypeTypographyType,
      this.cardTypeTextColor,
      this.cardTypeFontSize,
      this.cardTypeFontWeight,
      this.isInactive = false,
      this.containerBackgroundColor,
      this.containerBorderRadius,
      this.isWrapContainer = false,
      this.shareVisibility = false,
      this.cardTypeText,
      this.cardTypeVisibility = false,
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
      this.type = AccountItemType.type1,
      this.titleType = AccountTitleType.none,
      this.suffixDownButtonVisibility = false,
      this.suffixRightButtonVisibility = false,
      this.switchVisibility = false,
      this.leadingIconVisibility = true,
      this.isSubtitlePrefixVisible = false,
      this.subtitlePrefixWidgetColor,
      this.isMultiSelect = false,
      this.onSelect,
      this.switchValue = false,
      this.subtitlePrefixIcon,
      this.onChangeSwitch});

  @override
  State<AccountItem> createState() => _AccountItemState();
}

class _AccountItemState extends State<AccountItem> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

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

  Widget get body => widget.isMultiSelect
      ? Padding(
          padding: widget.widgetPadding ?? context.paddingNormal,
          child: VCProductCheckBox(
            isChecked: _isSelected,
            onChanged: (value) {
              widget.onSelect?.call(value);
              setState(() {
                _isSelected = value ?? false;
              });
            },
            widget: Padding(
                padding: context.onlyLeftPaddingNormal, child: bodyContainer),
          ))
      : InkWell(
          borderRadius: widget.containerBorderRadius ?? context.lowBorderRadius,
          onTap: widget.onTap,
          child: Padding(
            padding: widget.widgetPadding ?? context.paddingNormal,
            child: bodyContainer,
          ),
        );

  Widget get bodyContainer => Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment:
                      widget.isInactive && !widget.cardTypeVisibility
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                  children: [
                    if (widget.leadingIconVisibility) leadingIcon,
                    if (widget.leadingIconVisibility)
                      context.emptySizedWidthBoxLow,
                    titleAndSubTitle,
                    context.emptySizedHeightBoxLow,
                    if (widget.isInactive &&
                        !widget.cardTypeVisibility &&
                        !widget.switchVisibility)
                      inactiveCard,
                    if (!widget.cardTypeVisibility && widget.switchVisibility)
                      switchButton,
                    if (widget.cardTypeVisibility) cardType,
                    if (!widget.isInactive &&
                        !widget.cardTypeVisibility &&
                        widget.shareVisibility)
                      shareWidget,
                    if (!widget.isInactive &&
                        !widget.cardTypeVisibility &&
                        !widget.shareVisibility &&
                        widget.suffixDownButtonVisibility)
                      suffixDownButton,
                    if (!widget.suffixDownButtonVisibility &&
                        widget.suffixRightButtonVisibility)
                      suffixRightButton,
                  ],
                ),
                if (!widget.isInactive && widget.balanceVisibility)
                  balanceWidget,
                if (widget.isInactive &&
                    widget.cardTypeVisibility &&
                    !widget.switchVisibility)
                  inactiveCard,
                if (widget.cardTypeVisibility && widget.switchVisibility)
                  switchButton,
              ],
            ),
          ),
        ],
      );

  Widget get suffixDownButton => IconButton(
        onPressed: () {},
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
      );

  Widget get suffixRightButton => IconButton(
        padding: EdgeInsets.only(left: context.lowValue),
        constraints: const BoxConstraints(),
        style: const ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {},
        icon: Icon(
          Icons.keyboard_arrow_right_rounded,
          color: VCProductColors.instance.iconColor,
        ),
      );

  Widget get switchButton => VCProductSwitch(
        isSelected: widget.switchValue,
        onChanged: widget.onChangeSwitch,
        disabled: widget.isSwitchDisabled,
      );

  Widget get balanceWidget => Padding(
        padding: EdgeInsets.only(right: context.semiLowValue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            VCProductText(
              text: widget.balanceTitleText ?? "",
              type:
                  widget.balanceTitleTypographyType ?? TypographyType.smallText,
              textColor: widget.isSelected
                  ? widget.selectedColor
                  : widget.balanceTitleTextColor,
              fontWeight: widget.balanceTitleFontWeight,
              fontSize: widget.balanceTitleFontSize,
            ),
            VCProductText(
              text: widget.balanceText ?? "",
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
          // TODO: Share code
        },
        child: Padding(
          padding: EdgeInsets.only(top: context.semiLowValue),
          child: Row(
            children: [
              VCProductText(
                text: "Share",
                type: widget.shareTypographyType ?? TypographyType.bodyMedium14,
                textColor: widget.isSelected
                    ? widget.selectedColor
                    : (widget.shareTextColor ??
                        VCProductColors.instance.iconColor),
                fontWeight: widget.shareFontWeight,
                fontSize: widget.shareFontSize ?? 13,
              ),
              SizedBox(width: context.semiLowValue / 2),
              Icon(
                Icons.ios_share,
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
            ],
          ),
        ),
      );

  Widget get cardType => Padding(
        padding: EdgeInsets.only(top: context.semiLowValue),
        child: VCProductText(
          text: widget.cardTypeText ?? "",
          type: widget.cardTypeTypographyType ?? TypographyType.bodyMedium14,
          textColor: widget.isSelected
              ? widget.selectedColor
              : widget.cardTypeTextColor,
          fontWeight: widget.cardTypeFontWeight,
          fontSize: widget.cardTypeFontSize ?? 13,
        ),
      );

  Widget get inactiveCard => Container(
        padding: EdgeInsets.symmetric(
            horizontal: context.lowValue, vertical: context.semiLowValue),
        decoration: BoxDecoration(
          color: VCProductColors.instance.orange5,
          borderRadius: context.lowBorderRadius,
        ),
        child: VCProductText(
          text: "INACTIVE",
          type: widget.cardTypeTypographyType ?? TypographyType.bodyRegular14,
          textColor: widget.cardTypeTextColor,
          fontWeight: widget.cardTypeFontWeight,
          fontSize: widget.cardTypeFontSize ?? 11,
        ),
      );

  Widget get titleAndSubTitle => Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.semiLowValue / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (widget.titleType != AccountTitleType.none)
                    VCProductText(
                      text: widget.titleType == AccountTitleType.from
                          ? "From: "
                          : "To: ",
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      type: widget.titleTypographyType ??
                          TypographyType.bodyBold14,
                      textColor: widget.isSelected
                          ? widget.selectedColor
                          : (widget.titleTextColor ??
                                  VCProductColors.instance.black)
                              .withOpacity(widget.isInactive ? 0.6 : 1),
                      fontWeight: widget.titleFontWeight,
                      fontSize: widget.titleFontSize,
                    ),
                  Expanded(
                    child: VCProductText(
                      text: widget.titleText ?? "",
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      type: widget.titleTypographyType ??
                          TypographyType.bodyRegular14,
                      textColor: widget.isSelected
                          ? widget.selectedColor
                          : (widget.titleTextColor ??
                                  VCProductColors.instance.black)
                              .withOpacity(widget.isInactive ? 0.6 : 1),
                      fontWeight: widget.titleFontWeight,
                      fontSize: widget.titleFontSize,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (widget.isSubtitlePrefixVisible)
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.lowValue,
                          vertical: context.semiLowValue * 0.5),
                      margin: EdgeInsets.only(right: context.semiLowValue),
                      decoration: BoxDecoration(
                        color: widget.subtitlePrefixWidgetColor ??
                            VCProductColors.instance.yellowCardType,
                        borderRadius:
                            BorderRadius.circular(context.semiLowValue),
                      ),
                      child: Row(
                        children: [
                          widget.subtitlePrefixIcon ??
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                size: TypographyType.smallText.fontSize! * 1.2,
                              ),
                          context.emptySizedWidthBoxSemiLow,
                          VCProductText(
                            text: widget.cardTypeText ?? "",
                            type: TypographyType.smallText,
                            fontSize: TypographyType.smallText.fontSize! + 1,
                          ),
                        ],
                      ),
                    ),
                  VCProductText(
                    text: widget.subtitleText ?? "",
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    type: widget.subtitleTypographyType ??
                        TypographyType.smallText,
                    textColor: widget.isSelected
                        ? widget.selectedColor
                        : (widget.subtitleTextColor ??
                                VCProductColors.instance.black)
                            .withOpacity(widget.isInactive ? 0.6 : 1),
                    fontWeight: widget.subtitleFontWeight,
                    fontSize: widget.subtitleFontSize,
                  ),
                ],
              ),
              if (widget.type == AccountItemType.type2)
                Row(
                  children: [
                    VCProductText(
                      text: widget.balanceTitleText ?? "",
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
                        text: widget.balanceText ?? "",
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

  double get getLeadingIconHeight {
    if (widget.leadingIconHeight != null) {
      return widget.leadingIconHeight!;
    }

    double titleTextHeight = (widget.titleFontSize ??
            (widget.titleTypographyType ?? TypographyType.bodyRegular14)
                .fontSize ??
            14) *
        1.2;
    double subtitleTextHeight = (widget.subtitleFontSize ??
            (widget.subtitleTypographyType ?? TypographyType.smallText)
                .fontSize ??
            14) *
        1.2;
    double titleWidgetPaddings = 10;

    return titleTextHeight + subtitleTextHeight + titleWidgetPaddings;
  }

  Container get leadingIcon => Container(
        height: getLeadingIconHeight,
        padding: widget.titleType != AccountTitleType.none
            ? context.paddingLow
            : context.paddingMini,
        decoration: BoxDecoration(
          color: widget.leadingIconBackgroundColor ??
              (widget.titleType != AccountTitleType.none
                  ? VCProductColors.instance.lightBlue7
                  : VCProductColors.instance.bottomSheetBGColor),
          borderRadius: BorderRadius.circular(
              widget.titleType != AccountTitleType.none
                  ? getLeadingIconHeight
                  : context.lowValue),
        ),
        child: Opacity(
          opacity: widget.isInactive ? 0.6 : 1,
          child: FittedBox(
            child: _isSelected
                ? Icon(
                    Icons.done,
                    color: widget.selectedColor,
                  )
                : widget.leadingIcon ??
                    Icon(
                      Icons.wallet_outlined,
                      color: widget.leadingIconColor,
                    ),
          ),
        ),
      );
}
