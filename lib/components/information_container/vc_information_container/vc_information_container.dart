import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/information_container/vc_information_item/vc_information_item.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

enum HeaderDisplayTypeEnumCustom { center, left }

class VCInformationContainer extends StatefulWidget {
  final List<VCInformationItem> informationItemList;
  final Widget seperatorWidget;
  final String? headerText;
  final TextStyle headerTextStyle;
  final EdgeInsets headerTextPadding;
  final HeaderDisplayTypeEnumCustom headerDisplayTypeEnum;
  final BoxDecoration containerDecoration;
  final EdgeInsets containerPadding;
  final EdgeInsets contentPadding;
  final EdgeInsets containerMargin;
  final Widget? summaryWidget;
  final bool isLastResultField;
  final Color? summaryWidgetDividerColor;

  const VCInformationContainer({
    super.key,
    required this.informationItemList,
    this.headerText,
    this.summaryWidgetDividerColor,
    this.headerDisplayTypeEnum = HeaderDisplayTypeEnumCustom.left,
    this.containerDecoration = const BoxDecoration(),
    this.containerPadding = EdgeInsets.zero,
    this.contentPadding = EdgeInsets.zero,
    this.containerMargin = EdgeInsets.zero,
    this.seperatorWidget = const SizedBox.shrink(),
    this.headerTextPadding = const EdgeInsets.symmetric(
      vertical: 6,
    ),
    this.headerTextStyle = const TextStyle(),
    this.summaryWidget,
    this.isLastResultField = false,
  });

  @override
  State<VCInformationContainer> createState() => _VCInformationContainerState();
}

class _VCInformationContainerState extends State<VCInformationContainer> {
  @override
  Widget build(BuildContext context) {
    return headerTextWidget(
      child: Container(
          padding: widget.containerPadding,
          margin: widget.containerMargin,
          decoration: BoxDecoration(
            backgroundBlendMode: widget.containerDecoration.backgroundBlendMode,
            border: widget.containerDecoration.border,
            borderRadius: widget.containerDecoration.borderRadius,
            boxShadow: widget.containerDecoration.boxShadow,
            color: widget.containerDecoration.color,
            gradient: widget.containerDecoration.gradient,
            image: widget.containerDecoration.image,
            shape: widget.containerDecoration.shape,
          ),
          child: Column(
            children: [
              VCProductComponents.listView<VCInformationItem>(
                shrinkWrap: true,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                onSeperatorBuilder: (index) => widget.seperatorWidget,
                onItemBuilder: (index, item) {
                  if (widget.summaryWidget != null &&
                      index == widget.informationItemList.length - 1) {
                    return Column(
                      children: [
                        Padding(
                          padding: widget.contentPadding,
                          child: Divider(
                            color: widget.summaryWidgetDividerColor ?? VCProductColors.instance.grey,
                          ),
                        ),
                        Padding(
                          padding: widget.contentPadding,
                          child: widget.summaryWidget!,
                        ),
                      ],
                    );
                  } else {
                    return Padding(
                      padding: widget.contentPadding,
                      child: item,
                    );
                  }
                },
                dataList: widget.isLastResultField
                    ? widget.informationItemList
                        .sublist(0, widget.informationItemList.length - 1)
                    : widget.informationItemList,
              ),
              if (widget.isLastResultField) ...[
                widget.seperatorWidget,
                Divider(
                  color: VCProductColors.instance.backgroundGray,
                  height: 1,
                  endIndent: context.normalValue,
                  indent: context.normalValue,
                ),
                widget.seperatorWidget,
                widget.informationItemList.last
              ]
            ],
          )),
    );
  }

  Widget headerTextWidget({required Widget child}) {
    if (widget.headerText != null && widget.headerText?.isNotEmpty == true) {
      return Column(
        crossAxisAlignment:
            widget.headerDisplayTypeEnum == HeaderDisplayTypeEnumCustom.left
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
        children: [
          Padding(
            padding: widget.containerMargin,
            child: Padding(
              padding: widget.headerTextPadding,
              child: Text(
                widget.headerText!.toUpperCase(),
                style: textStyles,
              ),
            ),
          ),
          child,
        ],
      );
    } else {
      return child;
    }
  }

  TextStyle get textStyles {
    return TextStyle(
      fontSize: widget.headerTextStyle.fontSize ?? 12,
      fontWeight: widget.headerTextStyle.fontWeight ?? FontWeight.w500,
      background: widget.headerTextStyle.background,
      backgroundColor: widget.headerTextStyle.backgroundColor,
      color: widget.headerTextStyle.color,
      debugLabel: widget.headerTextStyle.debugLabel,
      decoration: widget.headerTextStyle.decoration,
      inherit: widget.headerTextStyle.inherit,
      fontStyle: widget.headerTextStyle.fontStyle,
      letterSpacing: widget.headerTextStyle.letterSpacing ?? 1.12,
      wordSpacing: widget.headerTextStyle.wordSpacing,
      textBaseline: widget.headerTextStyle.textBaseline,
      height: widget.headerTextStyle.height,
      leadingDistribution: widget.headerTextStyle.leadingDistribution,
      locale: widget.headerTextStyle.locale,
      foreground: widget.headerTextStyle.foreground,
      shadows: widget.headerTextStyle.shadows,
      fontFeatures: widget.headerTextStyle.fontFeatures,
      fontVariations: widget.headerTextStyle.fontVariations,
      decorationColor: widget.headerTextStyle.decorationColor,
      decorationStyle: widget.headerTextStyle.decorationStyle,
      decorationThickness: widget.headerTextStyle.decorationThickness,
      fontFamily: widget.headerTextStyle.fontFamily,
      fontFamilyFallback: widget.headerTextStyle.fontFamilyFallback,
      overflow: widget.headerTextStyle.overflow,
    );
  }
}
