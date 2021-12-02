import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe444/Functions/map/markers.dart';
import 'package:swe444/Sevices/geolocater_service.dart';
import 'dart:ui' as ui;

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  GeolocaterService location = GeolocaterService();
  LatLng current = LatLng(0, 0);
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _gmcontroller;
  MarkersViewModel markers = MarkersViewModel();
  Set<Marker> ms = {};
  TextEditingController searchTerm = TextEditingController();
  String search = "";

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

  @override
  void dispose() {
    super.dispose();
  }

  setup() async {
    ms = await markers.fetchMosques();
  }

  searchFunc(String s) async {}

  getCurrentLocation() async {
    Position loc = await location.getInitialLocation();
    double long = loc.longitude;
    double lat = loc.latitude;
    // print('------here-----');
    setState(() {
      ms = markers.markers;
      ms.add(Marker(
        markerId: MarkerId('موقعك'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(title: 'أنت هنا!'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (mounted) {
        getCurrentLocation();
        setState(() {
          ms = markers.markers;
        });
      }
    });
    return Scaffold(
      body: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 65),
          child: Stack(
            children: [
              GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: cp,
                markers: ms,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  _gmcontroller = controller;
                },
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.only(
                    left: 30.0, right: 55, top: 10, bottom: 10),                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    TextField(
                      textDirection: ui.TextDirection.rtl,
                      maxLines: 1,
                      controller: searchTerm,
                      onChanged: (_val) {
                        if (_val != null) {
                          search = searchTerm.text;
                          setState(() {
                            Future.delayed(
                                Duration.zero,
                                    () => setState(() {
                                  searchFunc(search);
                                }));
                          });
                        }
                      },
                      showCursor: true,
                      cursorColor: const Color(0xdeedd03c),
                      style: TextStyle(
                          fontSize: 17, color: const Color(0xff334856)),
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.search, color: const Color(0xdeedd03c),),
                        filled: true,
                        fillColor: Color(0xffffffff),
                        contentPadding: EdgeInsets.only(right: 20, top: 3),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.20,
                            color: const Color(0xffc1c1c1),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color(0xdeedd03c),
                          ),
                        ),
                        prefixStyle: TextStyle(
                            fontSize: 17, color: const Color(0xff334856)),
                        hoverColor: const Color(0xff334856),
                        hintText: "إبحث عن",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            color: const Color(0xffcbcbcc),
                            fontFamily: 'Tajawal'),
                        labelStyle: TextStyle(
                            fontSize: 15,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                        alignLabelWithHint: true,
                        //border: OutlineInputBorder(),
                        // hoverColor: const Color(0xff334856),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          search = searchTerm.text;
                          setState(() {
                            Future.delayed(
                                Duration.zero,
                                    () => setState(() {
                                  searchFunc(search);
                                }));
                          });
                        },
                        icon:
                        Icon(Icons.search, color: const Color(0xdeedd03c))),
                  ],
                ),
              ),

            ],
          )),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }
}
