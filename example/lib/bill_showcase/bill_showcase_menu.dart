import 'package:example/bill_showcase/bill_cards_showcase.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class BillShowcaseMenu extends StatefulWidget {
  const BillShowcaseMenu({super.key});

  @override
  State<BillShowcaseMenu> createState() => _BillShowcaseMenuState();
}

class _BillShowcaseMenuState extends State<BillShowcaseMenu> {
  String? selectedBill;
  bool isValidate = false;
  List<String> listSavedBills = ["Vodafone", "Turkcell", "Avea", "Turk Telekom", "Turknet"];
  List<String> filteredlistSavedBills = ["Vodafone", "Turkcell", "Avea", "Turk Telekom", "Turknet"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VCProductColors.instance.bottomSheetBGColor,
      appBar: AppBar(
        title: const VCProductText(text: "Bill Items"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingNormal,
          child: Column(
            children: [
              billCardsBtn,
              context.emptySizedHeightBoxNormal,
              selectSavedBillWidget(),
              context.emptySizedHeightBoxNormal,
              validateBtn(),
              context.emptySizedHeightBoxNormal,
              clearBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Container selectSavedBillWidget() {
    return Container(
      padding: context.paddingNormal,
      decoration: BoxDecoration(
        color: VCProductColors.instance.white,
        borderRadius: context.lowBorderRadius,
      ),
      child: SelectAccountWidget(
        isVisibleSecond: false,
        isIconTopPadding: false,
        isVisibleActionButton: true,
        defaultFirstLeadingIcon: Icons.receipt_long_rounded,
        actionButtonText: "ADD NEW BILL",
        firstText: "Select Saved Bill",
        firstErrorText: isValidate
            ? selectedBill == null
                ? "Select bill area can not be empty"
                : null
            : null,
        onClickFirst: () async {
          await openBottomSheet();
        },
        firstIcon: selectedBill != null ? const Icon(Icons.electric_bolt_rounded) : null,
        firstWidget: selectedBill != null
            ? BillCard(
                titleText: selectedBill,
                widgetPadding: EdgeInsets.zero,
                leadingIconVisibility: false,
                suffixDownButtonVisibility: true,
                balanceVisibility: false,
                subtitle2Visibility: true,
                subtitle2Text: "Outstanding Balance: \$100.00",
                subtitle1Visibility: true,
                subtitle1Text: "Expires: 23 May 2024",
              )
            : null,
      ),
    );
  }

  Future openBottomSheet() async {
    return AccountBottomSheet.open(
      context,
      onPageBuilder: (kSetState) => AccountBottomSheetContent<String>(
        pageTitle: "Select Saved Bill",
        items: filteredlistSavedBills,
        onChangeSearchBar: (text) {
          filteredlistSavedBills = listSavedBills.where((el) => el.toLowerCase().contains((text ?? "").toLowerCase())).toList();
          kSetState(() {});
        },
        onClose: () {
          filteredlistSavedBills = listSavedBills;
        },
        onItemBuilder: (index, item) => BillCard(
          balanceVisibility: true,
          titleText: item,
          isSelected: item == selectedBill,
          subtitle1Visibility: true,
          subtitle1Text: "Expires: 24 May 2024",
          leadingIcon: const Icon(Icons.electric_bolt_rounded),
          balanceText: "\$100.00",
          onTap: () {
            selectedBill = item;
            setState(() {});
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  VCButton clearBtn() {
    return VCButton(
      onTap: () {
        selectedBill = null;
        isValidate = false;
        setState(() {});
      },
      child: VCProductText(
        text: "Clear All States",
        type: TypographyType.btnSmall,
        textColor: VCProductColors.instance.white,
      ),
    );
  }

  VCButton validateBtn() {
    return VCButton(
      onTap: () {
        isValidate = true;
        setState(() {});
      },
      child: VCProductText(
        text: "Validate",
        type: TypographyType.btnSmall,
        textColor: VCProductColors.instance.white,
      ),
    );
  }

  Widget get billCardsBtn {
    return VCProductComponents.vcButton(
      child: const Text("Bill Cards"),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const BillCardsShowcase(),
          ),
        );
      },
    );
  }
}
