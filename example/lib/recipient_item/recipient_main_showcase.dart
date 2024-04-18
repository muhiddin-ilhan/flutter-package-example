import 'package:example/recipient_item/recipient_item_showcase.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class RecipientMainShowcase extends StatefulWidget {
  const RecipientMainShowcase({super.key});

  @override
  State<RecipientMainShowcase> createState() => _RecipientMainShowcaseState();
}

class _RecipientMainShowcaseState extends State<RecipientMainShowcase> {
  String? selectedAccount;
  String? selectedRecipient;
  bool isValidate = false;
  List<String> listCardName = [
    "Altın Hesabı",
    "Döviz Hesabı",
    "Arnavutköy Hesap",
    "KYK Hesap",
    "Askerlik Hesap"
  ];
  List<String> filteredCardName = [];

  List<String> recipientNames = [
    "Baby Doe",
    "Brett Boe",
    "Carla Coe",
    "Donna Doe",
    "Frank Foe",
    "Grace Goe",
    "Harry Hoe",
    "Jackie Joe",
    "Jane Doe",
    "Jane Poe"
  ];

  List<String> filteredRecipientNames = [];

  @override
  void initState() {
    super.initState();
    filteredCardName.addAll(listCardName);
    filteredRecipientNames.addAll(recipientNames);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VCProductColors.instance.bottomSheetBGColor,
      appBar: AppBar(
        title: const VCProductText(text: "Recipient Items"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingNormal,
          child: Column(
            children: [
              recipientItemBtn(context),
              context.emptySizedHeightBoxNormal,
              selectAccountRecipientWidget(),
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

  Container selectAccountRecipientWidget() {
    return Container(
      padding: context.paddingNormal,
      decoration: BoxDecoration(
        color: VCProductColors.instance.white,
        borderRadius: context.lowBorderRadius,
      ),
      child: SelectAccountWidget(
        firstText: "Select 'From' Account",
        secondText: "Select Recipient",
        firstErrorText: isValidate
            ? selectedAccount == null
                ? "Please select from account"
                : null
            : null,
        secondErrorText: isValidate
            ? selectedRecipient == null
                ? "Please select to recipient"
                : null
            : null,
        onClickFirst: () async {
          await openAccountBottomSheet();
        },
        onClickSecond: () async {
          await openRecipientBottomSheet();
        },
        firstIcon:
            selectedAccount != null ? const Icon(Icons.wallet_outlined) : null,
        firstWidget: selectedAccount != null
            ? AccountItem(
                titleText: selectedAccount,
                type: AccountItemType.type2,
                widgetPadding: EdgeInsets.zero,
                leadingIconVisibility: false,
              )
            : null,
        secondIcon: selectedRecipient != null
            ? const Icon(Icons.person_2_rounded)
            : null,
        secondWidget: selectedRecipient != null
            ? RecipientItem(
                nameText: selectedRecipient,
                widgetPadding: EdgeInsets.zero,
                leadingIconVisibility: false,
          balanceVisibility: true,
              )
            : null,
      ),
    );
  }

  Future openAccountBottomSheet() async {
    return AccountBottomSheet.open(
      context,
      onPageBuilder: (kSetState) => AccountBottomSheetContent<String>(
        pageTitle: "Select 'From' Account",
        items: filteredCardName,
        onChangeSearchBar: (text) {
          filteredCardName = listCardName
              .where(
                  (el) => el.toLowerCase().contains((text ?? "").toLowerCase()))
              .toList();
          kSetState(() {});
        },
        onClose: () {
          filteredCardName = listCardName;
        },
        onItemBuilder: (index, item) => AccountItem(
          balanceVisibility: true,
          cardTypeVisibility: true,
          titleText: item,
          isSelected: item == selectedAccount,
          onTap: () {
            selectedAccount = item;
            setState(() {});
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Future openRecipientBottomSheet() async {
    return RecipientBottomSheet.open(
      context,
      onPageBuilder: (kSetState) => RecipientBottomSheetContent<String>(
        pageTitle: "Saved Recipients",
        items: filteredRecipientNames,
        onChangeSearchBar: (text) {
          filteredRecipientNames = recipientNames
              .where(
                  (el) => el.toLowerCase().contains((text ?? "").toLowerCase()))
              .toList();
          kSetState(() {});
        },
        onClose: () {
          filteredRecipientNames = recipientNames;
        },
        onItemBuilder: (index, item) => RecipientItem(
          nameText: item,
          isSelected: item == selectedRecipient,
          onTap: () {
            selectedRecipient = item;
            setState(() {});
            Navigator.pop(context);
          },
        ),
        infoVisibility: true,
        infoText: "You can select more than one recipient to split your transaction.",
        infoTitle: "What is MTCN?",
      ),
    );
  }

  VCButton recipientItemBtn(BuildContext context) {
    return VCButton(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RecipientItemShowcase(),
          ),
        );
      },
      child: VCProductText(
        text: "Recipient Item",
        type: TypographyType.btnSmall,
        textColor: VCProductColors.instance.white,
      ),
    );
  }

  VCButton clearBtn(BuildContext context) {
    return VCButton(
      onTap: () {
        selectedAccount = null;
        selectedRecipient = null;
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
