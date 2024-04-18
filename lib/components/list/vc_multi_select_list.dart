// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/components/base/base_component.dart';
import 'package:vc_product_widgets/components/buttons/vc_button/vc_button.dart';
import 'package:vc_product_widgets/components/inputs/vc_base_text_field.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/utils/vc_icons.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class VCProductMultipleSelectionWidget<T> extends BaseComponent {
  /// The item list of the dropdown
  final List<Country> dropdownItems;

  /// The label text of the dropdown
  final String? label;

  /// The validator function of the dropdown (optional)
  final String? Function(Country?)? validator;

  final Function(List<Country>?)? onCountrySelected;

  final Function(Country?)? onSelectAllSelected;

  /// The disabled state of the search box of the dropdown

  final String? errorText;

  final bool hasBorderTop;

  final bool hasBorderBottom;

  final bool showErrorMessage;

  const VCProductMultipleSelectionWidget({
    super.key,
    super.id,
    super.checkOthers,
    super.showError,
    super.willValidate,
    required this.dropdownItems,
    this.onSelectAllSelected,
    this.label,
    this.validator,
    this.errorText,
    this.onCountrySelected,
    this.hasBorderTop = true,
    this.hasBorderBottom = true,
    this.showErrorMessage = true,
  });

  @override
  State<VCProductMultipleSelectionWidget> createState() =>
      _VCProductMultipleSelectionWidgetState();
}

class _VCProductMultipleSelectionWidgetState<T>
    extends State<VCProductMultipleSelectionWidget> {

  /// The selected value of the dropdown
  List<Country> selectedValues1 = [];

  /// The filtered items of the dropdown
  late List<Country> filteredItems;

  String? validatorErrorText;

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(widget.dropdownItems);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dropdownItems.isNotEmpty &&
        (widget.dropdownItems[0] as Country).iD != -1) {
widget.dropdownItems.insert(0, Country(name: "Select all", iD: -1));
selectedValues1.clear();
        }
      

    return Padding(
      padding: const EdgeInsets.all(2),
      child: VCListView<dynamic>(
          shrinkWrap: true,
          dataList: widget.dropdownItems,
          onItemBuilder: (index, item) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: VCProductColors.instance.white,
                borderRadius: context.lowBorderRadius,
              ),
              child: Row(
                children: [
                  Checkbox(
                    activeColor: VCProductColors.instance.activeTileColor,
                    value: selectedValues1.contains(widget.dropdownItems[index]),
                    onChanged: (value) {
                      if (index == 0) {
                        if(value!) {
widget.onSelectAllSelected?.call(
                            widget.dropdownItems[index] as Country);
                        selectedValues1.addAll(widget.dropdownItems);
                        } else {
selectedValues1.clear();
widget.onCountrySelected?.call(
                            selectedValues1 as List<Country>);
                        }
                        
                      } else {
                        if (value!) {
                          selectedValues1.add(widget.dropdownItems[index]);
                        } else {
                          selectedValues1.remove(widget.dropdownItems[index]);
                        }
                        widget.onCountrySelected?.call(
                            selectedValues1 as List<Country>);
                      }

                      setState(() {

                      });
                    },
                  ),
                  Expanded(
                      child: Align(alignment: Alignment.bottomLeft,
                          child: VCProductText(

                              text: (widget.dropdownItems[index] as Country)
                                  .name!,
                              type: TypographyType.bodyRegular14,
                              fontWeight: FontWeight.w500))),

                  selectedValues1.contains(widget.dropdownItems[index]) ? VCIcons
                      .icCountryUnlock : VCIcons.icCountryLock,
                ],
              ),
            );
          }),
    );
  }
}
