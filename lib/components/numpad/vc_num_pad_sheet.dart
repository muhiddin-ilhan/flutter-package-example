import 'package:flutter/material.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/components/numpad/vc_num_pad_field.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

import '../buttons/selectable_button_list/controllers/selectable_button_controller.dart';
import '../buttons/vc_button/vc_button.dart';
import '../inputs/controller/amount_editing_controller.dart';
import '../inputs/formatters/amount_input_formatter.dart';
import '../inputs/vc_amount_box_field.dart';
import '../text/typography_type.dart';
import '../vc_product_components.dart';

class VCNumPadSheet extends StatefulWidget {
  AmountEditingController controller;
  Currency? currency;

  VCNumPadSheet({required this.controller, this.currency, Key? key})
      : super(key: key);

  @override
  State<VCNumPadSheet> createState() => _VCNumPadSheetState();
}

class _VCNumPadSheetState extends State<VCNumPadSheet> {
  late AmountInputFormatter _formatter;

  String initialValue = "";
  int? selectedButtonIndex;
  SelectableButtonController buttonController = SelectableButtonController();
  List<int> buttons = const [10, 50, 150, 200, 250];

  @override
  void initState() {
    super.initState();
    _formatter = AmountInputFormatter(
        decimal: 2, currency: widget.currency, onChange: formatterOnChange);
    initialValue = widget.controller.text;
    if (!_formatter.isZero(widget.controller.text)) {
      widget.controller.text = "";
    }
    formatterOnChange(widget.controller.text);
  }

  formatterOnChange(value) {
    selectedButtonIndex = buttons.indexOf(_formatter.unFormat(value)?.toInt() ?? 0);
    if (selectedButtonIndex != null && selectedButtonIndex != -1) {
      buttonController.selectIndex(selectedButtonIndex!);
    } else {
      buttonController.unselectAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VCProductColors.instance.bottomSheetBGColor,
      appBar: appBar(),
      body: SingleChildScrollView(
        padding: context.paddingNormal,
        child: Column(
          children: [
            VCAmountBoxField(
              currency: widget.currency,
              textAlign: TextAlign.center,
              amountController: widget.controller,
              initValue: widget.controller.text,
              label: "Amount",
              inputType: TextInputType.number,
              buttons: buttons,
              readOnly: true,
              inputFormatters: [_formatter],
              onTap: () {},
              buttonController: buttonController,
            ),
            context.emptySizedHeightBoxNormal,
            VCButton(
              buttonSize: VCButtonSize.medium,
              onTap: () async {
                widget.controller.text =
                    _formatter.format(widget.controller.text, 2);
                Navigator.pop(context);
              },
              backgroundColor: VCProductColors.instance.activeTileColor,
              buttonType: VCButtonType.primary,
              child: VCProductComponents.text(
                text: "Done",
                textColor: VCProductColors.instance.white,
                typographyType: TypographyType.bodyRegular14,
              ),
            ),
            context.emptySizedHeightBoxNormal,
            VCNumPadField(
              controller: widget.controller,
              formatter: _formatter,
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: VCProductColors.instance.bottomSheetBGColor,
      title: VCProductComponents.text(
          text: "Enter Amount",
          textAlign: TextAlign.start,
          fontSize: 20,
          fontWeight: FontWeight.w500),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            widget.controller.text = initialValue;
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
