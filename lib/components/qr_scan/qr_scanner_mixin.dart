import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

/// A mixin providing utility methods for QR code scanning using camera.
mixin QRScannerMixin {
  CameraController? controller; // Camera controller instance
  bool? canProcess; // Flag to indicate if QR code processing is enabled
  bool isBusy = false; // Flag to indicate if the scanner is busy
  String? qrCode; // Scanned QR code
  bool isQrScanned = false; // Flag to indicate if a QR code is scanned

  /// Checks if the camera flash is currently on.
  bool get isFlashOn => controller?.value.flashMode == FlashMode.torch;

  /// Stops the live camera feed.
  Future<void> stopLiveFeed() async {
    canProcess = false;
    if (controller?.value.isInitialized == true) {
      controller?.setFlashMode(FlashMode.off);
      await controller?.stopImageStream();
    }
  }

  /// Widget for toggling camera flash.
  Widget get cameraFlash {
    return StatefulBuilder(builder: (context, setState) {
      return IconButton(
        onPressed: () async {
          await controller
              ?.setFlashMode(isFlashOn ? FlashMode.off : FlashMode.torch);
          setState(() {});
        },
        icon: Icon(
          isFlashOn ? Icons.flash_on : Icons.flash_off,
        ),
        iconSize: 24.0,
      );
    });
  }

  /// Map of device orientations to rotation values.
  final Map<DeviceOrientation, int> _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  /// Processes the camera image for QR code scanning.
  InputImage? processCameraImage(CameraDescription camera, CameraImage image) {
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation = _orientations[
      controller?.value.deviceOrientation ?? DeviceOrientation.portraitUp];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);

    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // Since format is constrained to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    final Size imageSize = Size(
      image.width.toDouble(),
      image.height.toDouble(),
    );

    final InputImageMetadata inputImageMetadata = InputImageMetadata(
      size: imageSize,
      rotation: rotation,
      format: format,
      bytesPerRow: image.planes.first.bytesPerRow,
    );

    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: inputImageMetadata,
    );
  }
}
