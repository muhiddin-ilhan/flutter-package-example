import 'package:flutter/material.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'bottom_menu_sheet.dart';
import 'bottom_navbar_icon.dart';

/// enum for expandable button position
enum ButtonBottomBarPosition { center, end }

/// Class to generate the bottom bar sheet widget
class BottomBarSheet extends StatefulWidget {
  /// List of BottomSheetBarIcon to show whitin the widget
  final List<BottomSheetBarIcon> children;

  /// Value to indicate the position of the expandable button (center, end)
  final ButtonBottomBarPosition? buttonPosition;

  /// Color for container when is expanded
  final Color? backgroundBarColor;

  /// Bottom bar calor
  final Color? backgroundColor;

  /// Boolean value to show the expandable button
  final bool showExpandableButton;

  /// Double value to indicate when radius for corner on bottom bar
  final double bottomRadius;

  /// Value to indicate the bottom bar height
  final double? bottomBarHeight;

  /// Value to indicate the bottom bar width
  final double? bottomBarWidth;

  /// Indicate the duration when expand bottom sheet
  final Duration? duration;

  /// Double value to indicate the bottom sheet height
  final double? bottomSheetHeight;

  /// Color for expandable button
  final Color? iconColor;

  /// Function trigger when close bottom sheet
  final Function()? onClose;

  /// Value to indicate what icon tab is selected
  final int? currentIndex;

  /// Curve to use on animation
  final Curve curve;

  /// children: List of BottomSheetBarIcon to show whitin the widget
  /// buttonPosition: Value to indicate the position of the expandable button (center, end)
  /// backgroundColor: Color for container when is expanded
  /// backgroundBarColor: Bottom bar calor
  /// showExpandableButton: Boolean value to show the expandable button
  /// innerChild: Widget to render into the bottom sheet
  /// bottomRadius: Double value to indicate when radius for corner on bottom bar
  /// bottomBarHeight: Value to indicate the bottom bar height
  /// bottomBarWidth: Value to indicate the bottom bar width
  /// duration: Indicate the duration when expand bottom sheet
  /// bottomSheetHeight: Double value to indicate the bottom sheet height
  /// iconExpand: Icon to show into expandable button
  /// iconColor: Color for expandable button
  /// onClose: Function trigger when close bottom sheet
  /// currentIndex: Value to indicate what icon tab is selected
  /// curve: Curve to use on animation
  const BottomBarSheet({
    Key? key,
    this.children = const [],
    this.buttonPosition = ButtonBottomBarPosition.center,
    this.backgroundColor = Colors.white,
    this.backgroundBarColor = Colors.white,
    this.showExpandableButton = true,
    this.bottomRadius = 0,
    this.bottomBarHeight = 50,
    this.bottomBarWidth,
    this.duration = const Duration(milliseconds: 0),
    this.bottomSheetHeight,
    this.iconColor = Colors.white,
    this.onClose,
    this.currentIndex,
    this.curve = Curves.ease,
  }) : super(key: key);

  @override
  BottomBarSheetState createState() => BottomBarSheetState();
}

class BottomBarSheetState extends State<BottomBarSheet> {
  /// Boolean value to toggle first or second child on AnimatedCrossFade

  List<Widget> _getChildren() {
    List<Widget> children = [];

    int middle = (widget.children.length / 2).ceil();
    int index = 0;
    for (BottomSheetBarIcon el in widget.children) {
      int i = widget.children.indexOf(el);
      var onTap = el.onTap ??
          ((el.additionalMenuName is String)
              ? () async {
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    useRootNavigator: true,
                    barrierColor: Colors.transparent,
                    builder: (context) => BottomMenuSheet(
                      childMenuItems: BottomNavBarCubit.instance.state.additionalMenuMap?[el.additionalMenuName]?.childMenuItems ?? [],
                      hasDescription: el.hasDescription,
                    ),
                  );
                }
              : () {
                  AppTransactioner.instance.navigateToTransaction(el.url);
                });
      BottomSheetBarIcon icon = BottomSheetBarIcon(
          icon: el.icon,
          onTap: onTap,
          menuName: el.menuName ?? "",
          isActive: widget.currentIndex == i,
          color: el.color);
      children.add(icon);
      index++;
      if (index == middle &&
          widget.buttonPosition == ButtonBottomBarPosition.center &&
          widget.showExpandableButton) {
        children.add(_getShowButton(context));
      }
    }
    return children;
  }

  Widget _getShowButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 5),
      height: widget.bottomBarHeight,
      width: widget.bottomBarWidth ?? (size.width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(widget.bottomRadius)),
        // color: widget.backgroundBarColor,
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: _getChildren()),
    );
  }
}
