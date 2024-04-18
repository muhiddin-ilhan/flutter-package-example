import 'package:flutter/material.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

extension DecorationExtension on BuildContext {
 
  Color get whiteContainerColor => VCProductColors.instance.white;



  BoxDecoration get whiteContainerDecoration => BoxDecoration(
        color: whiteContainerColor,
        borderRadius: BorderRadius.circular(radius8),
      );
      
    
  BoxDecoration get whiteContainerDecorationWithBorder => BoxDecoration(
        color: whiteContainerColor,
        borderRadius: BorderRadius.circular(radius8),
        border: Border.all(color: VCProductColors.instance.widgetBorderColor, width: 1),
      );
}
