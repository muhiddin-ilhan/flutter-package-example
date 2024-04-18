import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

//Todo resources should be added to the page and link should be edited according to the distibution link
class VCProductUpdatePopup extends StatefulWidget {
  const VCProductUpdatePopup({Key? key, required this.isForceUpdate}) : super(key: key);

  final bool isForceUpdate;

  @override
  State<VCProductUpdatePopup> createState() => _VCProductUpdatePopupState();
}

class _VCProductUpdatePopupState extends State<VCProductUpdatePopup> {
  final Uri _androidDistributionUrl = Uri.parse( 'https://install.appcenter.ms/orgs/Mobile.Native.Banking/apps/MNP-Android/distribution_groups/public');
  final Uri  _iosDistributionUrl = Uri.parse('https://install.appcenter.ms/orgs/mobile.native.banking/apps/mnp-ios/distribution_groups/public/releases/244');

  final Color _textColor = VCProductColors.instance.widgetTextColor;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter modalSetState) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.32,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                // Helper method to get the title widget
                _getBottomSheetTitleWidget(widget.isForceUpdate ? "Upgrade Required" : "Updated Version Available"),

                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: VCProductColors.instance.white,
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.isForceUpdate
                            ? "Your current version is no longer supported.\nPlease download the updated version by clicking on the upgrade button."
                            : "An updated version is available for download.\nPlease upgrade it if you want to avail more features.",
                        style: TextStyle(color: _textColor, fontWeight: FontWeight.w500, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      // Button widget for force update
                      if (widget.isForceUpdate)
                        _forceUpdateButton()
                      else
                        // Buttons widget for optional update
                        _updateButtons(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper method to get the title widget
  Widget _getBottomSheetTitleWidget(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 8, left: 8),
      child: Text(
        title,
        style: TextStyle(color: _textColor, fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }

  // Button widget for force update
  Widget _forceUpdateButton() {
    return VCButton(
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: VCProductColors.instance.activeTileColor,
      buttonType: VCButtonType.primary,
      onTap: () {
        // Launch App Center when the upgrade button is pressed
        _launchAppCenter();
      },
      child: const Text("Upgrade"),
    );
  }

  // Buttons widget for optional update
  Widget _updateButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Cancel button
        VCButton(
          width: MediaQuery.of(context).size.width * 0.4,
          backgroundColor: VCProductColors.instance.backgroundGray,
          buttonType: VCButtonType.secondary,
          onTap: () {
            // Canceled the update
            Navigator.pop(context);
          },
          child: Text("Cancel", style: TextStyle(color: VCProductColors.instance.widgetTextColor)),
        ),

        // Update button
        VCButton(
          width: MediaQuery.of(context).size.width * 0.4,
          backgroundColor: VCProductColors.instance.activeTileColor,
          buttonType: VCButtonType.primary,
          onTap: () {
            // Launch App Center when the update button is pressed
            _launchAppCenter();
          },
          child: const Text("Update"),
        ),
      ],
    );
  }

  // Method to launch App Center
  _launchAppCenter() async {
    if (Platform.isAndroid) {
      if (!await launchUrl(_androidDistributionUrl)) {
        throw Exception('Could not launch $_androidDistributionUrl');
      }
    } else if (Platform.isIOS) {
      if (!await launchUrl(_iosDistributionUrl)) {
        throw Exception('Could not launch $_iosDistributionUrl');
      }
    }
  }

}
