import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../components/buttons/elevated_button/button_type.dart';
import '../../components/vc_product_components.dart';
import '../../utils/color_constant.dart';
import 'modal_popup_configuration.dart';

class ModalPopupHelper {
  static final ModalPopupHelper instance = ModalPopupHelper._instance();

  factory ModalPopupHelper() {
    return instance;
  }

  ModalPopupHelper._instance();

  /// Configuration instance
  ModalConfiguration _configuration = ModalConfiguration();

  /// Method to set the configuration
  void setConfiguration(ModalConfiguration configuration) {
    _configuration = configuration;
  }

  /// Method to show a modal with HTML content
  void showHtmlModal(BuildContext context, String htmlContent,
      {Color? surfaceTintColor,
      double? borderRadius,
      double? modalWidth,
      Widget? titleWidget,
      String? title,
      EdgeInsets? insetPadding,
      EdgeInsetsGeometry? modalPadding,
      double? minHeight,
      double? maxHeight,
      bool? hasCancelButton,
      bool? hasCloseButton,
      bool? hasConfirmButton,
      String? cancelButtonText,
      String? confirmButtonText,
      Function()? onClose,
      Function()? onConfirm,
      Function()? onCancel}) {
    showWidgetModal(
        context,
        Wrap(children: [
          if (title != null)
            Padding(
              padding: _configuration.modalPadding,
              child: Text(
                title,
                style: _configuration.titleStyle,
              ),
            )
          else if (titleWidget != null)
            titleWidget,
          Html(
            data: htmlContent,
          ),
        ]),
        surfaceTintColor: surfaceTintColor,
        borderRadius: borderRadius,
        modalWidth: modalWidth,
        insetPadding: insetPadding,
        modalPadding: modalPadding,
        minHeight: minHeight,
        maxHeight: maxHeight,
        hasCancelButton: hasCancelButton,
        hasConfirmButton: hasConfirmButton,
        hasCloseButton: hasCloseButton,
        cancelButtonText: cancelButtonText,
        confirmButtonText: confirmButtonText,
        onClose: onClose,
        onConfirm: onConfirm,
        onCancel: onCancel);
  }

  /// Method to show a modal with a custom widget
  void showWidgetModal(BuildContext context, Widget content,
      {Color? surfaceTintColor,
      Color? backgroundColor,
      double? borderRadius,
      double? modalWidth,
      EdgeInsets? insetPadding,
      EdgeInsetsGeometry? modalPadding,
      double? minHeight,
      double? maxHeight,
      bool? hasCancelButton,
      bool? hasCloseButton,
      bool? hasConfirmButton,
      String? cancelButtonText,
      String? confirmButtonText,
      Function()? onClose,
      Function()? onConfirm,
      Function()? onCancel}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        const EdgeInsets defaultInsetPadding =
            EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);

        return Dialog(
          insetPadding: insetPadding ?? defaultInsetPadding,
          backgroundColor: backgroundColor ?? _configuration.surfaceTintColor,

          /// Applying customizations using parameters or defaults if null
          surfaceTintColor: surfaceTintColor ?? _configuration.surfaceTintColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                borderRadius ?? _configuration.borderRadius),
          ),
          child: Stack(
            children: [
              Container(
                margin: hasCloseButton ?? _configuration.hasCloseButton
                    ? const EdgeInsets.only(top: 20)
                    : null,
                constraints: BoxConstraints(
                    minHeight: minHeight ?? _configuration.minHeight,
                    maxHeight:
                        maxHeight ?? MediaQuery.of(context).size.height * 0.9),
                width: modalWidth ?? _configuration.modalWidth,
                padding: modalPadding ?? _configuration.modalPadding,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      content,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (hasConfirmButton ??
                              _configuration.hasConfirmButton) ...[
                            VCProductComponents.elevatedButton(
                              backgroundColor:
                                  VCProductColors.instance.activeTileColor,
                              onPressed: () {
                                Navigator.of(context).pop();
                                onConfirm!() ?? _configuration.onConfirm!();
                              },
                              text: confirmButtonText ??
                                  _configuration.confirmButtonText,
                            ),
                          ],
                          if (hasCancelButton ??
                              _configuration.hasCancelButton) ...[
                            VCProductComponents.elevatedButton(
                              type: ButtonType.outlined,
                              backgroundColor: Colors.white,
                              borderColor:
                                  VCProductColors.instance.activeTileColor,
                              onPressed: onCancel ??
                                  _configuration.onCancel ??
                                  () {
                                    //TODO cancel onPressed
                                    Navigator.of(context).pop();
                                  },
                              text: cancelButtonText ??
                                  _configuration.cancelButtonText,
                            ),
                          ],
                        ],
                      )
                    ],
                  ),
                ),
              ),
              if (hasCloseButton ?? _configuration.hasCloseButton) ...[
                Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.close,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )),
              ],
            ],
          ),
        );
      },
    );
  }
}
