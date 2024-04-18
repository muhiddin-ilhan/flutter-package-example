import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';
import 'package:vc_product_widgets/components/text/vc_product_text.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/utils/vc_icons.dart';

class TransactionHistoryListItem extends StatelessWidget {
  final bool isReceiveTransaction;
  final String description;
  final String? descriptionDetail;
  final DateTime? date;
  final String amount;
  final bool isRepeatable;
  final bool hasForwardArrow;
  final Function() onRepeatTap;
  final Function() onTap;

  const TransactionHistoryListItem({
    super.key,
    required this.isReceiveTransaction,
    required this.description,
    this.date,
    this.descriptionDetail,
    this.hasForwardArrow = true,
    required this.amount,
    required this.isRepeatable,
    required this.onRepeatTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: context.paddingNormal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: context.paddingLow * .7,
              margin: EdgeInsets.only(top: context.lowValue * .4),
              height: context.allWidth * 0.08,
              decoration: BoxDecoration(
                color: isReceiveTransaction ? VCProductColors.instance.badgeBlueBgColor : VCProductColors.instance.badgeRedBgColor,
                borderRadius: context.lowBorderRadius,
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Icon(isReceiveTransaction ? Icons.arrow_downward : Icons.arrow_upward, size: context.highValue),
              ),
            ),
            context.emptySizedWidthBoxLow,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: VCProductText(
                          text: description,
                          type: TypographyType.bodyMedium14,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                      ),
                      if(hasForwardArrow) Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: context.normalValue * .75,
                        color: VCProductColors.instance.backgroundGradientStart,
                      ),
                    ],
                  ),
                  if(descriptionDetail != null )VCProductText(
                    text: descriptionDetail!,
                    type: TypographyType.bodyLight14,
                    fontSize: 13,
                  ),
                  if(date != null )VCProductText(
                    text: DateFormat('dd MMM yyyy').format(date!),
                    type: TypographyType.bodyLight14,
                    fontSize: 13,
                  ),
                  Row(
                    children: [
                      if (isRepeatable)
                        GestureDetector(
                          onTap: () => onRepeatTap(),
                          child: Row(
                            children: [
                              VCProductText(
                                text: "Repeat",
                                type: TypographyType.bodyLight14,
                                fontWeight: FontWeight.w400,
                                textColor: VCProductColors.instance.backgroundGradientStart,
                              ),
                              context.emptySizedWidthBoxSemiLow,
                              VCIcons.ic_repeat_finance,
                            ],
                          ),
                        ),
                      const Spacer(),
                      VCProductText(
                        text: "${isReceiveTransaction ? "" : "-"}$amount",
                        type: TypographyType.placeholderAmountLarge,
                        fontSize: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
