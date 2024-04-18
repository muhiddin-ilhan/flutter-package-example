import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:vc_product_widgets/components/qr_scan/qr_scanner_clipper.dart';
import 'package:vc_product_widgets/components/qr_scan/qr_scanner_mask.dart';
import 'package:vc_product_widgets/components/qr_scan/qr_scanner_mixin.dart';
import 'package:vc_product_widgets/helper/loading_spinner/vc_loading_spinner.dart';
import 'package:vc_product_widgets/helper/qr_scan/qr_scanner_helper.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

import '../../utils/vc_icons.dart';
import '../text/typography_type.dart';
import '../vc_product_components.dart';

class VCQrScannerView extends StatefulWidget {
  final ValueChanged<String> onScannerResult;
  final bool allowCameraSwitch;
  final String? infoText;
  final String? closeButtonText;
  final bool isCloseButtonVisible;

  const VCQrScannerView(
      {Key? key,
      required this.onScannerResult,
      this.allowCameraSwitch = false,
      this.infoText,
      this.isCloseButtonVisible = true,
      this.closeButtonText})
      : super(key: key);

  @override
  State<VCQrScannerView> createState() => _VCQrScannerViewState();
}

class _VCQrScannerViewState extends State<VCQrScannerView> with QRScannerMixin {
  final QrScannerClipper clipper = QrScannerClipper();
  int cameraIndex = 0;

  List<CameraDescription>? cameras;

  CameraDescription get camera =>
      cameras?[cameraIndex] ??
      const CameraDescription(
        name: "Camera",
        lensDirection: CameraLensDirection.back,
        sensorOrientation: 0,
      );

  @override
  void initState() {
    super.initState();

    try {
      availableCameras().then((value) => setState(() {
            cameras = value;
            initScanner();
          }));
    } catch (e, s) {
      debugPrint(e.toString());
      if (kDebugMode) {
        print(s);
      }
    }
  }

  Future<void> initScanner() async {
    int index =
        cameras!.indexWhere((e) => e.lensDirection == CameraLensDirection.back);
    if (index >= 0) {
      cameraIndex = index;
    }
    await startLiveFeed();
  }

  @override
  void dispose() {
    disposeScanner();
    super.dispose();
  }

  Future<void> disposeScanner() async {
    await QrScannerHelper.instance.dispose();
    await controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameras == null) {
      return const Scaffold(
        body: Center(),
      );
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Theme(
        key: widget.key,
        data: Theme.of(context).copyWith(
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
                color: Colors.transparent,
                foregroundColor: VCProductColors.instance.black,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                titleTextStyle:
                    Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                          color: VCProductColors.instance.black,
                        ),
              ),
        ),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: body(),
          floatingActionButton: floatingActionButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: bottomNavigationBar(),
        ),
      ),
    );
  }

  Widget? bottomNavigationBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      elevation: widget.allowCameraSwitch ? null : 0.0,
      color: widget.allowCameraSwitch ? null : Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          cameraFlash,
        ],
      ),
    );
  }

  Widget? floatingActionButton() {
    if (cameras!.length == 1) return null;
    if (widget.allowCameraSwitch == false) return null;
    return FloatingActionButton(
      onPressed: switchLiveCamera,
      child: Icon(Icons.adaptive.flip_camera_outlined),
    );
  }

  Widget body() {
    return controller?.value.isInitialized == true
        ? Stack(
            children: [
              CustomPaint(
                foregroundPainter: QrScannerMask(
                  clipper: clipper,
                ),
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      height: context.allHeight,
                      child: CameraPreview(controller!),
                    ),
                  ),
                ),
              ),
              widget.isCloseButtonVisible
                  ? Positioned(
                      top: 24,
                      right: 24,
                      child: InkWell(
                        onTap: () {
                          debugPrint("close clicked");
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [
                            VCProductComponents.text(
                                textColor: VCProductColors.instance.white,
                                textAlign: TextAlign.right,
                                text: widget.closeButtonText ?? "Close",
                                typographyType: TypographyType.allCapsXLarge),
                            context.emptySizedWidthBoxLow,
                            VCIcons.icCloseCircle
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              Positioned.fill(
                top: 94,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: context.horizontalPaddingMedium,
                    child: VCProductComponents.text(
                        textColor: VCProductColors.instance.white,
                        textAlign: TextAlign.center,
                        text: widget.infoText ?? "",
                        typographyType: TypographyType.bodyMedium16),
                  ),
                ),
              ),
            ],
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Future<void> startLiveFeed() async {
    controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );

    await controller?.initialize().then((_) {
      controller
        ?..startImageStream(processStream)
        ..setFlashMode(FlashMode.off);
    }).catchError((e) {
      if (e is CameraException) {
        debugPrint(e.description);
        if (e.code == 'CameraAccessDenied') {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              Navigator.of(context).pop();
            }
          });
        }
      }
    });
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!mounted) return;
    if (isBusy) return;
    isBusy = true;
    qrCode = await QrScannerHelper.instance.scanQr(inputImage);

    if (qrCode != null && !isQrScanned) {
      await disposeScanner().then((value) {
        isQrScanned = true;
        Navigator.of(context).pop();
        widget.onScannerResult.call(qrCode!);
      });
    }
    isBusy = false;
  }

  Future<void> switchLiveCamera() async {
    VCLoadingSpinner.show();
    cameraIndex = (cameraIndex + 1) % cameras!.length;
    await stopLiveFeed();
    await startLiveFeed();
    VCLoadingSpinner.dismiss();
  }

  Future<void> processStream(CameraImage image) async {
    if (!mounted) return;
    if (canProcess == true) {
      final InputImage? inputImage = processCameraImage(camera, image);
      if (inputImage == null) return;
      await processImage(inputImage);
    } else {
      setState(() {
        canProcess ??= true;
      });
    }
  }
}
