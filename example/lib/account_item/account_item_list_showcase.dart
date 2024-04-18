import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class AccountItemListShowcase extends StatefulWidget {
  const AccountItemListShowcase({super.key});

  @override
  State<AccountItemListShowcase> createState() => _AccountItemListShowcaseState();
}

class _AccountItemListShowcaseState extends State<AccountItemListShowcase> {
  List<int> selectedItemNumbers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VCProductColors.instance.bottomSheetBGColor,
      appBar: AppBar(
        backgroundColor: VCProductColors.instance.navyBlue,
        foregroundColor: VCProductColors.instance.white,
        title: VCProductText(
          text: "Account Item List",
          type: TypographyType.label,
          textColor: VCProductColors.instance.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingNormal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VCProductText(
                text: "My Accounts",
                type: TypographyType.label,
              ),
              context.emptySizedHeightBoxLow,
              customizedListView(
                dataList: const [1, 2, 3],
                onItemBuilder: (index, item) => AccountItem(
                  balanceVisibility: true,
                  isInactive: index == 2,
                  shareVisibility: index == 1,
                  cardTypeVisibility: index == 0,
                  isSelectable: true,
                  isSelected: selectedItemNumbers.contains(item),
                  onTap: () {
                    selectItem(item);
                  },
                ),
              ),
              context.emptySizedHeightBoxNormal,
              const VCProductText(
                text: "Currency Accounts",
                type: TypographyType.label,
              ),
              context.emptySizedHeightBoxLow,
              customizedListView(
                dataList: const [4, 5],
                onItemBuilder: (index, item) => AccountItem(
                  balanceVisibility: true,
                  isSelectable: true,
                  isSelected: selectedItemNumbers.contains(item),
                  onTap: () {
                    selectItem(item);
                  },
                ),
              ),
              context.emptySizedHeightBoxNormal,
              const VCProductText(
                text: "Gold Accounts",
                type: TypographyType.label,
              ),
              context.emptySizedHeightBoxLow,
              customizedListView(
                dataList: const [6, 7, 8, 9, 10],
                onItemBuilder: (index, item) => AccountItem(
                  balanceVisibility: true,
                  isSelectable: true,
                  isSelected: selectedItemNumbers.contains(item),
                  onTap: () {
                   selectItem(item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectItem(int item){
    setState(() {
      if (selectedItemNumbers.contains(item)) {
        selectedItemNumbers.remove(item);
      } else {
        selectedItemNumbers.add(item);
      }
    });
  }

  Widget customizedListView<T>({
    List<T>? dataList,
    required Widget Function(int index, T item) onItemBuilder,
  }) {
    return VCListView<T>(
      shrinkWrap: true,
      containerBoxDecoration: BoxDecoration(
        color: VCProductColors.instance.white,
        borderRadius: context.lowBorderRadius,
      ),
      dataList: dataList,
      onSeperatorBuilder: (index) => seperatorWidget,
      onItemBuilder: onItemBuilder,
    );
  }

  Widget get seperatorWidget {
    return Divider(
      height: context.semiLowValue,
      endIndent: context.normalValue,
      indent: context.normalValue,
      color: VCProductColors.instance.black.withOpacity(0.07),
    );
  }
}
