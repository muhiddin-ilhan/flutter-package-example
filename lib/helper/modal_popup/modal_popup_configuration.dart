import 'package:flutter/material.dart';

/// Configuration model class
class ModalConfiguration {
  /// Background color of the dialog
  Color surfaceTintColor;

  /// Border radius of the dialog
  double borderRadius;

  /// Width of the dialog
  double modalWidth;

  /// Padding inside the dialog
  EdgeInsetsGeometry modalPadding;

  /// Minimum height of the dialog
  double minHeight;

  /// Whether has cancel button or not
  bool hasCancelButton;

  /// Whether has close button or not
  bool hasCloseButton;

  /// Whether has confirm button or not
  bool hasConfirmButton;

  /// Title Style
  TextStyle titleStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black);

  /// Localized cancelButtonText string. Default is “Cancel”
  String cancelButtonText = "Cancel";

  /// Localized confirmButtonText string. Set as “Confirm” by default
  String confirmButtonText = "Confirm";

  /// Emits when confirm button is clicked
  Function()? onConfirm;

  /// Emits when close button is clicked
  Function()? onClose;

  /// Emits when cancel button is clicked
  Function()? onCancel;

  /// Constructor with default values
  ModalConfiguration({
    this.surfaceTintColor = Colors.white,
    this.borderRadius = 8.0,
    this.modalWidth = 300.0,
    this.modalPadding = const EdgeInsets.all(10.0),
    this.minHeight = 300.0,
    this.hasCancelButton = false,
    this.hasCloseButton = false,
    this.hasConfirmButton = false,
    this.cancelButtonText = "Cancel",
    this.confirmButtonText = "Confirm",
    this.titleStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
    this.onClose,
    this.onConfirm,
    this.onCancel
  });
}