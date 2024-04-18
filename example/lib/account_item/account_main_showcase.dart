import 'package:example/account_item/account_item_list_showcase.dart';
import 'package:example/account_item/account_item_showcase.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class AccountMainShowcase extends StatefulWidget {
  const AccountMainShowcase({super.key});

  @override
  State<AccountMainShowcase> createState() => _AccountMainShowcaseState();
}

class _AccountMainShowcaseState extends State<AccountMainShowcase> {
  String? selectedFromCard;
  String? selectedToCard;
  bool isValidate = false;
  List<String> listCardName = ["Altın Hesabı", "Döviz Hesabı", "Arnavutköy Hesap", "KYK Hesap", "Askerlik Hesap"];
  List<String> filteredCardName = ["Altın Hesabı", "Döviz Hesabı", "Arnavutköy Hesap", "KYK Hesap", "Askerlik Hesap"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VCProductColors.instance.bottomSheetBGColor,
      appBar: AppBar(
        title: const VCProductText(text: "Account Items"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingNormal,
          child: Column(
            children: [
              accountItemBtn(context),
              context.emptySizedHeightBoxNormal,
              accountItemListBtn(context),
              context.emptySizedHeightBoxNormal,
              selectAccountWidget(),
              context.emptySizedHeightBoxNormal,
              validateBtn(context),
              context.emptySizedHeightBoxNormal,
              clearBtn(context),
            ],
          ),
        ),
      ),
    );
  }

  Container selectAccountWidget() {
    return Container(
      padding: context.paddingNormal,
      decoration: BoxDecoration(
        color: VCProductColors.instance.white,
        borderRadius: context.lowBorderRadius,
      ),
      child: SelectAccountWidget(
        firstText: "Select 'From' Account",
        secondText: "Select 'To' Account",
        firstErrorText: isValidate
            ? selectedFromCard == null
                ? "Please select from account"
                : null
            : null,
        secondErrorText: isValidate
            ? selectedToCard == null
                ? "Please select to account"
                : null
            : null,
        onClickFirst: () async {
          await openBottomSheet(true);
        },
        onClickSecond: () async {
          await openBottomSheet(false);
        },
        firstIcon: selectedFromCard != null ? const Icon(Icons.wallet_outlined) : null,
        firstWidget: selectedFromCard != null
            ? AccountItem(
                titleText: selectedFromCard,
                type: AccountItemType.type2,
                widgetPadding: EdgeInsets.zero,
                leadingIconVisibility: false,
              )
            : null,
        secondIcon: selectedToCard != null ? const Icon(Icons.wallet_outlined) : null,
        secondWidget: selectedToCard != null
            ? AccountItem(
                titleText: selectedToCard,
                type: AccountItemType.type2,
                widgetPadding: EdgeInsets.zero,
                leadingIconVisibility: false,
              )
            : null,
      ),
    );
  }

  Future openBottomSheet(bool isFrom) async {
    return AccountBottomSheet.open(
      context,
      onPageBuilder: (kSetState) => AccountBottomSheetContent<String>(
        pageTitle: isFrom ? "Select 'From' Account" : "Select 'To' Account",
        items: filteredCardName,
        onChangeSearchBar: (text) {
          filteredCardName = listCardName.where((el) => el.toLowerCase().contains((text ?? "").toLowerCase())).toList();
          kSetState(() {});
        },
        onClose: () {
          filteredCardName = listCardName;
        },
        onItemBuilder: (index, item) => AccountItem(
          balanceVisibility: true,
          cardTypeVisibility: true,
          titleText: item,
          isSelected: isFrom ? item == selectedFromCard : item == selectedToCard,
          onTap: () {
            if (isFrom) {
              selectedFromCard = item;
            } else {
              selectedToCard = item;
            }
            setState(() {});
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  VCButton accountItemListBtn(BuildContext context) {
    return VCButton(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AccountItemListShowcase(),
          ),
        );
      },
      child: VCProductText(
        text: "Account Item List",
        type: TypographyType.btnSmall,
        textColor: VCProductColors.instance.white,
      ),
    );
  }

  VCButton accountItemBtn(BuildContext context) {
    return VCButton(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AccountItemShowcase(),
          ),
        );
      },
      child: VCProductText(
        text: "Account Item",
        type: TypographyType.btnSmall,
        textColor: VCProductColors.instance.white,
      ),
    );
  }

  VCButton clearBtn(BuildContext context) {
    return VCButton(
      onTap: () {
        selectedToCard = null;
        selectedFromCard = null;
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

  VCButton validateBtn(BuildContext context) {
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
}
