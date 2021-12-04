import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe444/Models/place.dart';
import 'package:swe444/Models/place_search.dart';
import 'package:swe444/Sevices/geolocater_service.dart';
import 'package:swe444/Sevices/places_service.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolocaterService();
  final placesService = PlacesService();
  // final markerService = MarkerService();

  //Variables
  Position? currentLocation;
  List<PlaceSearch> searchResults = [];
  StreamController<Place> selectedLocation = StreamController<Place>();
  // StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();
  Place? selectedLocationStatic;
  // String placeType= "";
  // List<Place> placeResults= [];
  List<Marker> markers = [];


  ApplicationBloc() {
    setCurrentLocation();
  }


  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    // selectedLocationStatic = Place(name: null,
    //   geometry: Geometry(location: Location(
    //       lat: currentLocation.latitude, lng: currentLocation.longitude),),);
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    await placesService.getAutocomplete(searchTerm);
    searchResults.clear();
    searchResults = placesService.placesResults;
    notifyListeners();
  }

  //
  // setSelectedLocation(String placeId) async {
  //   var sLocation = await placesService.getPlace(placeId);
  //   selectedLocation.add(sLocation!);
  //   print('here4-------444');
  //   selectedLocationStatic = sLocation;
  //   searchResults = [];
  //   notifyListeners();
  // }

  //
  // clearSelectedLocation() {
  //   selectedLocation.add(null);
  //   selectedLocationStatic = null;
  //   searchResults = null;
  //   placeType = null;
  //   notifyListeners();
  // }
  //
  // togglePlaceType(String value, bool selected) async {
  //   if (selected) {
  //     placeType = value;
  //   } else {
  //     placeType = null;
  //   }
  //
  //   if (placeType != null) {
  //     var places = await placesService.getPlaces(
  //         selectedLocationStatic.geometry.location.lat,
  //         selectedLocationStatic.geometry.location.lng, placeType);
  //     markers= [];
  //     if (places.length > 0) {
  //       var newMarker = markerService.createMarkerFromPlace(places[0],false);
  //       markers.add(newMarker);
  //     }
  //
  //     var locationMarker = markerService.createMarkerFromPlace(selectedLocationStatic,true);
  //     markers.add(locationMarker);
  //
  //     var _bounds = markerService.bounds(Set<Marker>.of(markers));
  //     bounds.add(_bounds);
  //
  //     notifyListeners();
  //   }
  // }
  //
  //

  @override
  void dispose() {
    selectedLocation.close();
    // bounds.close();
    super.dispose();
  }
}