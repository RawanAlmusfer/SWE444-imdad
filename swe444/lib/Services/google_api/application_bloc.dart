import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe444/Models/geometry.dart';
import 'package:swe444/Models/place.dart';
import 'package:swe444/Models/location.dart';
import 'package:swe444/Models/place_search.dart';

import 'package:swe444/Services/google_api/geolocater_service.dart';
import 'package:swe444/Services/google_api/markers_service.dart';
import 'package:swe444/Services/google_api/place_service.dart';

class Applicationbloc with ChangeNotifier {
  final geolocaterService = GeolocaterService();
  final placesService= PlaceService();
  final markerService= MarkerService();

  Position? currentLocation;
  List<PlaceSearch>? searchResults;
  StreamController<Place> selectedLocation= StreamController<Place>();
  Place? selectedLocationStatic;
  String? placeType;
  List<Marker> markers= <Marker>[];

  StreamController<LatLngBounds?> bounds = StreamController<LatLngBounds?>();

  Applicationbloc(){
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geolocaterService.getCurrentLocation();
    selectedLocationStatic= Place(geometry: Geometry(location: Location(lat: currentLocation!.latitude, lng: currentLocation!.longitude)), name: "");
    notifyListeners();
    List<Marker> markers= List<Marker>.filled(2, Marker(markerId: MarkerId('you'), position: LatLng(currentLocation!.latitude , currentLocation!.longitude))
        , growable: true);
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  setSelectedLocation(String placeId) async {
    var sLocation = await placesService.getPlace(placeId);
    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults = null;
    notifyListeners();
  }

  // clearSelectedLocation() {
  //   selectedLocation.add(null);
  //   selectedLocationStatic = null;
  //   searchResults = null;
  //   placeType = null;
  //   notifyListeners();
  // }

  togglePlaceType(String value, bool selected) async {
    if (selected) {
      placeType = value;
    } else {
      placeType = null;
    }

    if (selectedLocationStatic != null)
      if (placeType != null) {
        var places = await placesService.getPlaces(
            selectedLocationStatic!.geometry.location.lat,
            selectedLocationStatic!.geometry.location.lng, placeType!);


      markers= [];
      if (markers != null) {
        if (places.length > 0) {
          var newMarker = markerService.createMarkerFromPlace(places[0], false);
          markers.add(newMarker);
        }

        var locationMarker = markerService.createMarkerFromPlace(
            selectedLocationStatic!, true);
        markers.add(locationMarker);

        var _bounds = markerService.bounds(Set<Marker>.of(markers));
        bounds.add(_bounds);
      }

      notifyListeners();
    }
  }

  @override
  void dispose() {
    selectedLocation.close();
    super.dispose();
  }

}