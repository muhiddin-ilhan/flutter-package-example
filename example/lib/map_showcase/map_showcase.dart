import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class MapShowcase extends StatefulWidget {
  const MapShowcase({super.key});

  @override
  State<MapShowcase> createState() => _MapShowcaseState();
}

class _MapShowcaseState extends State<MapShowcase> {
  GoogleMapController? googleMapController;
  final List<Marker> _markers = [];
  bool enableAddAtmMarker = false;
  bool enableAddBranchMarker = false;
  BitmapDescriptor? markerIcon;
  int lastMarkerIdNumber = 0;

  _toggleAddMarker(bool isAtmMarker) async {
    markerIcon = await _createMarkerImageFromAsset(isAtmMarker);

    enableAddAtmMarker = enableAddAtmMarker ? false : isAtmMarker;
    enableAddBranchMarker = enableAddBranchMarker ? false : !isAtmMarker;
    setState(() {});
  }

  _addMarker(LatLng latLng) async {
    String markerIdValue = enableAddAtmMarker ? "ATM Marker $lastMarkerIdNumber" : "Branch Marker $lastMarkerIdNumber";
    MarkerId markerId = MarkerId(markerIdValue);

    Marker tmpMarker = Marker(
        markerId: markerId,
        position: latLng,
        icon: markerIcon ?? BitmapDescriptor.defaultMarker,
        onTap: () {
          _onMarkerTap(markerId);
        });

    setState(() {
      _markers.add(tmpMarker);
      enableAddAtmMarker = false;
      enableAddBranchMarker = false;
      lastMarkerIdNumber++;
    });
  }

  _onMarkerTap(MarkerId markerId) {
    try {
      showModalBottomSheet(context: context, builder: (context) => bottomSheetCard(markerId));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future _goCustomLatLng(LatLng latLng, double zoom) async {
    try {
      await googleMapController!.animateCamera(CameraUpdate.newLatLngZoom(latLng, zoom));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<BitmapDescriptor?> _createMarkerImageFromAsset(bool isAtmMarker) async {
    try {
      String pngAsset = isAtmMarker ? "assets/icons/atm_marker.png" : "assets/icons/branch_marker.png";
      ByteData data = await rootBundle.load(pngAsset);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 100);
      ui.FrameInfo fi = await codec.getNextFrame();
      Uint8List? markerIcon = (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
      BitmapDescriptor? bitmapDescriptor;
      if (markerIcon != null) {
        bitmapDescriptor = BitmapDescriptor.fromBytes(markerIcon);
      }
      return bitmapDescriptor;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeeeeee),
      appBar: AppBar(
        backgroundColor: VCProductColors.instance.navyBlue,
        foregroundColor: VCProductColors.instance.white,
      ),
      floatingActionButton: floatingActionButtons,
      body: Stack(
        children: [
          VCProductComponents.vcMap(
            markers: _markers,
            zoomControlsEnabled: false,
            onTapMap: (latLng) {
              if (enableAddBranchMarker || enableAddAtmMarker) {
                return _addMarker(latLng);
              }
            },
            onMapCreated: (controller) {
              googleMapController = controller;
            },
          ),
          if (enableAddBranchMarker || enableAddAtmMarker) markerAddInfoText,
          markerListCard,
        ],
      ),
    );
  }

  Widget get markerListCard {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: SizedBox(
            height: 60,
            child: ListView.builder(
              itemCount: _markers.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  _goCustomLatLng(_markers[index].position, 8);
                },
                child: Card(
                  color: VCProductColors.instance.navyBlue,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        _markers[index].markerId.value,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get floatingActionButtons {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(width: 32),
        FloatingActionButton(
          heroTag: "1",
          onPressed: () {
            setState(() {
              _markers.clear();
            });
          },
          backgroundColor: VCProductColors.instance.navyBlue,
          foregroundColor: Colors.white,
          child: Icon(
            Icons.delete_forever_sharp,
            color: VCProductColors.instance.red,
          ),
        ),
        const Spacer(),
        FloatingActionButton(
          heroTag: "2",
          onPressed: () {
            _toggleAddMarker(true);
          },
          backgroundColor: VCProductColors.instance.navyBlue,
          foregroundColor: Colors.white,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Image.asset(
              "assets/icons/atm_marker.png",
              width: 35,
              height: 35,
            ),
          ),
        ),
        const SizedBox(width: 12),
        FloatingActionButton(
          heroTag: "3",
          onPressed: () {
            _toggleAddMarker(false);
          },
          backgroundColor: VCProductColors.instance.navyBlue,
          foregroundColor: Colors.white,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Image.asset(
              "assets/icons/branch_marker.png",
              width: 35,
              height: 35,
            ),
          ),
        ),
      ],
    );
  }

  Widget get markerAddInfoText {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: VCProductColors.instance.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.info_outlined,
              color: Colors.white,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "Harita üzerinde marker eklemek istediğiniz konuma tıklayınız lütfen",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheetCard(MarkerId markerId) {
    return SizedBox(
      width: context.screenWidth100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Seçili Marker",
              style: TextStyle(
                fontSize: 13,
                color: VCProductColors.instance.black75,
                decoration: TextDecoration.underline,
              ),
            ),
            Text(
              markerId.value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: VCProductColors.instance.navyBlue,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: context.screenWidth100,
              child: VCProductComponents.elevatedButton(
                size: ButtonSize.small,
                onPressed: () {
                  try {
                    setState(() {
                      _markers.removeWhere((e) => e.markerId.value == markerId.value);
                    });
                    Navigator.pop(context);
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                text: "Markerı Sil",
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              width: context.screenWidth100,
              child: VCProductComponents.elevatedButton(
                size: ButtonSize.small,
                onPressed: () {},
                text: "Haritalarda Aç",
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              width: context.screenWidth100,
              child: VCProductComponents.elevatedButton(
                type: ButtonType.outlined,
                borderColor: VCProductColors.instance.navyBlue,
                size: ButtonSize.small,
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "Kapat",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
