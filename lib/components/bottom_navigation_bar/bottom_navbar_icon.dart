// ignore_for_file: must_be_immutable

library bottom_sheet_expandable_bar;

import 'package:flutter/material.dart';

import '../../utils/color_constant.dart';
import '../text/typography_type.dart';
import '../vc_product_components.dart';

/// Class to generate the icons widget for bottom bar
class BottomSheetBarIcon extends StatelessWidget {
  /// Icon color, when is not active appers with opacity
  final Color? color;

  /// Icon to show within the widget
  final Widget icon;

  /// Function trigger when pressed the icon
  Function()? onTap;

  /// Boolean value to indicate when an icon is active
  bool? isActive;

  final String? menuName;

  String? url;

  String? additionalMenuName;

  bool? hasDescription;

  /// icon: Icon color, when is not active appers with opacity
  /// color: Icon to show within the widget
  /// onTap: Function trigger when pressed the icon
  BottomSheetBarIcon(
      {Key? key,
      required this.icon,
      this.onTap,
      this.color = Colors.black,
      this.isActive = false,
      this.menuName,
      this.url,
      this.additionalMenuName,
      this.hasDescription = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: icon,
              ),
              Expanded(
                  child: VCProductComponents.text(
                maxLines: 2,
                text: menuName?.toUpperCase() ?? "",
                textColor: VCProductColors.instance.black,
                typographyType: TypographyType.allCapsSmall,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
