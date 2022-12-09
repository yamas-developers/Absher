import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class PolylineContainer extends StatefulWidget {
  final double originLatitude;

  final double originLongitude;

  final double destLatitude;

  final double destLongitude;

  const PolylineContainer({required this.destLongitude,required this.originLongitude, required this.originLatitude, required this.destLatitude});

  @override
  _PolylineContainerState createState() => _PolylineContainerState();
}

class _PolylineContainerState extends State<PolylineContainer> {
  late GoogleMapController mapController;

  //double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  // double _destLatitude = 6.849660, _destLongitude = 3.648190;
  /*double _originLatitude = 30.355685238654,
      _originLongitude = 71.649374216894;
  double _destLatitude = 30.355685238057,
      _destLongitude = 71.549374216794;*/
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyCsIZjH8VgRzQkZPDtkrTxC0iWAENkDbMo";

  @override
  void initState() {
    super.initState();
    _addMarker(LatLng(widget.originLatitude, widget.originLongitude), "Seller",
        BitmapDescriptor.defaultMarker);
    _addMarker(LatLng(widget.destLatitude, widget.destLongitude), "Place of Job",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.originLatitude, widget.originLongitude), zoom: 12),
        myLocationEnabled: true,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: _onMapCreated,
        markers: Set<Marker>.of(markers.values),
        polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId,
        icon: descriptor,
        position: position,
        infoWindow: InfoWindow(title: '$id'));
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(widget.originLatitude, widget.originLongitude),
      PointLatLng(widget.destLatitude, widget.destLongitude),
      travelMode: TravelMode
          .driving, /*wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]*/
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
