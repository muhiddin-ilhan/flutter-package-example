import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/buttons/selectable_button_list/vc_product_selectable_button.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'controllers/selectable_button_controller.dart';

/// A widget that represents a list of selectable buttons (radio buttons or checkboxes).
///
/// This widget allows users to select one or more options from the provided list.
class VCProductSelectableButtonList<T> extends StatefulWidget {
  /// The list of items to display as selectable buttons.
  final List<T> buttons;

  /// The list of icons to display next to each button.
  final List<Widget>? icons;

  /// List of indexes representing disabled buttons.
  final List<int> disabledButtons;

  /// The index of the initially selected button.
  final int? selectedButtonIndex;

  /// Callback function called when a button is selected.
  final void Function(T button, int index, bool isSelected)? onSelected;

  /// Callback function called when a disabled button is pressed.
  final Function(int)? onDisablePressed;

  /// Flag indicating whether the widget should behave as a radio button (single selection).
  final bool isRadio;

  /// Flag indicating whether deselection is allowed for radio buttons.
  final bool? enableDeselect;

  /// Maximum number of selected buttons allowed (for checkboxes).
  final int? maxSelected;

  /// The direction in which the buttons are arranged (horizontal or vertical).
  final Axis direction;

  /// Padding around each button.
  final EdgeInsets padding;

  /// Padding of each button.
  final EdgeInsets? innerPadding;

  /// Spacing around each button.
  final double? spacing;

  /// The fontSize of the button.
  final double? fontSize;

  /// Text style applied to the button's label when selected.
  final TextStyle? selectedTextStyle;

  /// Text style applied to the button's label when unselected.
  final TextStyle? unselectedTextStyle;

  /// Background color of the button when selected.
  final Color? selectedColor;

  /// Background color of the button when unselected.
  final Color? unselectedColor;

  /// The border radius of the button.
  final double borderRadius;

  /// The width of each button.
  final double? buttonWidth;

  /// The height of each button.
  final double? buttonHeight;

  /// The horizontal alignment of the button text.
  final TextAlign textAlign;

  /// The alignment of the button within its parent widget.
  final AlignmentGeometry? alignment;

  /// The elevation of the button.
  final double? elevation;

  /// Controller for managing the state of the selectable buttons.
  final SelectableButtonController? controller;

  /// Flag indicating whether the button's border is visible.
  final bool isBorderVisible;

  /// Flag indicating whether the button's width should fit the current width.
  final bool fitTheCurrentWidth;

  const VCProductSelectableButtonList(
      {Key? key,
      required this.buttons,
      required this.textAlign,
      this.icons,
      this.controller,
      this.selectedButtonIndex,
      this.onSelected,
      this.onDisablePressed,
      this.disabledButtons = const [],
      this.isRadio = false,
      this.enableDeselect = false,
      this.maxSelected,
      this.direction = Axis.horizontal,
      this.padding = EdgeInsets.zero,
      this.selectedTextStyle,
      this.unselectedTextStyle,
      this.selectedColor,
      this.unselectedColor,
      this.borderRadius = 4,
      this.buttonWidth,
      this.buttonHeight,
      this.alignment,
      this.elevation,
      this.fitTheCurrentWidth = false,
      this.isBorderVisible = false,
      this.spacing,
      this.fontSize,
      this.innerPadding})
      : super(key: key);

  @override
  State<VCProductSelectableButtonList<T>> createState() =>
      _VCProductGroupButtonState<T>();
}

class _VCProductGroupButtonState<T>
    extends State<VCProductSelectableButtonList<T>> {
  late SelectableButtonController _controller;

  @override
  void didUpdateWidget(covariant VCProductSelectableButtonList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _controller = widget.controller ?? _buildController();
      _controller.onDisablePressed ??= widget.onDisablePressed;
    }
  }

  SelectableButtonController _buildController() => SelectableButtonController(
        selectedIndex: widget.selectedButtonIndex,
        disabledIndexes: widget.disabledButtons,
        onDisablePressed: widget.onDisablePressed,
      );

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? _buildController();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return _buildBodyByGroupingType();
      },
    );
  }

  Widget _buildBodyByGroupingType() {
    final buttons = _generateButtonsList();

    if (widget.direction == Axis.vertical) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: buttons,
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: buttons,
      );
    }
  }

  List<Widget> _generateButtonsList() {
    final rebuildedButtons = <Widget>[];
    for (var i = 0; i < widget.buttons.length; i++) {
      late Widget button;

      button = VCProductSelectableButton(
        icon: widget.icons != null ? widget.icons![i] : null,
        text: widget.buttons[i].toString(),
        onPressed: _controller.disabledIndexes.contains(i)
            ? () => _controller.onDisablePressed?.call(i)
            : () {
                _selectButton(i);
                widget.onSelected?.call(widget.buttons[i], i, _isSelected(i));
              },
        isSelected: _isSelected(i),
        isDisable: _controller.disabledIndexes.contains(i),
        selectedTextStyle: widget.selectedTextStyle,
        unselectedTextStyle: widget.unselectedTextStyle,
        selectedColor: widget.selectedColor,
        unselectedColor: widget.unselectedColor,
        borderRadius: widget.borderRadius,
        height: widget.buttonHeight,
        width: widget.buttonWidth,
        textAlign: widget.textAlign,
        alignment: widget.alignment,
        elevation: widget.elevation,
        isBorderVisible: widget.isBorderVisible,
        fontSize: widget.fontSize,
        padding: widget.innerPadding ??
            EdgeInsets.only(
                left: context.screenWidth055, right: context.screenWidth055),
      );

      button = Padding(
        padding: widget.padding,
        child: button,
      );

      if (widget.fitTheCurrentWidth) {
        button = Expanded(
          child: button,
        );
      }
      rebuildedButtons.add(button);
      if (i != widget.buttons.length - 1 && widget.spacing != null) {
        rebuildedButtons.add(SizedBox(
          width: widget.spacing,
        ));
      }
    }
    return rebuildedButtons;
  }

  void _selectButton(int i) {
    if (widget.isRadio) {
      if (widget.enableDeselect! && _controller.selectedIndex == i) {
        _controller.unselectIndex(i);
      } else {
        _controller.selectIndex(i);
      }
    } else {
      final maxSelected = widget.maxSelected;
      final selectedIndexesCount = _controller.selectedIndexes.length;
      if (maxSelected != null &&
          selectedIndexesCount >= maxSelected &&
          !_controller.selectedIndexes.contains(i)) {
        return;
      }
      _controller.toggleIndexes([i]);
    }
  }

  bool _isSelected(int i) {
    return widget.isRadio
        ? _controller.selectedIndex == i
        : _controller.selectedIndexes.contains(i);
  }
}
