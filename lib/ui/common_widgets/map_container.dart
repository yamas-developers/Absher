import 'dart:async';
import 'dart:developer';

import 'package:absher/helpers/constants.dart';
import 'package:absher/providers/location/location_provider.dart';
import 'package:absher/ui/common_widgets/rounded_center_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../helpers/address_search.dart';
import '../../helpers/place_service.dart';
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
  TextEditingController _searchController = TextEditingController();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';
  String _id = '';

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

  setFromAutoComplete(double lat, double lng) async {
    log("MJ: in setFromAutoComplete:");
    setState(() {
      _lastMapPosition = LatLng(lat, lng);
      _markers.add(Marker(
          markerId: MarkerId('1'),
          infoWindow: InfoWindow(title: 'My Location'),
          position: _lastMapPosition!));
    });

    CameraPosition cameraPosition = CameraPosition(
        zoom: 15, target: LatLng(lat, lng));
    GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
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
      child: Consumer<LocationProvider>(builder: (context, provider, _) {
        return Stack(
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
                            color: Colors.grey
                                .withOpacity(cameraMoving ? 0.4 : 0.2),
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
              visible: true,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 0, blurRadius: 10, offset: Offset(2,3)),]
                    // color: Colors.white54,
                  ),
                  child: TextField(
                    controller: _searchController,
                    readOnly: true,


                    onTap: () async {
                      final sessionToken = Uuid().v4();
                      final Suggestion? result = await showSearch(
                        context: context,
                        delegate: AddressSearch(sessionToken),
                      );
                      // This will change the text displayed in the TextField

                      if (result != null) {
                        _searchController.text =
                            result.description;

                        dynamic res = await provider.getLocation(result.placeId);
                        log("MJ: loc data: $res");
                        if(res != null){
                          // _lastMapPosition = LatLng(res["lat"], res["lng"]);
                          setFromAutoComplete(convertDouble(res["lat"]), convertDouble(res["lng"]));
                        }

                        // final placeDetails = await PlaceApiProvider(
                        //     sessionToken)
                        //     .getPlaceDetailFromId(result.placeId);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your address here",
                      labelStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      floatingLabelStyle: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).accentColor,
                      ),

                      prefixIcon: Image.asset(
                        "assets/icons/search_icon.png",
                        width: 10,
                        scale: 4,
                        height: 10,
                        color: mainColor,
                      ),
                      border:
                      // InputBorder.none,
                      OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                      fillColor: Colors.white.withOpacity(0.9),
                      filled: true,

                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    )
                  ),
                ).marginSymmetric(horizontal: 10, vertical: 10),
              ),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(
                        "Please select the exact current location then click 'Next'.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ).marginSymmetric(horizontal: 30, vertical: 20),
                    RoundedCenterButtton(
                            onPressed: () async {
                              if (loading) return;
                              setState(() {
                                loading = true;
                              });
                              try {
                                await context
                                    .read<LocationProvider>()
                                    .setCurrentLocation(_lastMapPosition, shouldSave: true);

                                LocationProvider locProvider =
                                    context.read<LocationProvider>();
                                SettingsProvider settingsProvider =
                                    context.read<SettingsProvider>();

                                if (locProvider.currentLocation != null) {
                                  await settingsProvider
                                      .getSettings(locProvider.currentLocation);
                                }
                              } catch (e) {
                                logError("error in map screen: ${e}");
                              } finally {
                                setState(() {
                                  loading = false;
                                });
                                Navigator.pop(context);
                              }
                            },
                            title: "Next")
                        .marginOnly(bottom: 20),
                  ],
                ),
              ),
            ),
            if (loading) LinearProgressIndicator(),
          ],
        );
      }),
    );
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
