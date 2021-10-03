import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swe444/Models/place.dart';
import 'package:swe444/Services/google_api/application_bloc.dart';
import 'decisions_tree.dart';
import 'Views/mm_home_view.dart';
import 'Views/v_home_view.dart';

// @dart=2.9
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//         builder: () => MaterialApp(
//               debugShowCheckedModeBanner: false,
//               home: DecisionsTree(),
//             ),       designSize: const Size(390, 844),
//
//     );
//
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => ChangeNotifierProvider(
          create: (context) => Applicationbloc(),
          child: MaterialApp(debugShowCheckedModeBanner: false, home: Map())),
      designSize: const Size(390, 844),
    );
  }

  Widget map() {
    return Scaffold(
        body: ListView(
      children: [
        Text("hi"),
        Container(
          height: 200,
          child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition:
                  CameraPosition(target: LatLng(24.774265, 46.738586))),
        ),
      ],
    ));
  }
}

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Map();
  }
}

class _Map extends State<Map> {
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription? locationSub;
  StreamSubscription? boundsSub;

  @override
  void initState() {
    final applicationBloc =
        Provider.of<Applicationbloc>(context, listen: false);

    locationSub = applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) _goToPlace(place);
    });

    boundsSub = applicationBloc.bounds.stream.listen((bounds) async
    { final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds!, 50));
    });

    super.initState();
  }


  List<Marker> current= [];

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<Applicationbloc>(context, listen: false);
    applicationBloc.dispose();
    locationSub?.cancel();
    boundsSub!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<Applicationbloc>(context);

    // if (applicationBloc.markers == [] || applicationBloc.markers.length == 0)
    //   current.add(Marker(markerId: MarkerId('you'), position: LatLng(applicationBloc.currentLocation!.latitude , applicationBloc.currentLocation!.longitude), ));


    return Scaffold(
        body: (applicationBloc.currentLocation == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Search",
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: TextStyle(),
                        suffixIcon: Icon(Icons.search)),
                    onChanged: (_val) {
                      applicationBloc.searchPlaces(_val);
                    },
                  ),
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        GoogleMap(
                            mapType: MapType.normal,
                            markers: Set<Marker>.of(applicationBloc.markers),
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    applicationBloc.currentLocation!.latitude,
                                    applicationBloc.currentLocation!.longitude),
                                zoom: 5),
                            onMapCreated: (GoogleMapController controller) {
                              _mapController.complete(controller);
                            }),
                        if (applicationBloc.searchResults != null &&
                            applicationBloc.searchResults!.length != 0)
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(0xB5000000),
                                backgroundBlendMode: BlendMode.darken),
                          ),
                        if (applicationBloc.searchResults != null &&
                            applicationBloc.searchResults!.length != 0)
                          Container(
                            height: 200,
                            child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      applicationBloc.searchResults != null
                                          ? applicationBloc
                                              .searchResults![index].description
                                          : "",
                                      style:
                                          TextStyle(color: Color(0xFFFFFFFF)),
                                    ),
                                    onTap: () {
                                      applicationBloc.setSelectedLocation(
                                        applicationBloc
                                            .searchResults![index].placeId,
                                      );
                                    },
                                  );
                                },
                                itemCount: applicationBloc.searchResults != null
                                    ? applicationBloc.searchResults!.length
                                    : 0),
                          )
                      ],
                    ),
                  ),
                  const ElevatedButton(
                    onPressed: null,
                    child: Text("hi"),
                  ),
                  Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: Text("Mosque"),
                        onSelected: (val) {
                          applicationBloc.togglePlaceType("mosque", val);
                        },
                        selected: applicationBloc.placeType == 'mosque',
                        selectedColor: Colors.amber,
                      )
                    ],
                  )
                ],
              ));
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            LatLng(place.geometry.location.lat, place.geometry.location.lng),
        zoom: 12)));
  }
}
