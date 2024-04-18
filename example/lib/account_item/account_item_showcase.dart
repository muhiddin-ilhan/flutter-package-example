import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class AccountItemShowcase extends StatefulWidget {
  const AccountItemShowcase({super.key});

  @override
  State<AccountItemShowcase> createState() => _AccountItemShowcaseState();
}

class _AccountItemShowcaseState extends State<AccountItemShowcase> {
  bool isWrapContainer = true;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VCProductColors.instance.bottomSheetBGColor,
      appBar: AppBar(
        backgroundColor: VCProductColors.instance.navyBlue,
        foregroundColor: VCProductColors.instance.white,
        title: VCProductText(
          text: "Account Item",
          type: TypographyType.label,
          textColor: VCProductColors.instance.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingNormal,
          child: Column(
            children: [
              btn,
              spacer,
              AccountItem(
                isWrapContainer: isWrapContainer,
                isSelectable: true,
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                isSelected: isSelected,
              ),
              spacer,
              AccountItem(
                isWrapContainer: isWrapContainer,
                cardTypeVisibility: true,
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                isSelected: isSelected,
              ),
              spacer,
              AccountItem(
                isWrapContainer: isWrapContainer,
                isInactive: true,
              ),
              spacer,
              AccountItem(
                balanceVisibility: true,
                isWrapContainer: isWrapContainer,
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                isSelected: isSelected,
              ),
              spacer,
              AccountItem(
                balanceVisibility: true,
                isWrapContainer: isWrapContainer,
                shareVisibility: true,
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                isSelected: isSelected,
              ),
              spacer,
              AccountItem(
                balanceVisibility: true,
                isWrapContainer: isWrapContainer,
                cardTypeVisibility: true,
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                isSelected: isSelected,
              ),
              spacer,
              AccountItem(
                type: AccountItemType.type2,
                titleType: AccountTitleType.from,
                isWrapContainer: isWrapContainer,
                suffixDownButtonVisibility: true,
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                isSelected: isSelected,
              ),
              spacer,
              AccountItem(
                type: AccountItemType.type2,
                titleType: AccountTitleType.to,
                isWrapContainer: isWrapContainer,
                suffixDownButtonVisibility: true,
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                isSelected: isSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get btn {
    return VCButton(
      onTap: () {
        setState(() {
          isWrapContainer = !isWrapContainer;
        });
      },
      child: VCProductText(
        text: "Wrap/Unwrap Container",
        type: TypographyType.btnSmall,
        textColor: VCProductColors.instance.white,
      ),
    );
  }

  Widget get spacer {
    return Divider(
      color: VCProductColors.instance.black25.withOpacity(0.05),
    );
  }
}
