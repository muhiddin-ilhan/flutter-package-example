import 'package:flutter/material.dart';

class VCNumPadButton extends StatelessWidget {
  /// Represents a numeric button with a specified [number].
  final String number;

  /// Callback function to be executed when the button is tapped.
  final VoidCallback onTap;

  /// The highlight color of the button when pressed. default [Color(0xFFC9C9C9)]
  /// If not provided, a default highlight color will be used.
  final Color? highlightColor;

  /// The background color of the button. default [Colors.white]
  /// If not provided, a default background color will be used.
  final Color? backgroundColor;

  /// The text style for the displayed number on the button. default [TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.w700,)]
  /// If not provided, a default text style will be used.
  final TextStyle? numberStyle;

  /// The radius of the button's corners.
  /// If not provided, a default shape [CircleBorder()] will be used.
  final double? radius;

  /// The optional icon to be displayed along with the number on the button.
  final IconData? icon;

  const VCNumPadButton({
    Key? key,
    required this.number,
    required this.onTap,
    this.highlightColor,
    this.backgroundColor,
    this.numberStyle,
    this.radius,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.white,
      shape: radius==null? const CircleBorder() :RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius ?? 50),
        onTap: onTap,
        hoverColor: highlightColor ?? const Color(0xFFC9C9C9),
        child: Container(
          alignment: Alignment.center,
          width: 68,
          height: 68,
          child: icon == null
              ? Text(
                  number,
                  style: numberStyle ??
                      const TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                )
              : Icon(icon ,size: 26),
        ),
      ),
    );
  }
}
