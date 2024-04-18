import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/buttons/elevated_button/button_size.dart';
import 'package:vc_product_widgets/components/qr_scan/qr_scanner_view.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/helper/qr_scan/qr_scanner_helper.dart';

class QrShowcase extends StatefulWidget {
  const QrShowcase({Key? key}) : super(key: key);

  @override
  State<QrShowcase> createState() => _QrShowcaseState();
}

class _QrShowcaseState extends State<QrShowcase> {

  String? qrCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Qr Scanner Showcase",
      )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            runSpacing: 20,
            children: [
              VCProductComponents.text(
                text: "Qr Code: $qrCode",
                typographyType: TypographyType.bodyBlack16,
              ),
              VCProductComponents.elevatedButton(
                size: ButtonSize.large,
                text: "Qr Scanner",
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    useRootNavigator: true,
                    barrierColor: Colors.transparent,
                    builder: (context) => VCQrScannerView(
                      infoText: "Align the QR code on the bill inside the frame to fill in the bill payment information.",
                      onScannerResult: (String value) {
                        debugPrint("qr value : $value");
                        qrCode = value;
                        setState(() {});
                      }

                    ),
                  );
                },
              ),
              VCProductComponents.elevatedButton(
                size: ButtonSize.large,
                text: "Bottom Sheet",
                onPressed: () {
                  QrScannerHelper.instance.showQrScannerBottomSheet(context, (value)  {
                    debugPrint("qr value : $value");
                    qrCode = value;
                    setState(() {});
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
