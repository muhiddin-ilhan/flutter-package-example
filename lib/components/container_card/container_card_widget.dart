import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class ContainerCardWidget extends StatelessWidget {
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Border? border;

  final Widget child;

  const ContainerCardWidget({
    super.key,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? context.paddingNormal,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? VCProductColors.instance.white,
        borderRadius: borderRadius ?? context.lowBorderRadius,
        border: border ??
            Border.all(
              width: 1,
              color: VCProductColors.instance.grey,
            ),
      ),
      child: child,
    );
  }
}
