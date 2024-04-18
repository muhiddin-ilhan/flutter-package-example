import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/relationship_manager_item/relationship_manager_item.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class RecipientItemShowcase extends StatefulWidget {
  const RecipientItemShowcase({super.key});

  @override
  State<RecipientItemShowcase> createState() => _RecipientItemShowcaseState();
}

class _RecipientItemShowcaseState extends State<RecipientItemShowcase> {
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
          text: "Recipient Item",
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
              RecipientItem(
                isWrapContainer: isWrapContainer,
                nameText: "John Doe",
                leadingIconVisibility: false,
              ),
              spacer,
              RecipientItem(
                isWrapContainer: isWrapContainer,
                nameText: "John Doe",
              ),
              spacer,
              RecipientItem(
                isWrapContainer: isWrapContainer,
                suffixVisibility: true,
                suffixIcon: Icons.more_horiz_rounded,
                suffixColor: VCProductColors.instance.black,
                nameText: "John Doe",
              ),
              spacer,
              RecipientItem(
                isWrapContainer: isWrapContainer,
                nameText: "John Doe",
                subtitleText: "32522345",
                suffixVisibility: true,
                suffixIcon: Icons.more_horiz_rounded,
                suffixColor: VCProductColors.instance.black,
              ),
              spacer,
              RecipientItem(
                isWrapContainer: isWrapContainer,
                nameText: "John Doe",
                isSelectable: true,
                isSelected: true,
              ),
              spacer,
              RecipientItem(
                isWrapContainer: isWrapContainer,
                nameText: "John Doe",
                isSelectable: true,
                isSelected: false,
                suffixVisibility: true,
                suffixIcon: Icons.more_horiz_rounded,
                suffixColor: VCProductColors.instance.black,
              ),
              spacer,
              RecipientItem(
                isWrapContainer: isWrapContainer,
                nameText: "John Doe",
                isSelectable: true,
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                isSelected: isSelected,
              ),
              spacer,
              RecipientItem(
                isWrapContainer: isWrapContainer,
                nameText: "John Doe",
                suffixVisibility: true,
                suffixIcon: Icons.done,
                balanceVisibility: true,
              ),
              spacer,
              RecipientItem(
                isWrapContainer: isWrapContainer,
                nameText: "John Doe",
                shareVisibility: true,
                balanceVisibility: true,
              ),
              spacer,
              RecipientItem(
                isWrapContainer: isWrapContainer,
                nameText: "John Doe",
                shareVisibility: true,
                balanceVisibility: true,
                shareText: "Reshare Link",
              ),
              spacer,
              RecipientItem(
                isWrapContainer: isWrapContainer,
                nameText: "John Doe",
                isStatusActive: true,
                statusType: RecipientStatusType.pending,
                balanceVisibility: true,
                suffixVisibility: true,
              ),
              spacer,
              RecipientItem(
                isWrapContainer: isWrapContainer,
                nameText: "John Doe",
                isStatusActive: true,
                statusType: RecipientStatusType.completed,
                balanceVisibility: true,
                suffixVisibility: true,
              ),
              spacer,
              RecipientItem(
                isWrapContainer: isWrapContainer,
                nameText: "John Doe",
                isStatusActive: true,
                statusType: RecipientStatusType.error,
                statusTextColor: VCProductColors.instance.white,
                balanceVisibility: true,
                suffixVisibility: true,
              ),
              spacer,
              RecipientItem(
                isWrapContainer: isWrapContainer,
                nameText: "John Doe",
                balanceVisibility: true,
                balancePosition: RecipientBalancePosition.end,
                subtitleText: "Local Payment",
                subtitle2Text: "Frequency: Monthly",
                suffixVisibility: true,
              ),
              spacer,
              const RecipientCircularItem(nameText: "John Doe",),
              spacer,
              const VCProductText(text: "Relationship Manager Item"),
              RelationshipManagerItem(
                isWrapContainer: isWrapContainer,
                titleText: "John Doe",
                subtitleText: "Local Payment",
                subtitle2Text: "Frequency: Monthly",
                leadingIcon: IconButton(
                  icon:
                      Icon(Icons.call_end_outlined), // Burada Icon bir IconData
                  onPressed: () {
                    // Buton tıklandığında yapılacak işlemler
                  },
                ),
                
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
