import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/timeout/vc_product_timeout.dart';

class TimeoutPopupExample extends StatefulWidget {
  const TimeoutPopupExample({Key? key}) : super(key: key);

  @override
  State<TimeoutPopupExample> createState() => _TimeoutPopupExampleState();
}

class _TimeoutPopupExampleState extends State<TimeoutPopupExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "TIMEOUT",
      )),
      body: VCProductTimeout(
        secondsText: "Seconds",
        duration: 35,
        title: "SESSION TIMEOUT",
        description:
            "Dear customer, you've been inactive for a while. \n For your security, we'll automatically sign you out.",
        primaryButtonText: "Stayed Logged In",
        secondaryButtonText: "Logout",
        onPrimaryButtonTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text("Primary Button Tapped"),
                );
              });
        },
        onSecondaryButtonTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text("Secondary Button Tapped"),
                );
              });
        },
        onTimeOut: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text("Timeout"),
                );
              });
        },
      ),
    );
  }
}
