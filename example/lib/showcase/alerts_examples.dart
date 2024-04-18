import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/alerts/vc_product_alerts.dart';
import 'package:vc_product_widgets/components/buttons/elevated_button/button_size.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

class AlertsExamples extends StatefulWidget {
  const AlertsExamples({super.key});

  @override
  State<AlertsExamples> createState() => _AlertsExamplesState();
}

class _AlertsExamplesState extends State<AlertsExamples> {
  Widget resultPanel = Container();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alerts Examples"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            children: [
          resultPanel,
          VCProductComponents.elevatedButton(
            size: ButtonSize.large,
            text: "Success",
            backgroundColor: VCProductColors.instance.alertSuccessDarkColor,
            onPressed: () {
              setState(() {
                resultPanel = VCProductAlerts.success(
                    context: context, message: "Success", title: "Headline");
              });
            },
          ),
          VCProductComponents.elevatedButton(
            size: ButtonSize.large,
            text: "Warning",
            backgroundColor: VCProductColors.instance.alertWarningDarkColor,
            onPressed: () {
              setState(() {
                resultPanel = VCProductAlerts.warning(
                    context: context, message: "Warning");
              });
            },
          ),
          VCProductComponents.elevatedButton(
            size: ButtonSize.large,
            text: "Error",
            backgroundColor: VCProductColors.instance.alertErrorDarkColor,
            onPressed: () {
              setState(() {
                resultPanel =
                    VCProductAlerts.error(context: context, message: "Error");
              });
            },
          ),
          VCProductComponents.elevatedButton(
            size: ButtonSize.large,
            text: "Info",
            backgroundColor: VCProductColors.instance.alertInfoDarkColor,
            onPressed: () {
              setState(() {
                resultPanel =
                    VCProductAlerts.info(context: context, message: "Info");
              });
            },
          ),
          VCProductComponents.elevatedButton(
            size: ButtonSize.large,
            text: "Snackbar",
            backgroundColor: VCProductColors.instance.snackbarBackgroundColor,
            onPressed: () {
              VCProductAlerts.showSnackBar(
                context: context,
                message: "Info",
                action: SnackBarAction(
                  label: "Close",
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              );
            },
          ),
          VCProductComponents.elevatedButton(
            size: ButtonSize.large,
            text: "Popup",
            backgroundColor: VCProductColors.instance.grey,
            onPressed: () {
              VCProductAlerts.showCustomDialog(
                  context: context,
                  message:
                      "'The Cash Code is an identifier which we issue to you on your request which is to be used to make Cardless Cash ATM withdrawals.'",
                  title: "Information Headline");
            },
          ),
        ]
                .map((e) =>
                    Padding(padding: const EdgeInsets.all(4.0), child: e))
                .toList()),
      ),
    );
  }
}
