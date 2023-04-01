import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../helpers/constants.dart';

class MapWidget extends StatefulWidget {
  MapWidget(
      {Key? key,
        this.riderLocation,
        this.storeLocation,
        this.customerLocation,
        this.initialCameraPosition})
      : super(key: key);
  final LatLng? riderLocation;
  final LatLng? storeLocation;
  final LatLng? customerLocation;
  final LatLng? initialCameraPosition;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  BitmapDescriptor? bikeIcon;
  BitmapDescriptor? mapPin;
  PolylinePoints polylinePoints = PolylinePoints();

  final List<Marker> _markers = [];

  setIcons() async {
    bikeIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          size: Size(10, 10),
        ),
        "assets/icons/bike_icon.png");
    mapPin = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          size: Size(10, 10),
        ),
        "assets/icons/map_pin.png");
  }

  setPageData() async {
    await setIcons();
    if (widget.riderLocation != null)
      _markers.add(Marker(
          markerId: MarkerId('1'),
          infoWindow: InfoWindow(title: "Your Current Location"),
          position: widget.riderLocation!,
          icon: bikeIcon ?? BitmapDescriptor.defaultMarker));
    if (widget.storeLocation != null) {
      _markers.add(Marker(
          markerId: MarkerId('2'),
          infoWindow: InfoWindow(title: "Store Location"),
          position: widget.storeLocation!,
          icon: mapPin ?? BitmapDescriptor.defaultMarker));
    }
    if (widget.customerLocation != null) {
      _markers.add(Marker(
          markerId: MarkerId('3'),
          infoWindow: InfoWindow(title: "Customer Location"),
          position: widget.customerLocation!,
          icon: mapPin ?? BitmapDescriptor.defaultMarker));
    }

    if (widget.riderLocation != null &&
        widget.storeLocation != null &&
        widget.customerLocation != null) {
      await addPolyLine(widget.riderLocation!, widget.storeLocation!, 'store');
      await addPolyLine(
          widget.storeLocation!, widget.customerLocation!, 'customer');
    } else if (widget.riderLocation != null && widget.storeLocation != null) {
      await addPolyLine(widget.riderLocation!, widget.storeLocation!, 'store');
    } else if (widget.riderLocation != null &&
        widget.customerLocation != null) {
      await addPolyLine(
          widget.riderLocation!, widget.customerLocation!, 'customer');
    }
    setState(() {});
    // polylineCoordinates.add(location);
  }

  addPolyLine(LatLng source, LatLng destination, String placeId) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_API_KEY,
      PointLatLng(source.latitude, source.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      // travelMode: isBikeMode ? TravelMode.bicycling : TravelMode.driving,
    );
    polylineCoordinates = [];
    // log("MK: results of polyLines: ${result}");
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    PolylineId id = PolylineId(placeId);
    Polyline polyline = Polyline(
        polylineId: id,
        points: polylineCoordinates,
        width: 4,
        color: Colors.blue);
    polylines[id] = polyline;
  }

  @override
  void initState() {
    setPageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
          target: (widget.initialCameraPosition ??
              widget.riderLocation ??
              widget.storeLocation ??
              widget.customerLocation ??
              LatLng(0,0)),
          zoom: 12),
      mapType: MapType.terrain,
      polylines: Set<Polyline>.of(polylines.values),
      markers: Set<Marker>.of(_markers),
      // zoomGesturesEnabled: false,
      zoomControlsEnabled: true,
      // onCameraMove: _onCameraMove,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
