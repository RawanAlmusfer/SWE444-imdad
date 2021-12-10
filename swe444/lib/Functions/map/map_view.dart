import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swe444/Functions/map/markers.dart';
import 'package:swe444/Models/place.dart';
import 'package:swe444/Models/place_search.dart';
import 'package:swe444/Sevices/application_bloc.dart';
import 'package:swe444/Sevices/geolocater_service.dart';
import 'dart:ui' as ui;

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApplicationBloc>(
        create: (_) => ApplicationBloc(),
        child: Container(height: 1200, width: 450, child: Map()));
  }
}

class Map extends StatefulWidget {
  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> with AutomaticKeepAliveClientMixin {
  GeolocaterService location = GeolocaterService();
  LatLng current = LatLng(0, 0);
  // Completer<GoogleMapController> _controller = Completer();
  Completer<GoogleMapController> _gmcontroller = Completer();
  MarkersViewModel markers = MarkersViewModel();
  Set<Marker> ms = {};
  TextEditingController searchTerm = TextEditingController();
  String search = "";
  List<PlaceSearch> placesResults = [];
  StreamSubscription? locationsub;
  var applicationBloc;

  CameraPosition cp = CameraPosition(
    target: LatLng(24.7135517, 46.6752957),
    zoom: 12.4746,
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


  // @override
  // void dispose() {
  //
  //   final applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);
  //   applicationBloc.dispose();
  //
  //   if (locationsub != null) locationsub!.cancel();
  //
  //   super.dispose();
  // }

  setup() async {
    ms = await markers.fetchMosques(context);

    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    locationsub = applicationBloc.selectedLocation.stream.listen((place) {
      if (applicationBloc.selectedLocationStatic != null) {

        _goToPlace(applicationBloc.selectedLocationStatic!);
      }
    });
  }

  searchFunc(String s, ApplicationBloc bloc) async {
    bloc.searchPlaces(s);
  }

  Widget searchField(ApplicationBloc bloc) {
    return Stack(
      children: [
        TextField(
          textDirection: ui.TextDirection.rtl,
          maxLines: 1,
          controller: searchTerm,
          onChanged: (_val) {
            if (_val != null) {
              search = searchTerm.text.trim();
              setState(() {
                Future.delayed(
                    Duration.zero,
                    () => setState(() {
                          searchFunc(search, bloc);
                        }));
              });
            }
          },
          showCursor: true,
          cursorColor: const Color(0xdeedd03c),
          style: TextStyle(fontSize: 17, color: const Color(0xff334856)),
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
            prefixStyle:
                TextStyle(fontSize: 17, color: const Color(0xff334856)),
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
                          searchFunc(search, bloc);
                        }));
              });
            },
            icon: Icon(Icons.search, color: const Color(0xdeedd03c))),
      ],
    );
  }

  getCurrentLocation() async {
    if (mounted){
    Position loc = await location.getCurrentLocation();
    double long = loc.longitude;
    double lat = loc.latitude;
    setState(() {
      ms = markers.markers;
      ms.add(Marker(
        markerId: MarkerId('موقعك'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(title: 'أنت هنا!'),
      ));
    });
  }}

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    applicationBloc = Provider.of<ApplicationBloc>(context);

    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (mounted && applicationBloc.currentLocation != null) {
        getCurrentLocation();
        setState(() {
          ms = markers.markers;
        });
      }
    });
    return Scaffold(
      body: (applicationBloc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 65),
              child: Stack(
                children: [
                  Stack(
                    children: [
                      GoogleMap(
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                              applicationBloc.currentLocation!.latitude,
                              applicationBloc.currentLocation!.longitude),
                          zoom: 12.4746,
                        ),
                        markers: ms,
                        mapType: MapType.normal,
                        onMapCreated: (GoogleMapController controller) {
                          if (!_gmcontroller.isCompleted)
                          _gmcontroller.complete(controller);
                        },
                      ),
                      if (applicationBloc.searchResults.isNotEmpty &&
                          searchTerm.text.trim().isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(top: 51),
                          height: double.infinity,
                          child: ListView.builder(
                              itemCount: applicationBloc.searchResults.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(color: Colors.white
                                      ),
                                  child: ListTile(
                                    title: Text(
                                      applicationBloc
                                          .searchResults[index].placeId,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: const Color(0xff334856),
                                        // Colors.white
                                      ),
                                    ),
                                    onTap: () async {
                                      await _goToPlace(new Place(
                                        name: applicationBloc
                                            .searchResults[index].placeId,
                                        lat: applicationBloc
                                            .searchResults[index]
                                            .geometry
                                            .latitude,
                                        long: applicationBloc
                                            .searchResults[index]
                                            .geometry
                                            .longitude,
                                      ));
                                      searchTerm.text = applicationBloc
                                          .searchResults[index].placeId;
                                      applicationBloc.searchResults.clear();
                                    },
                                  ),
                                );
                              }),
                        ),
                    ],
                  ),
                  Container(
                      height: 60,
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 55, top: 10, bottom: 10),
                      alignment: Alignment.topCenter,
                      child: searchField(applicationBloc)),
                ],
              )),
    );
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _gmcontroller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(place.lat, place.long), zoom: 14)));
  }
}
