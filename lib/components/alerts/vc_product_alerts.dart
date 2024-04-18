import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/buttons/vc_button/vc_button.dart';
import 'package:vc_product_widgets/components/inputs/vc_base_text_field.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';
import 'package:vc_product_widgets/components/text/vc_product_text.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

/// A class that provides utility methods for displaying different types of alerts and snack bars.
class VCProductAlerts {
  /// Private constructor to prevent instantiation
  VCProductAlerts._();

  /// Returns a success alert widget.
  ///
  /// The [context] parameter is the build context.
  /// The [message] parameter is the message to be displayed in the alert.
  /// The [title] parameter is an optional title for the alert.
  static Widget success({
    required BuildContext context,
    required String message,
    String? title,
  }) {
    return _getAlert(
      context,
      message: message,
      title: title,
      textBackgroundColor: VCProductColors.instance.alertSuccessLightColor,
      icon: Icons.check_circle_outline,
      backgroundColor: VCProductColors.instance.alertSuccessDarkColor,
      textColor: VCProductColors.instance.alertSuccessTextColor,
    );
  }

  /// Returns an error alert widget.
  ///
  /// The [context] parameter is the build context.
  /// The [message] parameter is the message to be displayed in the alert.
  /// The [title] parameter is an optional title for the alert.
  static Widget error({
    required BuildContext context,
    required String message,
    String? title,
  }) {
    return _getAlert(
      context,
      message: message,
      title: title,
      textBackgroundColor: VCProductColors.instance.alertErrorLightColor,
      icon: Icons.warning_amber,
      backgroundColor: VCProductColors.instance.alertErrorDarkColor,
      textColor: VCProductColors.instance.alertErrorTextColor,
    );
  }

  /// Returns an info alert widget.
  ///
  /// The [context] parameter is the build context.
  /// The [message] parameter is the message to be displayed in the alert.
  /// The [title] parameter is an optional title for the alert.
  static Widget info({
    required BuildContext context,
    required String message,
    String? title,
  }) {
    return _getAlert(
      context,
      message: message,
      title: title,
      textBackgroundColor: VCProductColors.instance.alertInfoLightColor,
      icon: Icons.info_outline,
      backgroundColor: VCProductColors.instance.alertInfoDarkColor,
      textColor: VCProductColors.instance.alertInfoTextColor,
    );
  }

  /// Returns a warning alert widget.
  ///
  /// The [context] parameter is the build context.
  /// The [message] parameter is the message to be displayed in the alert.
  /// The [title] parameter is an optional title for the alert.
  static Widget warning({
    required BuildContext context,
    required String message,
    String? title,
  }) {
    return _getAlert(
      context,
      message: message,
      title: title,
      textBackgroundColor: VCProductColors.instance.alertWarningLightColor,
      icon: Icons.warning_amber,
      backgroundColor: VCProductColors.instance.alertWarningDarkColor,
      textColor: VCProductColors.instance.alertWarningTextColor,
    );
  }

  /// Displays a snack bar.
  ///
  /// The [context] parameter is the build context.
  /// The [message] parameter is the message to be displayed in the snack bar.
  /// The [action] parameter is an optional action to be shown in the snack bar.
  /// The [showCloseIcon] parameter determines whether to show a close icon in the snack bar.
  static void showSnackBar({
    required BuildContext context,
    required String message,
    SnackBarAction? action,
    bool? showPrefixIcon,
    bool? showCloseIcon,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
  }) {
    _showCustomSnackBar(
      context,
      message: message,
      backgroundColor: VCProductColors.instance.snackbarBackgroundColor,
      padding: padding,
      action: action,
      showCloseIcon: showCloseIcon,
    );
  }

  /// Displays a custom dialog.
  ///
  /// The [context] parameter is the build context.
  /// The [title] parameter is an optional title for the dialog.
  /// The [message] parameter is the message to be displayed in the dialog.
  static void showCustomDialog(
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

  /// Displays a custom approval bottom sheet.
  /// The [context] parameter is the build context.
  /// The [title] parameter is the title to be displayed in the bottom sheet.
  /// The [buttonText] parameter is the text to be displayed on the button.
  /// The [closeButtonText] parameter is the text to be displayed on the close button.
  /// The [onTapped] parameter is the function to be called when the button is tapped.
  static void showApproveBottomSheet({
    required BuildContext context,
    required String title,
    required String buttonText,
    required String closeButtonText,
    required Function() onTapped,
  }) {
    showModalBottomSheet(
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
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      closeButtonText,
                      style: TextStyle(color: VCProductColors.instance.black),
                    ),
                  ),
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
                        VCProductText(
                          text: title,
                          type: TypographyType.bodyMedium14,
                        ),
                        context.emptySizedHeightBoxNormal,
                        VCProductComponents.vcButton(
                          backgroundColor:
                              VCProductColors.instance.activeTileColor,
                          buttonSize: VCButtonSize.medium,
                          onTap: onTapped,
                          buttonType: VCButtonType.primary,
                          child: VCProductComponents.text(
                            text: buttonText,
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

  /// Displays an Alert Widget.
  ///   The [context] parameter is the build context.
  ///  The [message] parameter is the message to be displayed in the alert.
  /// The [title] parameter is an optional title for the alert.
  /// The [textBackgroundColor] parameter is the background color of the text.
  /// The [backgroundColor] parameter is the background color of the alert.
  /// The [textColor] parameter is the color of the text.
  /// The [icon] parameter is the icon to be displayed in the alert.
  static Widget _getAlert(
    BuildContext context, {
    required String message,
    String? title,
    required Color textBackgroundColor,
    required Color backgroundColor,
    required Color textColor,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
            child: Icon(icon, color: Colors.white),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: textBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, top: 10, bottom: 10, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (title != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: textColor),
                        ),
                      ),
                    Text(
                      message,
                      style: TextStyle(
                          color: textColor,
                          fontWeight: title == null
                              ? FontWeight.w500
                              : FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Displays a custom snack bar.
  /// The [context] parameter is the build context.
  /// The [message] parameter is the message to be displayed in the snack bar.
  /// The [backgroundColor] parameter is the background color of the snack bar.
  /// The [action] parameter is an optional action to be shown in the snack bar.
  /// The [showCloseIcon] parameter determines whether to show a close icon in the snack bar.
  static void _showCustomSnackBar(BuildContext context,
      {required String message,
      required Color backgroundColor,
      EdgeInsetsGeometry? padding,
      bool? showCloseIcon,
      bool? showPrefixIcon,
      SnackBarAction? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: action,
        shape: context.roundedRectanglAllBorderLow,
        showCloseIcon: showCloseIcon ?? false,
        backgroundColor: backgroundColor,
        padding: padding ?? const EdgeInsets.all(0),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            if(showPrefixIcon == true)...[context.emptySizedWidthBoxLow,
            Icon(
              Icons.done,
              color: VCProductColors.instance.alertSuccessLightColor,
            ),],
            context.emptySizedWidthBoxLow,
            Flexible(
              child: VCProductText(
                text: message,
                type: TypographyType.bodyRegular14,
                textColor: VCProductColors.instance.white,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Displays a custom approval bottom sheet.
  /// The [context] parameter is the build context.
  /// The [pageTitle] parameter is the title to be displayed in the bottom sheet.
  /// The [buttonText] parameter is the text to be displayed on the button.
  /// The [closeButtonText] parameter is the text to be displayed on the close button.
  /// The [onTapped] parameter is the function to be called when the button is tapped.
  /// The [textFieldInitValue] to be set in the input field. default [""]
  /// The [textFieldLabel] text displayed above the input field.
  /// The [textFieldMaxLength] maximum allowed length for the input value.
  /// The [controller] maximum allowed length for the input value.
  static void showChangeBottomSheet({
    required BuildContext context,
    required String pageTitle,
    required String buttonText,
    required String closeButtonText,
    required String textFieldInitValue,
    required String textFieldLabel,
    required int textFieldMaxLength,
    required TextEditingController controller,
    required Function() onTapped,
  }) {
    showModalBottomSheet(
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
                  _changeBottomSheetTitleWidget(
                      closeButtonText, context, pageTitle),
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
                        VCBaseTextField(
                          initValue: textFieldInitValue,
                          label: textFieldLabel,
                          maxLength: textFieldMaxLength,
                          suffixCounterEnabled: true,
                          controller: controller,
                        ),
                        context.emptySizedHeightBoxNormal,
                        VCProductComponents.vcButton(
                          backgroundColor:
                              VCProductColors.instance.activeTileColor,
                          buttonSize: VCButtonSize.medium,
                          onTap: onTapped,
                          buttonType: VCButtonType.primary,
                          child: VCProductComponents.text(
                            text: buttonText,
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

  static Row _changeBottomSheetTitleWidget(
      String closeButtonText, BuildContext context, String pageTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: VCProductText(
            text: closeButtonText,
            type: TypographyType.bodyLight14,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: VCProductText(
            text: pageTitle,
            type: TypographyType.bodyBold16,
            maxLines: 1,
          ),
        ),
        const VCProductText(
          text: "          ",
          type: TypographyType.smallText,
        ),
      ],
    );
  }


  /// Displays a custom approval bottom sheet.
  /// The [context] parameter is the build context.
  /// The [title] parameter is the title to be displayed in the bottom sheet.
  /// The [buttonText] parameter is the text to be displayed on the button.
  /// The [closeButtonText] parameter is the text to be displayed on the close button.
  /// The [onTapped] parameter is the function to be called when the button is tapped.
  static showCustomBottomSheet({
    required BuildContext context,
    required String title,
    required String message,
    required Function() onTappedButtonYes,
    Function()? onTappedButtonNo,
    String? closeButtonText,
    required String buttonTextNo,
    required String buttonTextYes,
  }) {
     showModalBottomSheet(
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
                  getBottomSheetTitleWidget(context, title, closeButtonText: closeButtonText),
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
                        VCProductText(
                          text: message,
                          type: TypographyType.bodyMedium14,
                        ),
                         context.emptySizedHeightBoxNormal,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            VCProductComponents.vcButton(
                              buttonSize: VCButtonSize.medium,
                              width: context.allWidth * 0.4,
                              onTap: onTappedButtonNo ??
                                  () {
                                    Navigator.of(context).pop();
                                  },
                              buttonType: VCButtonType.secondary,
                              child: VCProductComponents.text(
                                text: buttonTextNo ,
                                textColor: VCProductColors.instance.black,
                                typographyType: TypographyType.bodySemiBold16,
                              ),
                            ),
                            VCProductComponents.vcButton(
                              buttonSize: VCButtonSize.medium,
                              width: context.allWidth * 0.4,
                              onTap: onTappedButtonYes,
                              buttonType: VCButtonType.primary,
                              backgroundColor: VCProductColors.instance.activeTileColor,
                              child: VCProductComponents.text(
                                text: buttonTextYes ,
                                textColor: VCProductColors.instance.white,
                                typographyType: TypographyType.bodySemiBold16,
                              ),
                            )
                           ],
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
      BuildContext context, String title, {String? closeButtonText}) {
    return SizedBox(
     width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: InkWell(
              child: VCProductText(
                text: closeButtonText ?? "",
                type: TypographyType.btnSmall400w,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Center(
            child: VCProductText(
              text: title,
              type: TypographyType.bodySemiBold16,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
