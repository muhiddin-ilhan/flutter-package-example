import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

import '../../../utils/vc_icons.dart';

enum InformationItemType {
  iban,
  cvv,
  secure,
  editable,
  normal,
  check,
  status,
  widget
}

enum InformationItemStatusType { pending, completed, error }

extension InformationItemStatusTypeExtension on InformationItemStatusType {
  Color? get backgroundColor {
    switch (this) {
      case InformationItemStatusType.pending:
        return VCProductColors.instance.statusWarningColor;
      case InformationItemStatusType.completed:
        return VCProductColors.instance.statusActiveColor;
      case InformationItemStatusType.error:
        return VCProductColors.instance.statusErrorColor;
      default:
        return null;
    }
  }
}

class VCInformationItem extends StatefulWidget {
  final String text;
  final dynamic value;
  final InformationItemType itemType;
  final TextStyle textStyle;
  final TextStyle valueTextStyle;
  final EdgeInsets itemPadding;
  final Function()? onClick;
  final InformationItemStatusType statusType;

  const VCInformationItem(
      {super.key,
      required this.text,
      required this.value,
      this.itemType = InformationItemType.normal,
      this.textStyle = const TextStyle(),
      this.valueTextStyle = const TextStyle(),
      this.itemPadding = EdgeInsets.zero,
      this.onClick,
      this.statusType = InformationItemStatusType.completed});

  @override
  State<VCInformationItem> createState() => _VCInformationItemState();
}

class _VCInformationItemState extends State<VCInformationItem> {
  bool _isSecureValue = true;

  @override
  Widget build(BuildContext context) {
    var text = widget.text.trim();
    return Padding(
      padding: widget.itemPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: textStyles.copyWith(
                fontWeight: widget.textStyle.fontWeight ?? FontWeight.w400,
                fontSize: widget.textStyle.fontSize ?? 14,
              ),
            ),
          ),
          context.emptySizedWidthBoxLow,
          Expanded(
            flex: 1,
            child: widget.itemType == InformationItemType.widget
                ? widget.value
                : (widget.itemType != InformationItemType.status &&
                        widget.itemType != InformationItemType.check)
                    ? Text(
                        (widget.itemType == InformationItemType.cvv ||
                                    widget.itemType ==
                                        InformationItemType.secure) &&
                                _isSecureValue
                            ? widget.value.replaceAll(RegExp(r"."), "*")
                            : widget.value,
                        textAlign: TextAlign.right,
                        style: textStyles.copyWith(
                            fontWeight: widget.textStyle.fontWeight ??
                                (widget.itemType != InformationItemType.normal
                                    ? FontWeight.w500
                                    : FontWeight.w600),
                            color: widget.textStyle.color ??
                                (widget.itemType != InformationItemType.normal
                                    ? VCProductColors.instance.navyBlue4
                                    : widget.textStyle.color)),
                      )
                    : const SizedBox.shrink(),
          ),
          typeIcon,
        ],
      ),
    );
  }

  Widget get typeIcon {
    IconData icon;
    Function onClick = () {};

    switch (widget.itemType) {
      case InformationItemType.iban:
        icon = Icons.copy;
        onClick = () {
          Clipboard.setData(ClipboardData(text: widget.value));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Copied to clipboard")),
          );
        };
        break;
      case InformationItemType.cvv || InformationItemType.secure:
        icon = _isSecureValue
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined;
        onClick = () {
          setState(() {
            _isSecureValue = !_isSecureValue;
          });
        };
        break;
      case InformationItemType.editable:
        icon = Icons.edit;
        break;
      case InformationItemType.normal:
        return const SizedBox.shrink();
      case InformationItemType.status:
        return statusCard;
      case InformationItemType.check:
        return checkIcon;
      default:
        return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        onClick();
        if (widget.onClick != null) {
          widget.onClick!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Icon(icon, size: 15, color: VCProductColors.instance.navyBlue4),
      ),
    );
  }

  Widget get statusCard => Container(
        padding: EdgeInsets.symmetric(
            horizontal: context.lowValue, vertical: context.semiLowValue),
        decoration: BoxDecoration(
          color: widget.statusType.backgroundColor ??
              VCProductColors.instance.orange5,
          borderRadius: context.lowBorderRadius,
        ),
        child: Text(
          widget.value,
          textAlign: TextAlign.right,
          style: textStyles.copyWith(
              fontWeight: widget.textStyle.fontWeight ??
                  (widget.itemType != InformationItemType.normal
                      ? FontWeight.w500
                      : FontWeight.w600),
              color: widget.textStyle.color ?? widget.textStyle.color),
        ),
      );

  Widget get checkIcon => GestureDetector(
        onTap: widget.onClick ?? () {},
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: widget.value == true ? VCIcons.icCheck : VCIcons.icClose,
        ),
      );

  TextStyle get textStyles {
    return TextStyle(
      fontSize: widget.textStyle.fontSize ?? 14,
      fontWeight: widget.textStyle.fontWeight ?? FontWeight.w400,
      background: widget.textStyle.background,
      backgroundColor: widget.textStyle.backgroundColor,
      color: widget.textStyle.color,
      debugLabel: widget.textStyle.debugLabel,
      decoration: widget.textStyle.decoration,
      inherit: widget.textStyle.inherit,
      fontStyle: widget.textStyle.fontStyle,
      letterSpacing: widget.textStyle.letterSpacing,
      wordSpacing: widget.textStyle.wordSpacing,
      textBaseline: widget.textStyle.textBaseline,
      height: widget.textStyle.height,
      leadingDistribution: widget.textStyle.leadingDistribution,
      locale: widget.textStyle.locale,
      foreground: widget.textStyle.foreground,
      shadows: widget.textStyle.shadows,
      fontFeatures: widget.textStyle.fontFeatures,
      fontVariations: widget.textStyle.fontVariations,
      decorationColor: widget.textStyle.decorationColor,
      decorationStyle: widget.textStyle.decorationStyle,
      decorationThickness: widget.textStyle.decorationThickness,
      fontFamily: widget.textStyle.fontFamily,
      fontFamilyFallback: widget.textStyle.fontFamilyFallback,
      overflow: widget.textStyle.overflow,
    );
  }
}
