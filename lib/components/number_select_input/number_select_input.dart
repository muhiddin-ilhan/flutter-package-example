import 'package:flutter/material.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/components/base/base_component.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class NumberSelectInput extends BaseComponent {
  final int numberOfTransfers;
  final Function(int value) onChange;

  const NumberSelectInput({
    super.key,
    required this.numberOfTransfers,
    required this.onChange,
    super.id,
    super.showError,
    super.checkOthers,
    super.willValidate,
  });

  @override
  State<NumberSelectInput> createState() => _NumberSelectInputState();
}

class _NumberSelectInputState extends State<NumberSelectInput> {
  bool runningAutoIncrement = false;
  String? validatorErrorText;

  @override
  Widget build(BuildContext context) {
    return ValidatorBuilder(builder: (_) {
      if (widget.id != null && widget.showError) {
        validatorErrorText =
            ValidatorService.getErrorMessage("NumberOfTransfer");
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: context.paddingLow,
            width: double.infinity,
            decoration: BoxDecoration(
              color: VCProductColors.instance.white,
              borderRadius: context.lowBorderRadius,
              border: Border.all(
                width: 1,
                color: VCProductColors.instance.grey,
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onLongPressStart: (_) async {
                    runningAutoIncrement = true;
                    while (runningAutoIncrement) {
                      if (widget.numberOfTransfers > 1) {
                        int newNum = widget.numberOfTransfers - 1;
                        widget.onChange(newNum);
                      }
                      await Future.delayed(const Duration(milliseconds: 100));
                    }
                  },
                  onLongPressUp: () {
                    runningAutoIncrement = false;
                    setState(() {});
                  },
                  child: VCButton(
                    onTap: () {
                      setState(() {
                        if (widget.numberOfTransfers > 1) {
                          int newNum = widget.numberOfTransfers - 1;
                          widget.onChange(newNum);
                        }
                      });
                    },
                    buttonSize: VCButtonSize.custom,
                    buttonType: VCButtonType.secondary,
                    height: 52,
                    width: 52,
                    child: const Icon(Icons.remove),
                  ),
                ),
                Expanded(
                  child:
                      VCProductText(text: widget.numberOfTransfers.toString()),
                ),
                GestureDetector(
                  onLongPressStart: (_) async {
                    runningAutoIncrement = true;
                    while (runningAutoIncrement) {
                      int newNum = widget.numberOfTransfers + 1;
                      widget.onChange(newNum);
                      await Future.delayed(const Duration(milliseconds: 100));
                    }
                  },
                  onLongPressUp: () {
                    runningAutoIncrement = false;
                    setState(() {});
                  },
                  child: VCButton(
                    onTap: () {
                      setState(() {
                        int newNum = widget.numberOfTransfers + 1;
                        widget.onChange(newNum);
                      });
                    },
                    buttonSize: VCButtonSize.custom,
                    buttonType: VCButtonType.secondary,
                    height: 52,
                    width: 52,
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
          context.emptySizedHeightBoxSemiLow,
          if (validatorErrorText != null)
            ErrorTextWidget(errorText: validatorErrorText!),
        ],
      );
    });
  }
}
