import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class BillCardsShowcase extends StatefulWidget {
  const BillCardsShowcase({super.key});

  @override
  State<BillCardsShowcase> createState() => _BillCardsShowcaseState();
}

class _BillCardsShowcaseState extends State<BillCardsShowcase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VCProductColors.instance.bottomSheetBGColor,
      appBar: AppBar(
        title: const VCProductText(text: "Bill Cards"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingNormal,
          child: Column(
            children: [
              const BillCard(
                widgetPadding: EdgeInsets.zero,
                leadingIconVisibility: false,
                subtitle1Visibility: true,
              ),
              context.emptySizedHeightBoxMedium,
              const BillCard(
                widgetPadding: EdgeInsets.zero,
                leadingIconVisibility: false,
                subtitle1Visibility: true,
                leadingDividerVisibility: true,
              ),
              context.emptySizedHeightBoxMedium,
              const BillCard(
                widgetPadding: EdgeInsets.zero,
                subtitle1Visibility: true,
              ),
              context.emptySizedHeightBoxMedium,
              const BillCard(
                widgetPadding: EdgeInsets.zero,
                subtitle1Visibility: true,
                isSelected: true,
              ),
              context.emptySizedHeightBoxMedium,
              const BillCard(
                widgetPadding: EdgeInsets.zero,
                subtitle1Visibility: true,
                isSelectable: true,
              ),
              context.emptySizedHeightBoxMedium,
              const BillCard(
                isWrapContainer: true,
                leadingIconVisibility: false,
                subtitle1Visibility: true,
              ),
              context.emptySizedHeightBoxLow,
              const BillCard(
                isWrapContainer: true,
                leadingIconVisibility: false,
                subtitle1Visibility: true,
                leadingDividerVisibility: true,
              ),
              context.emptySizedHeightBoxLow,
              const BillCard(
                isWrapContainer: true,
                subtitle1Visibility: true,
              ),
              context.emptySizedHeightBoxLow,
              const BillCard(
                isWrapContainer: true,
                subtitle1Visibility: true,
                isSelected: true,
              ),
              context.emptySizedHeightBoxLow,
              const BillCard(
                isWrapContainer: true,
                subtitle1Visibility: true,
                isSelectable: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
