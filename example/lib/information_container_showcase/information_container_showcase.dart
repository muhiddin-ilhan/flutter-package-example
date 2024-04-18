import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class InformationContainerShowcase extends StatefulWidget {
  const InformationContainerShowcase({super.key});

  @override
  State<InformationContainerShowcase> createState() => _InformationContainerShowcaseState();
}

class _InformationContainerShowcaseState extends State<InformationContainerShowcase> {
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: VCProductColors.instance.navyBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              confirmationContainerWithHeader(
                header: "PERSONAL DETAILS",
                children: const [
                  VCInformationItem(text: "First Name", value: "Muhiddin"),
                  VCInformationItem(text: "Last Name", value: "İlhan"),
                  VCInformationItem(text: "NickName", value: "Sepulchral"),
                  VCInformationItem(text: "Relation with Recipient", value: "Colleague"),
                ],
              ),
              space,
              confirmationContainerWithHeader(
                header: "ACCOUNT DETAILS",
                children: const [
                  VCInformationItem(text: "Western Union Number", value: "00953 020125659"),
                ],
              ),
              space,
              multiInformationContainer(
                children: [
                  VCInformationContainer(
                    seperatorWidget: space,
                    informationItemList: const [
                      VCInformationItem(text: "IBAN", value: "GB 01 WNSA 00953 02989843", itemType: InformationItemType.iban),
                    ],
                  ),
                  divider,
                  VCInformationContainer(
                    seperatorWidget: space,
                    informationItemList: const [
                      VCInformationItem(text: "Next Payment Amount", value: "\$1,690.58"),
                      VCInformationItem(text: "Next Payment Due", value: "19 Apr 2023"),
                      VCInformationItem(text: "Outstanding Amount", value: "\$3,600.00"),
                    ],
                  ),
                  Visibility(visible: _showMore, child: divider),
                  Visibility(
                    visible: _showMore,
                    child: VCInformationContainer(
                      seperatorWidget: space,
                      informationItemList: const [
                        VCInformationItem(text: "Nickname", value: "MY VIRTUAL CARD", itemType: InformationItemType.editable),
                        VCInformationItem(text: "CVV", value: "767", itemType: InformationItemType.cvv),
                        VCInformationItem(text: "Total Card Limit", value: "\$5,000.00"),
                        VCInformationItem(text: "Reward Points", value: "9152"),
                      ],
                    ),
                  ),
                ],
              ),
              space,
              VCProductComponents.vcButton(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget confirmationContainerWithHeader({required String header, required List<VCInformationItem> children}) {
    return VCInformationContainer(
      seperatorWidget: const SizedBox(height: 20),
      containerPadding: const EdgeInsets.all(16),
      containerDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      headerText: header,
      informationItemList: children,
    );
  }

  Widget multiInformationContainer({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...children,
          const SizedBox(height: 20),
          VCProductComponents.vcButton(
            buttonType: VCButtonType.secondary,
            onTap: () {
              setState(() {
                _showMore = !_showMore;
              });
            },
            child: Row(
              children: [
                Icon(_showMore ? Icons.close : Icons.expand_circle_down_outlined),
                const SizedBox(width: 4),
                Text(_showMore ? "Close" : "Show More"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get divider {
    return const Divider(
      color: Color.fromARGB(255, 235, 237, 238),
      height: 40,
    );
  }

  Widget get space {
    return const SizedBox(height: 20);
  }

  Widget get space2 {
    return const SizedBox(height: 40);
  }
}
