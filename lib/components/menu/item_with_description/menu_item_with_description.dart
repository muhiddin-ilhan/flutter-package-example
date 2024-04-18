import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

class MenuItemWithDescription extends StatefulWidget {
  final Widget? prefix;
  final bool suffixVisibility;
  final Widget? suffix;
  final String title;
  final String description;
  final Function() onClick;
  final bool isWrapContainer;
  final EdgeInsets? containerPadding;

  const MenuItemWithDescription({
    super.key,
    this.prefix,
    this.suffixVisibility = false,
    this.suffix,
    required this.title,
    required this.description,
    required this.onClick,
    this.isWrapContainer = true,
    this.containerPadding
  });

  @override
  State<MenuItemWithDescription> createState() =>
      _MenuItemWithDescriptionState();
}

class _MenuItemWithDescriptionState extends State<MenuItemWithDescription> {
  @override
  Widget build(BuildContext context) {
    return menuItemContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.prefix != null) prefixContainer(widget.prefix!),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.title,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff121212),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  widget.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xff64748B),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (widget.suffixVisibility) suffixContainer(widget.suffix),
        ],
      ),
    );
  }

  Widget menuItemContainer({required Widget child}) {
    return Material(
      borderRadius: widget.isWrapContainer ? BorderRadius.circular(8) : null,
      clipBehavior: widget.isWrapContainer ? Clip.hardEdge : Clip.none,
      color: widget.isWrapContainer ? Colors.white : Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.onClick();
        },
        child: Container(
          padding: widget.containerPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget prefixContainer(Widget child) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xffF4F6F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  Widget suffixContainer(Widget? child) {
    return child ?? Icon(Icons.arrow_forward_ios_outlined, color: VCProductColors.instance.iconColor, size: 14);
  }
}
