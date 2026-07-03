import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasal/core/consts/app_rider_consts.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({
    super.key,
    required Completer<GoogleMapController> controller,
  }) : _controller = controller;

  final Completer<GoogleMapController> _controller;

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  final iraqBounds = LatLngBounds(
    southwest: const LatLng(29.0, 38.8),
    northeast: const LatLng(37.4, 48.6),
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapId: AppRiderConsts.mapStyleID,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: kDebugMode,
      cameraTargetBounds: CameraTargetBounds(iraqBounds),
      onMapCreated: (controller) {
        widget._controller.complete(controller);
      },
      initialCameraPosition: CameraPosition(
        zoom: 14,
        target: LatLng(33.3152, 44.3661),
      ),
    );
  }
}
