import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/inputs/vc_amount_box_field.dart';

class CardLimitWidget extends StatefulWidget {
  final String limit;

  const CardLimitWidget({Key? key, required this.limit}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardLimitWidgetState();
}

class _CardLimitWidgetState extends State<CardLimitWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: VCAmountBoxField(
          
        ));
  }
}
