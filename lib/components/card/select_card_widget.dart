import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/base/base_component.dart';
import 'package:vc_product_widgets/components/dashed_border/dashed_border.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';
import 'package:vc_product_widgets/components/text/vc_product_text.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

class SelectCardWidget extends BaseComponent {
  final Function() onClickFirst;

  final String firstText;

  final Widget? firstWidget;

  final Widget? firstIcon;
  final bool isIconTopPadding;

  final String? firstErrorText;

  final bool isVisibleActionButton;
  final String? actionButtonText;
  final Function()? actionButtonOnTap;

  final IconData? defaultFirstLeadingIcon;

  const SelectCardWidget({
    super.key,
    required this.onClickFirst,
    required this.firstText,
    this.firstWidget,
    this.firstIcon,
    this.firstErrorText,
    this.isIconTopPadding = true,
    this.isVisibleActionButton = false,
    this.actionButtonText,
    this.actionButtonOnTap,
    this.defaultFirstLeadingIcon,
    super.id,
    super.id1,
    super.showError,
    super.showError1,
    super.checkOthers,
    super.willValidate,
  });

  @override
  State<SelectCardWidget> createState() => _SelectCardWidgetState();
}

class _SelectCardWidgetState extends State<SelectCardWidget> {
  Color blue = const Color(0xFF316CE2);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              widget.onClickFirst();
            },
            borderRadius: context.lowBorderRadius,
            child: Row(
              crossAxisAlignment: widget.firstWidget != null
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widget.firstIcon != null
                    ? leadingIcon(widget.firstIcon!)
                    : leadingWidget(widget.firstErrorText != null,
                        icon: widget.defaultFirstLeadingIcon),
                context.emptySizedWidthBoxNormal,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.firstWidget ??
                          textWidget(
                              widget.firstText, widget.firstErrorText != null),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.firstErrorText != null) errorWidget(widget.firstErrorText!),
        if (widget.isVisibleActionButton) ...[
          Divider(color: VCProductColors.instance.black.withOpacity(0.05)),
          InkWell(
            onTap: () {
              if (widget.actionButtonOnTap != null) {
                widget.actionButtonOnTap!();
              }
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: VCProductText(
                textAlign: TextAlign.right,
                text: widget.actionButtonText ?? "Add New",
                type: TypographyType.bodyRegular14,
                textColor: VCProductColors.instance.popupInfoIconColor,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Row errorWidget(String text) {
    return Row(
      children: [
        SizedBox(width: context.largeValue),
        Icon(
          Icons.warning_amber_outlined,
          size: 12 * 1.2,
          color: VCProductColors.instance.red,
        ),
        SizedBox(width: context.semiLowValue),
        Expanded(
          child: VCProductText(
            text: text,
            maxLines: 1,
            textAlign: TextAlign.start,
            type: TypographyType.validation,
            textColor: VCProductColors.instance.red,
          ),
        ),
      ],
    );
  }

  Widget leadingIcon(Widget icon) => Padding(
        padding: EdgeInsets.only(
            top: widget.isIconTopPadding ? context.lowValue : 0),
        child: Container(
          height: context.screenWidth10,
          width: context.screenWidth10,
          padding: context.paddingLow,
          decoration: BoxDecoration(
            color: blue.withOpacity(0.15),
            borderRadius: context.highBorderRadius,
          ),
          child: Opacity(
            opacity: 1,
            child: FittedBox(
              child: icon,
            ),
          ),
        ),
      );

  Widget leadingWidget(bool hasError, {IconData? icon}) {
    return Container(
      height: context.screenWidth10,
      width: context.screenWidth10,
      decoration: BoxDecoration(
        color: hasError
            ? VCProductColors.instance.red.withOpacity(0.15)
            : blue.withOpacity(0.15),
        borderRadius: context.highBorderRadius,
      ),
      child: CustomPaint(
        size: Size(context.screenWidth10, context.screenWidth10),
        foregroundPainter: DashedBorder(
            completeColor: hasError ? VCProductColors.instance.red : blue,
            width: 2),
        child: Padding(
          padding: context.paddingLow,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Icon(
              icon ?? Icons.add,
              color: hasError ? VCProductColors.instance.red : blue,
              size: context.highValue,
            ),
          ),
        ),
      ),
    );
  }

  Widget textWidget(String text, bool hasError) {
    return VCProductText(
      text: text,
      maxLines: 1,
      textColor: hasError ? VCProductColors.instance.red : blue,
      type: TypographyType.bodyRegular14,
    );
  }
}
