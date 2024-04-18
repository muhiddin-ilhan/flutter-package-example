import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';
import 'package:vc_product_widgets/components/text/vc_font_weight.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

class TextShowcase extends StatefulWidget {
  const TextShowcase({super.key});

  @override
  State<TextShowcase> createState() => _TextShowcaseState();
}

class _TextShowcaseState extends State<TextShowcase> {
  final List<double> fontSizes = [12,13,14,15,16,17,18,19,20,22,24,26,28,30,32,34,36];
  final List<Map<String, dynamic>> fontWeightsData = [
    {"text": "Light", "weight": VCFontWeights.light},
    {"text": "Regular", "weight": VCFontWeights.regular},
    {"text": "Medium", "weight": VCFontWeights.medium},
    {"text": "SemiBold", "weight": VCFontWeights.semiBold},
    {"text": "Bold", "weight": VCFontWeights.bold},
    {"text": "Black", "weight": VCFontWeights.black},
  ];

  final List<TypographyData> inputTypographyData = [
    TypographyData(
      text: "15pt Regular",
      type: "Label",
      typographyType: TypographyType.label,
    ),
    TypographyData(
      text: "15pt Semi-Bold",
      type: "Placeholder",
      typographyType: TypographyType.placeholder,
    ),
    TypographyData(
      text: "15pt Bold",
      type: "Placeholder - Amount",
      typographyType: TypographyType.placeholder,
    ),
    TypographyData(
      text: "32pt Bold",
      type: "Amount Large",
      typographyType: TypographyType.placeholderAmountLarge,
    ),
    TypographyData(
      text: "12pt Regular",
      type: "Small Text",
      typographyType: TypographyType.smallText,
    ),
    TypographyData(
      text: "12pt Regular",
      type: "Validation",
      typographyType: TypographyType.validation,
    ),
  ];

  final List<TypographyData> btnTypographyData = [
    TypographyData(
      text: "18pt Semi-bold",
      type: "Large",
      typographyType: TypographyType.btnLarge,
    ),
    TypographyData(
      text: "16pt Semi-Bold",
      type: "Medium",
      typographyType: TypographyType.btnMedium,
    ),
    TypographyData(
      text: "13pt Medium",
      type: "Small",
      typographyType: TypographyType.btnSmall,
    ),
    TypographyData(
      text: "12pt Semi-bold",
      type: "Tab",
      typographyType: TypographyType.btnTab,
    )
  ];

  final List<TypographyData> hyperlinkTypographyData = [
    TypographyData(
      text: "14pt Semi-bold",
      type: "X-Large",
      typographyType: TypographyType.hyperlinkXLarge,
    ),
    TypographyData(
      text: "16pt Semi-Bold",
      type: "Small",
      typographyType: TypographyType.hyperlinkSmall,
    ),
  ];

  final List<TypographyData> allCapsTypographyData = [
    TypographyData(
      text: "8pt bold",
      type: "Small",
      typographyType: TypographyType.allCapsSmall,
    ),
    TypographyData(
      text: "10pt Medium",
      type: "Medium",
      typographyType: TypographyType.allCapsMedium,
    ),
    TypographyData(
      text: "12pt Medium",
      type: "Large",
      typographyType: TypographyType.allCapsLarge,
    ),
    TypographyData(
      text: "14pt Medium",
      type: "X-Large",
      typographyType: TypographyType.allCapsXLarge,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        title: const Text("Text Showcase"),
        backgroundColor: VCProductColors.instance.navyBlue,
        foregroundColor: VCProductColors.instance.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              VCProductComponents.text(
                  text: "Body",
                  typographyType: TypographyType.bodyBlack14),
              buildBody14(),
              const Divider(),
              buildBody16(),
              const Divider(),
              VCProductComponents.text(
                  text: "Input",
                  typographyType: TypographyType.bodyBlack14),
              buildTypographyDataList(inputTypographyData),
              const Divider(),
              VCProductComponents.text(
                  text: "Button",
                  typographyType: TypographyType.bodyBlack14),
              buildTypographyDataList(btnTypographyData),
              const Divider(),
              VCProductComponents.text(
                  text: "Hyperlink",
                  typographyType: TypographyType.bodyBlack14),
              buildTypographyDataList(hyperlinkTypographyData),
              const Divider(),
              VCProductComponents.text(
                  text: "AllCaps",
                  typographyType: TypographyType.bodyBlack14),
              buildTypographyDataList(allCapsTypographyData),
              const Divider(),
              buildFontWeightDataList()
            ],
          ),
        ),
      ),
    );
  }

  Column buildFontWeightDataList() {
    return Column(
      children: fontWeightsData.map((data) {
        return Column(
          children: [
            VCProductComponents.text(
                text: data["text"],
                typographyType: TypographyType.bodyBlack14),
            Column(
              children: fontSizes.map((size) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VCProductComponents.text(
                        text:  size.toInt().toString(), fontWeight: data["weight"] , fontSize: size),
                    VCProductComponents.text(
                        text: data["text"] + " Text", fontWeight: data["weight"], fontSize: size),
                  ],
                );
              }).toList(),
            ),
          ],
        );
      }).toList(),
    );
  }

  Column buildTypographyDataList(List<TypographyData> dataList) {
    return Column(
      children: dataList.map((data) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            VCProductComponents.text(
                text: data.text, typographyType: data.typographyType),
            VCProductComponents.text(
                text: data.type, typographyType: data.typographyType),
          ],
        );
      }).toList(),
    );
  }

  Row buildBody14() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        VCProductComponents.text(text: "14pt"),
        Column(
          children: [
            VCProductComponents.text(
                text: "Light Body Text",
                typographyType: TypographyType.bodyLight14),
            VCProductComponents.text(
                text: "Regular Body Text",
                typographyType: TypographyType.bodyRegular14),
            VCProductComponents.text(
                text: "Medium Body Text",
                typographyType: TypographyType.bodyMedium14),
            VCProductComponents.text(
                text: "Semi-Bold Body Text",
                typographyType: TypographyType.bodySemiBold14),
            VCProductComponents.text(
                text: "Bold Body Text",
                typographyType: TypographyType.bodyBold14),
            VCProductComponents.text(
                text: "Black Body Text",
                typographyType: TypographyType.bodyBlack14),
          ],
        )
      ],
    );
  }

  Row buildBody16() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        VCProductComponents.text(text: "16pt"),
        Column(
          children: [
            VCProductComponents.text(
                text: "Light Body Text",
                typographyType: TypographyType.bodyLight16),
            VCProductComponents.text(
                text: "Regular Body Text",
                typographyType: TypographyType.bodyRegular16),
            VCProductComponents.text(
                text: "Medium Body Text",
                typographyType: TypographyType.bodyMedium16),
            VCProductComponents.text(
                text: "Semi-Bold Body Text",
                typographyType: TypographyType.bodySemiBold16),
            VCProductComponents.text(
                text: "Bold Body Text",
                typographyType: TypographyType.bodyBold16),
            VCProductComponents.text(
                text: "Black Body Text",
                typographyType: TypographyType.bodyBlack16),
          ],
        )
      ],
    );
  }

  Widget space(double val) {
    return SizedBox(height: val);
  }
}

class TypographyData {
  final String text;
  final String type;
  final TypographyType typographyType;

  TypographyData({
    required this.text,
    required this.type,
    required this.typographyType,
  });
}
