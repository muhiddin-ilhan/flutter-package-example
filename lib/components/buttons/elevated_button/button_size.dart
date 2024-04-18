import 'package:flutter/material.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

enum ButtonSize { large, medium, small, forShowDialog }

class ButtonSizeLabel {
  ButtonSizeLabel();
  size(buttonSize, BuildContext context) {
    switch (buttonSize) {
      case ButtonSize.large:
        return Size(context.screenWidth100, context.screenHeight05);
      case ButtonSize.medium:
        return Size(context.screenWidth70, context.screenHeight05);
      case ButtonSize.small:
        return Size(context.screenWidth40, context.screenHeight05);
      case ButtonSize.forShowDialog:
        return Size(context.screenWidth30, context.screenHeight04);

      default:
        return Size(context.screenWidth60, context.screenHeight05);
    }
  }
}
