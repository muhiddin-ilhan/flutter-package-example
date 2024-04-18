import 'package:flutter/material.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/components/base/base_component.dart';
import 'package:vc_product_widgets/components/buttons/radio_button_list/vc_product_radio_button.dart';
import 'package:vc_product_widgets/components/error_text/error_text_widget.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'controllers/radio_button_controller.dart';

/// A widget that represents a list of radio buttons or checkboxes.
///
/// This widget allows users to select one or more options from the provided list.
class VCProductRadioButtonList<T> extends BaseComponent {
  /// The list of values to display as radio buttons or checkboxes.
  final List<T> values;

  /// The index of the initially selected value.
  final int? selectedValueIndex;

  /// Controller for managing the state of the radio buttons or checkboxes.
  final RadioButtonController? controller;

  /// Callback function called when a button is selected.
  final void Function(T button, int index, bool isSelected)? onSelected;

  /// Callback function called when a disabled button is pressed.
  final Function(int)? onDisablePressed;

  /// List of indexes representing disabled buttons.
  final List<int> disabledValues;

  /// Flag indicating whether the widget should behave as a radio button (single selection).
  final bool isRadio;

  /// Flag indicating whether deselection is allowed for radio buttons.
  final bool? enableDeselect;

  /// Maximum number of selected values allowed (for checkboxes).
  final int? maxSelected;

  /// Padding around each button.
  final EdgeInsets padding;

  /// Text style applied to the button's label.
  final TextStyle? textStyle;

  /// Text style applied to the button's label when disabled.
  final TextStyle? disabledTextStyle;

  /// Background color of the button when selected.
  final Color? selectedColor;

  /// Border color of the unselected checkbox.
  final Color? unselectedBorderColor;

  /// Size of the outline around the radio button or checkbox.
  final double? radioButtonOutlineSize;

  /// Size of the inner inline part of the radio button or checkbox.
  final double? radioButtonInlineSize;

  /// Width of the outline around the radio button or checkbox.
  final double? radioButtonOutlineWidth;

  /// The width of each button. if axis is horizontal you must use this property
  final double? radioButtonWidth;

  /// The direction in which the buttons are arranged (horizontal or vertical).
  final Axis direction;

  final MainAxisAlignment mainAxisAlignment;

  final Decoration? radioButtonWidgetDecoration;
  final Widget Function(T)? radioButtonTextWidget;
  final EdgeInsets? radioButtonPadding;
  final Widget? widgetBetweenButtons;

  const VCProductRadioButtonList({
    Key? key,
    required this.values,
    this.selectedValueIndex,
    this.controller,
    this.onSelected,
    this.onDisablePressed,
    this.disabledValues = const [],
    this.isRadio = true,
    this.enableDeselect = false,
    this.maxSelected,
    //this.direction,
    this.padding = EdgeInsets.zero,
    this.textStyle,
    this.disabledTextStyle,
    this.unselectedBorderColor,
    this.radioButtonOutlineSize,
    this.radioButtonInlineSize,
    this.radioButtonOutlineWidth,
    this.selectedColor,
    this.radioButtonWidth,
    this.direction = Axis.vertical,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    super.id,
    super.showError,
    super.checkOthers,
    super.willValidate,
    this.radioButtonWidgetDecoration,
    this.radioButtonTextWidget,
    this.radioButtonPadding,
    this.widgetBetweenButtons,
  }) : super(key: key);

  @override
  State<VCProductRadioButtonList<T>> createState() =>
      _VCProductGroupButtonState<T>();
}

class _VCProductGroupButtonState<T> extends State<VCProductRadioButtonList<T>> {
  late RadioButtonController _controller;
  String? validatorErrorText;

  @override
  void didUpdateWidget(covariant VCProductRadioButtonList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _controller = widget.controller ?? _buildController();
      _controller.onDisablePressed ??= widget.onDisablePressed;
    }
  }

  RadioButtonController _buildController() => RadioButtonController(
        selectedIndex: widget.selectedValueIndex,
        disabledIndexes: widget.disabledValues,
        onDisablePressed: widget.onDisablePressed,
      );

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? _buildController();
  }

  @override
  Widget build(BuildContext context) {
    return ValidatorBuilder(builder: (_) {
      if (widget.id != null && widget.showError) {
        validatorErrorText = ValidatorService.getErrorMessage(widget.id!);
      }
      return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return _buildBodyByGroupingType();
        },
      );
    });
  }

  Widget _buildBodyByGroupingType() {
    final values = _generateButtonsList();

    if (widget.direction == Axis.vertical) {
      return Column(
        mainAxisAlignment: widget.mainAxisAlignment,
        children: values,
      );
    } else {
      return Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        children: [
          ...values,
          if (validatorErrorText != null)
            ErrorTextWidget(errorText: validatorErrorText!),
        ],
      );
    }
  }

  List<Widget> _generateButtonsList() {
    final rebuildedButtons = <Widget>[];
    for (var i = 0; i < widget.values.length; i++) {
      late Widget button;

      button = VCProductRadioButton(
        value: widget.values[i],
        onSelected: _controller.disabledIndexes.contains(i)
            ? () => _controller.onDisablePressed?.call(i)
            : () {
                _selectButton(i);
                widget.onSelected?.call(widget.values[i], i, _isSelected(i));
                if (widget.id != null && widget.willValidate) {
                  ValidatorService.validate(
                    componentId: widget.id!,
                    value: widget.values[i],
                    showError: widget.showError,
                    checkOthers: widget.checkOthers,
                  );
                }
              },
        isSelected: _isSelected(i),
        isDisable: _controller.disabledIndexes.contains(i),
        textStyle: widget.textStyle,
        disabledTextStyle: widget.disabledTextStyle,
        selectedColor: validatorErrorText != null
            ? VCProductColors.instance.errorWidgetColor
            : widget.selectedColor,
        radioButtonInlineSize: widget.radioButtonInlineSize,
        radioButtonOutlineWidth: widget.radioButtonOutlineWidth,
        radioButtonWidgetDecoration: widget.radioButtonWidgetDecoration,
        radioButtonTextWidget: widget.radioButtonTextWidget,
        radioButtonOutlineSize: widget.radioButtonOutlineSize,
        radioButtonPadding: widget.radioButtonPadding,
        width: widget.radioButtonWidth,
      );

      button = Padding(
        padding: widget.padding,
        child: button,
      );

      rebuildedButtons.add(button);
      if(i != widget.values.length - 1 && widget.widgetBetweenButtons != null){
        rebuildedButtons.add(widget.widgetBetweenButtons!);
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
