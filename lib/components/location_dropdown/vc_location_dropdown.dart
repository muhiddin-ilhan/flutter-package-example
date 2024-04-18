// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vc_product_widgets/helper/loading_spinner/vc_loading_spinner.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';

import '../../utils/color_constant.dart';
import '../buttons/vc_button/vc_button.dart';
import '../text/typography_type.dart';
import '../text/vc_product_text.dart';
import '../vc_product_components.dart';

class VcLocationDropdown {
  static final Color bottomSheetBGColor =
      VCProductColors.instance.bottomSheetBGColor;
  static final Color textColor = VCProductColors.instance.widgetTextColor;

  static void showCustomBottomSheet(
      {required BuildContext context,
      String title = "Location",
      Function(double? latitude, double? longitude, bool isSuccess)?
          onLocation}) {
    showModalBottomSheet(
      backgroundColor: bottomSheetBGColor,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter modalSetState) {
          return SafeArea(
            bottom: false,
            top: true,
            child: Padding(
              padding: context.paddingNormal.copyWith(
                bottom: MediaQuery.of(context).viewInsets.bottom +
                    context.normalValue * 2,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getBottomSheetTitleWidget(context, title),
                  context.emptySizedHeightBoxLow,
                  Container(
                    decoration: BoxDecoration(
                      color: VCProductColors.instance.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: context.paddingNormal,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const VCProductText(
                          text: "Would you like to turn your location on?",
                          type: TypographyType.bodyMedium14,
                        ),
                        context.emptySizedHeightBoxNormal,
                        VCProductComponents.vcButton(
                          buttonSize: VCButtonSize.large,
                          onTap: () async {
                            if (await _handleLocationPermission(context)) {
                              Position position =
                                  await Geolocator.getCurrentPosition(
                                      desiredAccuracy: LocationAccuracy.high);
                              debugPrint(position.toString());
                              onLocation?.call(
                                  position.latitude, position.longitude, true);
                            } else {
                              onLocation?.call(null, null, false);
                            }
                            Navigator.pop(context);
                          },
                          buttonType: VCButtonType.primary,
                          child: VCProductComponents.text(
                            text: "Yes",
                            textColor: VCProductColors.instance.white,
                            typographyType: TypographyType.bodyRegular14,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  static SizedBox getBottomSheetTitleWidget(
      BuildContext context, String title) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: InkWell(
              child: const VCProductText(
                text: "Close",
                type: TypographyType.smallText,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Center(
            child: VCProductText(
              text: title,
              type: TypographyType.placeholder,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  static Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    VCLoadingSpinner.show();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      VCLoadingSpinner.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        VCLoadingSpinner.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      VCLoadingSpinner.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    VCLoadingSpinner.dismiss();
    return true;
  }

  static double distanceInMeters(
      double lat1, double lat2, double lon1, double lon2) {
    return Geolocator.distanceBetween(
      lat1,
      lon1,
      lat2,
      lon2,
    );
  }
}
