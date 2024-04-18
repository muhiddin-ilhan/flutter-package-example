import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/base/base_component.dart';
import 'package:vc_product_widgets/components/buttons/box_button/vc_box_button.dart';
import 'package:vc_product_widgets/components/text/vc_font_weight.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class VCReceipentContainer extends BaseComponent {
  final bool isActive;
  final bool hasTag;
  final String? title;
  final String? description;
  final String? tagText;
  final Color? suffixIconBackgroundColor;
  final Color? tagColor;
  final bool? hasAmountInfo;
  final String? amountText;
  final String? amountTitleText;
  final Widget? amountWidget;
  final Widget? bottomWidget;
  final bool hasSuffixIcon;
  final Widget? suffixIcon;
  final bool? hasBottomWidget;
  final Widget? tagWidget;
  final List<VCProductBoxButton>? bottomButtonsList;

  const VCReceipentContainer({
    Key? key,
    this.isActive = true,
    this.hasTag = false,
    this.title,
    this.description,
    this.tagText,
    this.suffixIconBackgroundColor,
    this.tagColor,
    this.hasAmountInfo,
    this.amountText,
    this.amountTitleText,
    this.amountWidget,
    this.bottomWidget,
    this.hasSuffixIcon = false,
    this.suffixIcon,
    this.hasBottomWidget,
    this.tagWidget,
    this.bottomButtonsList,
  }) : super(key: key);

  @override
  State<VCReceipentContainer> createState() => VCReceipentContainerState();
}

class VCReceipentContainerState<T extends VCReceipentContainer>
    extends State<T> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingNormal,
      decoration: BoxDecoration(
        color: VCProductColors.instance.white,
        borderRadius: context.normalBorderRadius * 0.5,
        boxShadow: [
          BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              color: VCProductColors.instance.black.withOpacity(0.05)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color: widget.isActive
                        ? VCProductColors.instance.activeTileColor
                        : VCProductColors.instance.labelColor,
                    borderRadius: BorderRadius.circular(context.highValue),
                  ),
                ),
                context.emptySizedWidthBoxLow,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //title
                      VCProductText(
                        text: widget.title ?? "",
                        type: TypographyType.allCapsXLarge,
                      ),

                      context.emptySizedHeightBox4px,
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VCProductText(
                                text: widget.description ?? "",
                                type: TypographyType.smallText,
                              ),
                              context.emptySizedHeightBox8px,
                              if (widget.hasTag)
                                widget.tagWidget ?? tagWidget(context),
                            ],
                          ),
                          //suffix icon
                          if (widget.hasSuffixIcon) suffixIcon(context),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          //amount widget
          if (widget.hasAmountInfo ?? false) ...[
            context.emptySizedHeightBox8px,
            widget.amountWidget ?? _getAmountInfo(context)
          ],

          if (widget.hasBottomWidget ?? false) ...[
            context.emptySizedHeightBox8px,
            Divider(
              indent: 0,
              endIndent: 0,
              color: VCProductColors.instance.black.withOpacity(0.075),
            ),
            widget.bottomWidget ?? _bottomWidget(context),
          ]
          //divider
          //bottom widget
        ],
      ),
    );
  }

  _getAmountInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        VCProductText(
          text: widget.amountTitleText ?? "",
          type: TypographyType.smallText,
        ),
        VCProductText(
          text: widget.amountText ?? "",
          type: TypographyType.bodyBlackBold22,
        ),
      ],
    );
  }

  _bottomWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.lowValue),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.bottomButtonsList ?? [],
      ),
    );
  }

  tagWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: widget.tagColor ??
            (widget.isActive
                ? VCProductColors.instance.tagNeon30
                : VCProductColors.instance.disabledWidgetBackgroundColor),
        borderRadius: context.radiusSmall,
      ),
      child: VCProductText(
        text: widget.tagText ?? "",
        type: TypographyType.smallText,
      ),
    );
  }

  verticalDivider(BuildContext context) {
    return Container(
      height: 75,
      width: 4,
      decoration: BoxDecoration(
        color: widget.isActive
            ? VCProductColors.instance.activeTileColor
            : VCProductColors.instance.labelColor,
        borderRadius: BorderRadius.circular(context.highValue),
      ),
    );
  }

  suffixIcon(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      padding: context.paddingMini,
      decoration: BoxDecoration(
        color: widget.suffixIconBackgroundColor ??
            VCProductColors.instance.bottomSheetBGColor,
        borderRadius: BorderRadius.circular(context.lowValue),
      ),
      child: FittedBox(
          child: Padding(
        padding: context.paddingLow,
        child: widget.suffixIcon ??
            VCProductComponents.text(
                text: getShortName(widget.title),
                fontSize: 15,
                fontWeight: VCFontWeights.medium),
      )),
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
