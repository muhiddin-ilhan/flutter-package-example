import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import '../../components/qr_scan/qr_scanner_view.dart';

/// A helper class for scanning QR codes using camera or gallery images.
class QrScannerHelper {
  /// Singleton instance of the [QrScannerHelper] class.
  static final QrScannerHelper instance = QrScannerHelper._instance();

  /// Factory constructor to return the singleton instance.
  factory QrScannerHelper() {
    return instance;
  }

  /// Private constructor for the singleton.
  QrScannerHelper._instance();

  /// List of barcode formats to scan (only QR codes in this case).
  final List<BarcodeFormat> formats = [
    BarcodeFormat.qrCode,
  ];

  /// BarcodeScanner instance with specified formats.
  late final BarcodeScanner barcodeScanner = BarcodeScanner(
    formats: formats,
  );

  /// Shows a bottom sheet with options to scan QR code using camera or gallery.
  ///
  /// [context]: The [BuildContext] of the widget calling this method.
  /// [onScannerResult]: Callback function to handle the scanned QR code.
  /// [infoText]: Optional text to display additional information.
  void showQrScannerBottomSheet(BuildContext context, ValueChanged<String> onScannerResult, {String? infoText}) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // ListTile to scan QR code using camera
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Scan With Camera"),
              onTap: () async {
                Navigator.pop(context);
                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  useRootNavigator: true,
                  barrierColor: Colors.transparent,
                  builder: (context) => VCQrScannerView(
                    infoText: infoText,
                    onScannerResult: onScannerResult,
                  ),
                );
              },
            ),
            // ListTile to select an image from gallery and scan QR code
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Select From Gallery"),
              onTap: () async {
                InputImage? inputImage = await _openFileExplorer();
                if(inputImage!=null){
                  String? qrCode = await scanQr(inputImage);

                  if (qrCode != null) {
                    await dispose().then((value) {
                      Navigator.of(context).pop();
                      onScannerResult.call(qrCode);
                    });
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  /// Opens file explorer to pick an image from gallery.
  ///
  /// Returns the selected image as [InputImage].
  Future<InputImage?> _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
      type: FileType.custom,
    );

    if (result != null) {
      if (result.files.isNotEmpty) {
        String path = result.files.single.path!;
        File file = File(path);

        InputImage inputImage = InputImage.fromFile(file);

        return inputImage;
      }
    }
    return null;
  }

  /// Scans QR code from the provided input image.
  ///
  /// [inputImage]: The image containing the QR code to be scanned.
  Future<String?> scanQr(InputImage inputImage) async {
    String? qrCode;
    final codes = await barcodeScanner.processImage(inputImage);

    for (Barcode barcode in codes) {
      String text = barcode.rawValue ?? '';
      qrCode = text;
      break;
    }
    return qrCode;
  }

  /// Disposes the barcode scanner instance.
  Future dispose() async {
    await barcodeScanner.close();
  }
}