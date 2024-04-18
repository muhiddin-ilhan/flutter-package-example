import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

/// A class that provides utility methods for displaying different types of alerts and snack bars.
class VCProductOTP {
  /// Private constructor to prevent instantiation
  VCProductOTP._();

  /// Returns a success alert widget.
  ///
  /// The [context] parameter is the build context.
  /// The [message] parameter is the message to be displayed in the alert.
  /// The [title] parameter is an optional title for the alert.
 





  

  /// Displays a custom dialog.
  ///
  /// The [context] parameter is the build context.
  /// The [title] parameter is an optional title for the dialog.
  /// The [message] parameter is the message to be displayed in the dialog.
  static void showOTPDialog(
      {required BuildContext context, String? title, required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the dialog compact
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Icon(Icons.info,
                          color: VCProductColors.instance.popupInfoIconColor),
                    ),
                    Expanded(
                      child: Text(
                        title ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    message,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}
