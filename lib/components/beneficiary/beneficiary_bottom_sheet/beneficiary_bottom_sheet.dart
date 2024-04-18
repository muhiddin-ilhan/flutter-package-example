import 'package:flutter/material.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

class BeneficiaryBottomSheet {
  static Future open(
    BuildContext context, {
    required Widget Function(Function(void Function()) kSetState) onPageBuilder,
  }) async {
    return showModalBottomSheet(
      backgroundColor: VCProductColors.instance.bottomSheetBGColor,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: context.normalRadius,
          topLeft: context.normalRadius,
        ),
      ),
      constraints: BoxConstraints(maxHeight: context.screenHeight80),
      builder: (context) => StatefulBuilder(
        builder: (_, kSetState) => onPageBuilder(kSetState),
      ),
    );
  }
}
