import 'dart:async';
import 'dart:developer';
import 'package:absher/helpers/constants.dart';
import 'package:absher/providers/location/location_provider.dart';
import 'package:absher/ui/common_widgets/rounded_center_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import '../../helpers/public_methods.dart';
import '../../providers/settings/settings_provider.dart';

class MapContainer extends StatefulWidget {
  final String? lat;
  final String? lng;
  final bool isSeller;

  MapContainer({Key? key, this.lat, this.lng, this.isSeller = false})
      : super(key: key);

  @override
  State<MapContainer> createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  static const CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(30.427, 71.085), zoom: 12);
  final Completer<GoogleMapController> _controller = Completer();

  final List<Marker> _markers = [];
  LatLng? _initialPosition;
  LatLng? _lastMapPosition;
  bool cameraMoving = false;
  bool loading = false;

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      showToast(error.toString());
    });
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void loadPositionData() async {
    if (widget.lat != null && widget.lng != null)
    // return;
    {
      _initialPosition =
          LatLng(convertDouble(widget.lat!), convertDouble(widget.lng!));
      _lastMapPosition = _initialPosition;
      _markers.add(Marker(
          markerId: MarkerId('1'),
          infoWindow: InfoWindow(
              title: widget.isSeller
                  ? "Customer's Location"
                  : "Worker's Location"),
          position: _initialPosition!));
      CameraPosition cameraPosition = CameraPosition(
          zoom: 12,
          target:
              LatLng(convertDouble(widget.lat!), convertDouble(widget.lng!)));
      GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
    // return;
    else
      getUserCurrentLocation().then((value) async {
        print("MJ current loc: ${value}");
        _initialPosition = LatLng(value.latitude, value.longitude);
        _lastMapPosition = _initialPosition;
        _markers.add(Marker(
            markerId: MarkerId('1'),
            infoWindow: InfoWindow(title: 'My Location'),
            position: _initialPosition!));
        CameraPosition cameraPosition = CameraPosition(
            zoom: 15, target: LatLng(value.latitude, value.longitude));
        GoogleMapController controller = await _controller.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        List<Placemark> placemarks =
            await placemarkFromCoordinates(value.latitude, value.longitude);

        // debugPrint('MJ: Loc ' +
        //     placemarks.reversed.last.administrativeArea.toString());
        // debugPrint('MJ: Loc ' + placemarks.reversed.last.street.toString());
        // debugPrint('MJ: Loc ' + placemarks.reversed.last.locality.toString());
        // debugPrint('MJ: Loc ' + placemarks.reversed.last.postalCode.toString());
        // debugPrint('MJ: Loc ' +
        //     placemarks.reversed.last.subAdministrativeArea.toString());
        // debugPrint(
        //     'MJ: Loc ' + placemarks.reversed.last.subLocality.toString());
        setState(() {});
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
  }

  @override
  void initState() {
    loadPositionData();
    super.initState();
  }

  _onCameraMove(CameraPosition position) {
    log("MJ: onCamerMove: ${position.target}");
    _lastMapPosition = position.target;
    if (!cameraMoving)
      setState(() {
        cameraMoving = true;
      });
  }

  // _onCameraMove(CameraPosition position) {
  //   _lastMapPosition = position.target;
  // }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition!,
          infoWindow: InfoWindow(
              title: "Pizza Parlour",
              snippet: "This is a snippet",
              onTap: () {}),
          onTap: () {},
          icon: BitmapDescriptor.defaultMarker));
    });
  }

  Widget mapButton(dynamic function, Icon icon, Color color) {
    return RawMaterialButton(
      onPressed: function,
      child: icon,
      shape: new CircleBorder(),
      elevation: 2.0,
      fillColor: color,
      padding: const EdgeInsets.all(7.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context),
      width: getWidth(context),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: lightGreyColor, width: 1)),
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _cameraPosition,
            mapType: MapType.normal,
            markers: Set<Marker>.of(_markers),
            onCameraMove: _onCameraMove,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraIdle: () {
              if (cameraMoving)
                setState(() {
                  cameraMoving = false;
                });
              print('MJ: camera idle: ');
            },
            circles: Set.from(
              [
                Circle(
                  circleId: CircleId('currentCircle'),
                  center: _initialPosition ?? LatLng(0, 0),
                  radius: 1000,
                  fillColor: Colors.blue.shade100.withOpacity(0.6),
                  strokeColor: Colors.blue.shade100.withOpacity(0.6),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              clipBehavior: Clip.none,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Positioned(
                  top: cameraMoving ? 65 : 35,
                  left: cameraMoving ? 10 : 13,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        // color: Colors.grey.withOpacity(0.3),
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.grey
                                .withOpacity(cameraMoving ? 0.3 : 0.1))),
                    child: Container(
                      height: cameraMoving ? 20 : 8,
                      width: cameraMoving ? 20 : 8,
                      decoration: BoxDecoration(
                          color:
                              Colors.grey.withOpacity(cameraMoving ? 0.4 : 0.2),
                          shape: BoxShape.circle),
                    ),
                  ),
                ),
                Image.asset("assets/icons/map_pin2.png",
                    color: cameraMoving ? mainColor : Colors.black,
                    height: cameraMoving ? 50 : 46),
              ],
            ).marginOnly(bottom: cameraMoving ? 80 : 50),
          ),
          Visibility(
            visible: !cameraMoving,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      "Please select the exact current location then click 'Next'.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ).marginSymmetric(horizontal: 30, vertical: 20),
                  RoundedCenterButtton(
                          onPressed: () async {
                            if(loading)return;
                            setState(() {loading = true;});
                            try{
                              await context
                                  .read<LocationProvider>()
                                  .setCurrentLocation(_lastMapPosition);

                              LocationProvider locProvider =
                              context.read<LocationProvider>();
                              SettingsProvider settingsProvider =
                              context.read<SettingsProvider>();

                              if (locProvider.currentLocation != null) {
                                await settingsProvider
                                    .getSettings(locProvider.currentLocation);
                              }
                            }catch(e){
                              logError("error in map screen: ${e}");
                            }finally{
                            setState(() {loading = false;});
                            Navigator.pop(context);
                            }

                          },
                          title: "Next")
                      .marginOnly(bottom: 20),
                ],
              ),
            ),
          ),
          if(loading)LinearProgressIndicator(),
        ],
      ),
    );
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
