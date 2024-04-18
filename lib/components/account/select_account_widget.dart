import 'package:flutter/material.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/components/base/base_component.dart';
import 'package:vc_product_widgets/components/dashed_border/dashed_border.dart';
import 'package:vc_product_widgets/components/dashed_vertical_line/dashed_vertical_line.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';
import 'package:vc_product_widgets/components/text/vc_product_text.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

class SelectAccountWidget extends BaseComponent {
  final bool isVisibleSecond;

  final Future<dynamic> Function() onClickFirst;
  final Future<dynamic> Function()? onClickSecond;

  final String firstText;
  final String? secondText;

  final Widget? firstWidget;
  final Widget? secondWidget;

  final Widget? firstIcon;
  final Widget? secondIcon;
  final bool isIconTopPadding;

  final String? firstErrorText;
  final String? secondErrorText;

  final bool isVisibleActionButton;
  final String? actionButtonText;
  final Function()? actionButtonOnTap;

  final IconData? defaultFirstLeadingIcon;
  final IconData? defaultSecondLeadingIcon;

  const SelectAccountWidget({
    super.key,
    required this.onClickFirst,
    this.onClickSecond,
    required this.firstText,
    this.secondText,
    this.firstWidget,
    this.secondWidget,
    this.firstIcon,
    this.secondIcon,
    this.firstErrorText,
    this.secondErrorText,
    this.isVisibleSecond = true,
    this.isIconTopPadding = true,
    this.isVisibleActionButton = false,
    this.actionButtonText,
    this.actionButtonOnTap,
    this.defaultFirstLeadingIcon,
    this.defaultSecondLeadingIcon,
    super.id,
    super.id1,
    super.showError,
    super.showError1,
    super.checkOthers,
    super.willValidate,
  });

  @override
  State<SelectAccountWidget> createState() => _SelectAccountWidgetState();
}

class _SelectAccountWidgetState extends State<SelectAccountWidget> {
  Color blue = const Color(0xFF316CE2);
  String? validatorErrorMessage;
  String? validatorErrorMessage1;

  @override
  Widget build(BuildContext context) {
    return ValidatorBuilder(builder: (_) {
      if (widget.id != null && widget.showError) {
        validatorErrorMessage = ValidatorService.getErrorMessage(widget.id!);
      }
      if (widget.id1 != null && widget.showError1) {
        validatorErrorMessage1 = ValidatorService.getErrorMessage(widget.id1!);
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            elevation: 0,
            child: GestureDetector(
              onTap: () async {
                dynamic result = await widget.onClickFirst();
                if (widget.id != null &&
                    result != null &&
                    widget.willValidate) {
                  ValidatorService.validate(
                    componentId: widget.id!,
                    value: result,
                    showError: widget.showError,
                    checkOthers: widget.checkOthers,
                  );
                }
              },
              child: Row(
                crossAxisAlignment: widget.firstWidget != null
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.firstIcon != null
                      ? leadingIcon(widget.firstIcon!)
                      : leadingWidget(validatorErrorMessage != null,
                          icon: widget.defaultFirstLeadingIcon),
                  context.emptySizedWidthBoxNormal,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.firstWidget ??
                            textWidget(widget.firstText,
                                validatorErrorMessage != null),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (validatorErrorMessage != null)
            errorWidget(validatorErrorMessage!),
          if (widget.isVisibleSecond) ...[
            dashedLine,
            Material(
              color: VCProductColors.instance.transparent,
              elevation: 0,
              child: InkWell(
                onTap: () async {
                  if (widget.onClickSecond != null) {
                    dynamic result = await widget.onClickSecond!();
                    if (widget.id1 != null && result != null) {
                      ValidatorService.validate(
                        componentId: widget.id1!,
                        value: result,
                        showError: widget.showError,
                        checkOthers: widget.checkOthers,
                      );
                    }
                  }
                },
                borderRadius: context.lowBorderRadius,
                child: Row(
                  crossAxisAlignment: widget.secondWidget != null
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.secondIcon != null
                        ? leadingIcon(widget.secondIcon!)
                        : leadingWidget(validatorErrorMessage1 != null,
                            icon: widget.defaultSecondLeadingIcon),
                    context.emptySizedWidthBoxNormal,
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: widget.secondWidget ??
                            textWidget(widget.secondText ?? "",
                                validatorErrorMessage1 != null),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (validatorErrorMessage1 != null)
              errorWidget(validatorErrorMessage1!),
          ],
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
    });
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

  Widget get dashedLine {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.screenWidth10 * 0.36,
        widget.firstIcon != null ? 0 : context.lowValue,
        0,
        widget.secondIcon != null ? 0 : context.lowValue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomPaint(
            painter: DashedLineVerticalPainter(),
            size: Size(1, context.normalValue),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 1),
            child: Icon(
              Icons.arrow_downward_outlined,
              size: 12,
            ),
          ),
        ],
      ),
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
