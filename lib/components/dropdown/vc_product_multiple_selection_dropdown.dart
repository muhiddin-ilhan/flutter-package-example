// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/components/base/base_component.dart';
import 'package:vc_product_widgets/components/buttons/vc_button/vc_button.dart';
import 'package:vc_product_widgets/components/inputs/vc_base_text_field.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

class VCProductMultipleSelectionDropdown<T> extends BaseComponent {
  /// The item list of the dropdown
  final List<T> dropdownItems;

  /// The label text of the dropdown
  final String label;

  /// The validator function of the dropdown (optional)
  final String? Function(T?)? validator;

  /// The disabled state of the dropdown
  final bool isDisabled;

  /// The disabled state of the search box of the dropdown
  final bool isSearchBoxDisabled;

  final List<T> Function(String searchText)? onSearched;

  /// The onChanged function of the dropdown
  final void Function(List<T>?, List<int>) onChanged;

  /// The selected item widget of the dropdown
  final Widget Function(List<T> value) selectedItemWidget;

  /// The selectable item widget of the dropdown
  final Widget Function(T value) selectableItemWidget;

  final String buttonText;

  final String? errorText;

  final bool hasBorderTop;

  final bool hasBorderBottom;

  final bool showErrorMessage;

  final Color? borderColor;

  const VCProductMultipleSelectionDropdown({
    super.key,
    super.id,
    super.checkOthers,
    super.showError,
    super.willValidate,
    required this.dropdownItems,
    required this.label,
    required this.isDisabled,
    this.validator,
    required this.onChanged,
    required this.selectedItemWidget,
    required this.selectableItemWidget,
    required this.isSearchBoxDisabled,
    this.errorText,
    this.hasBorderTop = true,
    this.hasBorderBottom = true,
    this.showErrorMessage = true,
    this.onSearched,
    this.borderColor,
    required this.buttonText,
  });

  @override
  VCProductMultipleSelectionDropdownState createState() =>
      VCProductMultipleSelectionDropdownState<T>();
}

class VCProductMultipleSelectionDropdownState<T>
    extends State<VCProductMultipleSelectionDropdown> {
  final Color disabledColor =
      VCProductColors.instance.disabledWidgetBackgroundColor;
  final Color defaultColor = VCProductColors.instance.defaultColor;
  final Color errorColor = VCProductColors.instance.errorWidgetColor;
  final Color labelColor = VCProductColors.instance.labelColor;
  final Color textColor = VCProductColors.instance.widgetTextColor;
  final Color bottomSheetBGColor = VCProductColors.instance.bottomSheetBGColor;
  Color borderColor = VCProductColors.instance.widgetBorderColor;

  /// The selected value of the dropdown
  List<T> selectedValues = [];

  List<int> selectedIndexes = [];

  /// The filtered items of the dropdown
  late List<T> filteredItems;

  String? validatorErrorText;

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(widget.dropdownItems);
    borderColor = widget.borderColor ?? borderColor;
  }

  @override
  Widget build(BuildContext context) {
    return ValidatorBuilder(builder: (_) {
      if (widget.id != null && widget.showError) {
        validatorErrorText = ValidatorService.getErrorMessage(widget.id!);
      }
      return FormField(
        validator: (T? value) {
          return widget.validator?.call(selectedValues);
        },
        builder: (formFieldState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  /// The border widget of the dropdown
                  getBorderWidget(formFieldState),

                  /// The input decorator widget to use label
                  getInputDecoratorWidget(formFieldState),
                ],
              ),

              /// If validator fails then shows error widget

              if (widget.showErrorMessage) _getErrorIcon(formFieldState)
            ],
          );
        },
      );
    });
  }

  Widget getBorderWidget(FormFieldState formFieldState) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: widget.isDisabled ? disabledColor : defaultColor,
          border: Border.all(
            color: formFieldState.hasError ||
                    widget.errorText != null ||
                    validatorErrorText != null
                ? errorColor
                : borderColor,
            width: formFieldState.hasError ||
                    widget.errorText != null ||
                    validatorErrorText != null
                ? 2
                : 1,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.hasBorderTop ? 8 : 0),
            topRight: Radius.circular(widget.hasBorderTop ? 8 : 0),
            bottomLeft: Radius.circular(widget.hasBorderBottom ? 8 : 0),
            bottomRight: Radius.circular(widget.hasBorderBottom ? 8 : 0),
          ),
        ),
      ),
    );
  }

  Widget getInputDecoratorWidget(FormFieldState formFieldState) {
    return InputDecorator(
      decoration: InputDecoration(
        isDense: true,
        label: selectedValues.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  widget.label,
                  style: TextStyle(
                    color: formFieldState.hasError ||
                            widget.errorText != null ||
                            validatorErrorText != null
                        ? errorColor
                        : labelColor,
                  ),
                ),
              )
            : null,
        border: InputBorder.none,
        labelStyle: TextStyle(color: labelColor),
      ),
      child: selectedItemListTile(selectedValues, formFieldState),
    );
  }

  Widget selectedItemListTile(
      List<dynamic> selectedValues, FormFieldState formFieldState) {
    return ListTile(
      visualDensity: VisualDensity(
          horizontal: -4, vertical: selectedValues.isNotEmpty ? -4 : 2),
      contentPadding: const EdgeInsets.only(left: 12.0, right: 12.0),
      dense: true,
      trailing: Icon(
        Icons.keyboard_arrow_down_sharp,
        color: formFieldState.hasError ||
                widget.errorText != null ||
                validatorErrorText != null
            ? errorColor
            : textColor,
      ),
      title: selectedValues.isNotEmpty
          ? widget.selectedItemWidget(selectedValues)
          : Text(
              widget.label,
              style: TextStyle(
                  fontSize: 14,
                  color: formFieldState.hasError ||
                          widget.errorText != null ||
                          validatorErrorText != null
                      ? errorColor
                      : labelColor),
            ),
      onTap: widget.isDisabled
          ? null
          : () {
              showCustomBottomSheet(widget.label);
            },
    );
  }

  Widget _getErrorIcon(formFieldState) => (formFieldState.hasError ||
          widget.errorText != null ||
          validatorErrorText != null)
      ? Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              Icon(Icons.error_outline, size: 16, color: errorColor),
              const SizedBox(
                width: 4,
              ),
              Text(
                widget.errorText ??
                    formFieldState.errorText ??
                    validatorErrorText,
                style: TextStyle(color: errorColor),
              )
            ],
          ),
        )
      : const SizedBox.shrink();

  void showCustomBottomSheet(String title) {
    filteredItems = List.from(widget.dropdownItems);
    showModalBottomSheet(
      useRootNavigator: true,
      backgroundColor: bottomSheetBGColor,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter modalSetState) {
          return SafeArea(
            bottom: false,
            top: true,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6 +
                  MediaQuery.of(context).viewInsets.bottom,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getBottomSheetTitleWidget(title),
                    getBottomSheetSearchBoxWidget(modalSetState),
                    Expanded(
                      child: getBottomSheetListViewWidget(modalSetState),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: VCButton(
                        backgroundColor:
                            VCProductColors.instance.activeTileColor,
                        onTap: () {
                          widget.onChanged
                              .call(selectedValues, selectedIndexes);
                          if (widget.id != null && widget.willValidate) {
                            ValidatorService.validate<T>(
                                componentId: widget.id!,
                                value: selectedValues.toString() as T,
                                showError: widget.showError,
                                checkOthers: widget.checkOthers);
                          }
                          Navigator.pop(context);
                        },
                        child: Text(widget.buttonText),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void filterSearchResults(String query, StateSetter setState) {
    if (query.isNotEmpty) {
      List<T> dummyListData = [];
      if (widget.onSearched != null) {
        dummyListData = widget.onSearched!(query) as List<T>;
      } else {
        for (var item in widget.dropdownItems) {
          if (item.toString().toLowerCase().contains(query.toLowerCase())) {
            dummyListData.add(item);
          }
        }
      }
      setState(() {
        filteredItems = dummyListData;
      });
    } else {
      setState(() {
        filteredItems = List.from(widget.dropdownItems);
      });
    }
  }

  Widget getBottomSheetTitleWidget(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 8, left: 8),
      child: Text(
        title,
        style: TextStyle(
            color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }

  getBottomSheetSearchBoxWidget(StateSetter modalSetState) {
    return widget.isSearchBoxDisabled
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
            child: VCBaseTextField(
              label: "Search",
              suffixIcon: const Icon(Icons.search),
              onChanged: (value) {
                filterSearchResults(value, modalSetState);
              },
            ),
          );
  }

  Widget getBottomSheetListViewWidget(StateSetter modalSetState) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: VCProductColors.instance.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListView.separated(
          itemCount: filteredItems.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              thickness: 0.2,
              height: 1,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: context.paddingLow,
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: VCProductColors.instance.backgroundGray,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Checkbox(
                    activeColor: VCProductColors.instance.activeTileColor,
                    value: selectedIndexes.contains(index),
                    onChanged: (value) {
                      if (value!) {
                        selectedIndexes.add(index);
                        selectedValues.add(filteredItems[index]);
                      } else {
                        selectedIndexes.remove(index);
                        selectedValues.remove(filteredItems[index]);
                      }
                      modalSetState(() {});
                    },
                  ),
                ),
                title: widget.selectableItemWidget(filteredItems[index]),
                onTap: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
