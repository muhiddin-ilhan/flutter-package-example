import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';

class VCProductText extends StatelessWidget {
  /// The typography style type (e.g., mainTitle, h1Title, etc.).

  final TypographyType? type;

  /// The text content to display.

  final String text;

  /// The text alignment (optional, defaults to center).

  final TextAlign? textAlign;

  /// The text color (optional).

  final Color? textColor;

  /// The maximum number of lines for text (optional).

  final int? maxLines;

  final TextDecoration? decoration;

  final double? fontSize;

  final FontWeight? fontWeight;

  final Color? decorationColor;


  const VCProductText({
    super.key,
    this.type,
    required this.text,
    this.textAlign = TextAlign.center,
    this.textColor,
    this.maxLines,
    this.decoration,
    this.fontSize,
    this.fontWeight,
    this.decorationColor,
  });

  @override
  Widget build(BuildContext context) {
    String fontFamily = 'packages/vc_products_widgets/Manrope';

    return Text(type?.allCaps != null ? text.toUpperCase() : text,
        maxLines: maxLines,
        textAlign: textAlign,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize ?? type?.fontSize ?? 20,
          decoration: decoration,
          decorationColor : decorationColor,
          fontWeight: fontWeight ?? type?.fontWeight ?? FontWeight.w800,
          color: textColor ?? VCProductColors.instance.textColor,
        ));
  }
}
