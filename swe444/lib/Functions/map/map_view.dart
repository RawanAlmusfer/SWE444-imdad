import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe444/Functions/map/markers.dart';
import 'package:swe444/Sevices/geolocater_service.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  GeolocaterService location = GeolocaterService();
  LatLng current = LatLng(0, 0);
  Completer<GoogleMapController> _controller = Completer();
   GoogleMapController? _gmcontroller;
  MarkersViewModel markers= MarkersViewModel();
  Set<Marker> ms={};

  CameraPosition cp = CameraPosition(
    target: LatLng(24.7135517, 46.6752957),
    zoom: 12.4746,
  );

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero,
            () => setState(() {
          setup();
        }));
  }

  setup() async {
    ms= await markers.fetchMosques();
  }

  getCurrentLocation() async {
    double lat = 0;
    double long = 0;
    await location.getInitialLocation().then((value) {
      long = value.longitude;
      lat = value.latitude;
    }).catchError((error) {
      print(error.toString());
    });
    // return CameraPosition(target: LatLng(24.7135517,46.6752957), zoom: 12.4746, );
    cp = CameraPosition(target: LatLng(lat, long), zoom: 12.4746);
  }

  @override
  Widget build(BuildContext context) {

    // SchedulerBinding.instance!.addPostFrameCallback((_) {
    //   if (mounted)
    //     setState(() {
    //       getCurrentLocation();
    //       if (_gmcontroller != null)
    //       _gmcontroller!.animateCamera(CameraUpdate.newCameraPosition(cp));
    //     });
    // });
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 65),
        child: GoogleMap(
          myLocationEnabled: true,
          initialCameraPosition: cp,
          markers: ms,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _gmcontroller = controller;
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }
}
