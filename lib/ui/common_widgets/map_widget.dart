import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  MapWidget({Key? key, required this.markerLocation}) : super(key: key);
  final LatLng markerLocation;
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: markerLocation, zoom: 16),
      mapType: MapType.terrain,
      markers: Set<Marker>.of([
        Marker(
            markerId: MarkerId('1'),
            infoWindow: InfoWindow(title: "Your Selected Address"),
            position: markerLocation)
      ]),
      zoomGesturesEnabled: false,
      zoomControlsEnabled: false,
      // onCameraMove: _onCameraMove,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
