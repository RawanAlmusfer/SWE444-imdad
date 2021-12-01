import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe444/Sevices/geolocater_service.dart';


class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  GeolocaterService location= GeolocaterService();
  LatLng current= LatLng(0,0);
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  @override
  void initState() {
    super.initState();
  }


  CameraPosition getCurrentLocation() {
    double? lat;
    double? long;
     location.getInitialLocation().then((value) { long= value.longitude; lat= value.latitude; } ).catchError((error) {
      print(error.toString());
    });
    // return CameraPosition(target: LatLng(24.7135517,46.6752957), zoom: 12.4746, );
    if (lat != null && long != null){
    return CameraPosition(target: LatLng(lat!,long!), zoom: 12.4746 );}
    else
    return CameraPosition(target: LatLng(24.7135517,46.6752957), zoom: 12.4746, );
    }


  @override
  Widget build(BuildContext context) {
    CameraPosition cp= getCurrentLocation();
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 65),
        child: GoogleMap(
          myLocationEnabled: true, initialCameraPosition: cp,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
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