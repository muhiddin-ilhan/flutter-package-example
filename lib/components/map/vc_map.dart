import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VCMap extends StatefulWidget {
  // Callback triggered when the map is created.
  final Function(GoogleMapController controller) onMapCreated;

  // Callback triggered when a location on the map is tapped.
  final Function(LatLng latLng)? onTapMap;
  final Function(LatLng latLng)? onLongTapMap;

  // Initial camera position of the map.
  final CameraPosition? initialCameraPosition;

  // Map type (normal, satellite, etc.).
  final MapType mapType;

  // Markers to be displayed on the map.
  final List<Marker>? markers;

  // Whether the button to show the user's location is enabled.
  final bool myLocationButtonEnabled;

  // Whether to enable the user's location on the map.
  final bool myLocationEnabled;

  // Whether zoom controls are enabled (only Android).
  final bool zoomControlsEnabled;

  // Container widget parameters
  final double? height;
  final double? width;
  final EdgeInsets padding;
  final BorderRadius borderRadius;

  const VCMap({
    super.key,
    required this.onMapCreated,
    this.onTapMap,
    this.onLongTapMap,
    this.initialCameraPosition,
    this.markers,
    this.myLocationButtonEnabled = false,
    this.myLocationEnabled = false,
    this.zoomControlsEnabled = true,
    this.mapType = MapType.normal,
    this.height,
    this.width,
    this.padding = EdgeInsets.zero,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  State<VCMap> createState() => _VCMapState();
}

class _VCMapState extends State<VCMap> {
  static const CameraPosition _turkeyPosition = CameraPosition(
    target: LatLng(39.7839643, 35.0825689),
    zoom: 5,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Padding(
        padding: widget.padding,
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: GoogleMap(
            mapType: widget.mapType,
            initialCameraPosition: widget.initialCameraPosition ?? _turkeyPosition,
            compassEnabled: true,
            zoomControlsEnabled: widget.zoomControlsEnabled,
            myLocationButtonEnabled: widget.myLocationButtonEnabled,
            myLocationEnabled: widget.myLocationEnabled,
            markers: Set<Marker>.of(widget.markers ?? []),
            onTap: widget.onTapMap,
            onLongPress: widget.onLongTapMap,
            onMapCreated: widget.onMapCreated,
          ),
        ),
      ),
    );
  }
}
