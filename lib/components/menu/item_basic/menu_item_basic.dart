import 'package:flutter/material.dart';

class MenuItemBasic extends StatefulWidget {
  final Widget prefix;
  final String title;
  final Function() onClick;

  const MenuItemBasic({
    super.key,
    required this.prefix,
    required this.title,
    required this.onClick,
  });

  @override
  State<MenuItemBasic> createState() => _MenuItemBasicState();
}

class _MenuItemBasicState extends State<MenuItemBasic> {
  @override
  Widget build(BuildContext context) {
    return menuItemContainer(
      child: Row(
        children: [
          prefixContainer(widget.prefix),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff121212),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget menuItemContainer({required Widget child}) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.onClick();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: child,
        ),
      ),
    );
  }

  Widget prefixContainer(Widget child) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xffF4F6F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
