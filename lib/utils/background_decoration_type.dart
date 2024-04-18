import 'package:flutter/material.dart';

import 'color_constant.dart';

enum BackgroundDecorationType {
  gradient,
  blank,
  custom;
}

extension BackgroundDecorationTypeExtension on BackgroundDecorationType {
  BoxDecoration? get boxDecoration {
    switch (this) {
      case BackgroundDecorationType.gradient:
        return BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                VCProductColors.instance.backgroundGradientStart,
                VCProductColors.instance.backgroundGradientEnd,
              ],
            ));
      default:
        return null;
    }
  }
}