import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'loading.dart';

class GoogleMapClass extends StatefulWidget {
  GoogleMapClass();
  @override
  _GoogleMapClass createState() => _GoogleMapClass();
}

class _GoogleMapClass extends State<GoogleMapClass> {
  Completer<GoogleMapController> mapController = Completer();
  Position currentPosition;
  CameraPosition cameraPosition;
  LatLng companyLocation = LatLng(37.60698991689425, 126.9314847979407);

  void locatePosition() async {
    try {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("current locationLatitude: ${currentPosition.latitude}");
      print("current locationLongitude: ${currentPosition.longitude}");
      setState(() {
        cameraPosition = CameraPosition(
            target: LatLng(currentPosition.latitude, currentPosition.longitude),
            zoom: 15);
      });
    } on Exception {
      currentPosition = null;
      print("company locationLatitude: ${companyLocation.latitude}");
      print("company locationLongitude: ${companyLocation.longitude}");
      setState(() {
        cameraPosition = CameraPosition(target: companyLocation, zoom: 15);
      });
    }
  }

  @override
  void initState() {
    locatePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentPosition != null
            ? GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                initialCameraPosition: cameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  mapController.complete(controller);
                },
              )
            : Loading());
  }
}
