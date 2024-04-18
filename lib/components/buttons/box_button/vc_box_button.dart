import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/base/base_component.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';
import 'package:vc_product_widgets/components/text/vc_product_text.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';


class VCProductBoxButton extends BaseComponent {
  final bool disabled;
  final bool isActive;
  final Function()? onTap;
  final Color? backgroundColor;
  final Color? disableBackgroundColor;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final IconData? iconData;
  final String? title;
  final Widget? iconWidget;

  const VCProductBoxButton({
    super.key,
    this.disabled = false,
    this.isActive = true,
    this.onTap,
    this.backgroundColor,
    this.disableBackgroundColor,
    this.borderRadius,
    this.width,
    this.height,
    this.padding,
    this.iconData,
    this.title,
    this.iconWidget,
    
  });

  @override
  State<VCProductBoxButton> createState() => _VCProductBoxButtonState();
}

class _VCProductBoxButtonState extends State<VCProductBoxButton> {

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (widget.disabled || !widget.isActive ) ? .5 : 1,
      child: GestureDetector(
        onTap: widget.disabled ? null : widget.onTap,
        child: Expanded(
          child: Column(
            children: [
              Container(
                height: widget.height ?? context.allWidth * .1,
                width: widget.width ?? context.allWidth * .1,
                padding: context.paddingLow,
                decoration: BoxDecoration(
                  color: VCProductColors.instance.bottomSheetBGColor,
                  borderRadius: widget.borderRadius ?? context.radiusSmall,
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: widget.iconWidget ?? Icon(widget.iconData, size: context.highValue, color: VCProductColors.instance.black),
                ),
              ),
              if(widget.title != null)
                ...[context.emptySizedHeightBoxSemiLow,
              VCProductText(
                text: widget.title!,
                type: TypographyType.btnTab,
              ),]
            ],
          ),
        ),
      ),
    );
  }

}
