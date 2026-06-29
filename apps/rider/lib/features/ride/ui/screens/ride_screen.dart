import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideScreen extends StatefulWidget {
  const RideScreen({super.key});

  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  String? _mapStyle;

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
  }

  Future<void> _loadMapStyle() async {
    _mapStyle = await rootBundle.loadString("assets/json/rider_map_style.json");
    setState(() {});
  }

  // حدود تقريبية للعراق (جنوب-غرب → شمال-شرق)
  final iraqBounds = LatLngBounds(
    southwest: const LatLng(29.0, 38.8),
    northeast: const LatLng(37.4, 48.6),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            GoogleMap(
              style: _mapStyle,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: kDebugMode,
              cameraTargetBounds: CameraTargetBounds(iraqBounds),
              initialCameraPosition: CameraPosition(
                zoom: 14,
                target: LatLng(33.3152, 44.3661),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
