// import 'package:http/http.dart' as http;
// import 'package:places_autocomplete/src/models/place.dart';
// import 'dart:convert' as convert;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe444/Models/place.dart';
import 'package:swe444/Functions/map/place_search.dart';

class PlacesService {
  // final key = 'YOUR_KEY';

  Stream<QuerySnapshot<Map<String, dynamic>>>? places;
  List<PlaceSearch> placesResults= [];


  Future getAutocomplete(String search) async {
    // var url =
    //     'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key';
    // var response = await http.get(url);
    // var json = convert.jsonDecode(response.body);
    placesResults.clear();
    FirebaseFirestore.instance
        .collection('mosques_code')
        .where('name', isGreaterThanOrEqualTo: search)
        .snapshots()
        .forEach((snapshot) {
      var i = snapshot.docs.iterator;
      while (i.moveNext()) {
        if (i.current["name"].toString().contains(search)) {
          PlaceSearch place= PlaceSearch(placeId: i.current['name'].toString(), geometry: LatLng(double.parse(i.current['lat'].toString()),double.parse(i.current['long'].toString())));
          if(!placesResults.contains(place))
          placesResults.add(place);
        }
      }
    }).onError((error, stackTrace) => print("error"+ error.toString()));

  }

  // Future<Place?> getPlace(String placeId) async {
  //   Place? place;
  //
  //   await FirebaseFirestore.instance
  //       .collection('mosques_code')
  //       .where('name', isEqualTo: placeId)
  //       .snapshots()
  //       .forEach((snapshot) {
  //     print('here3-------3333');
  //     var i = snapshot.docs.iterator;
  //     while (i.moveNext()) {
  //       place= new Place(long: double.parse(i.current['long'].toString()), lat: double.parse(i.current['lat'].toString()), name: i.current['name'].toString());
  //     }
  //   }).onError((error, stackTrace) => print("error"+ error.toString()));
  //
  //
  //   return place;
  // }

  //
  // Future<List<Place>> getPlaces(double lat, double lng,String placeType) async {
  //   var url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$key';
  //   var response = await http.get(url);
  //   var json = convert.jsonDecode(response.body);
  //   var jsonResults = json['results'] as List;
  //   return jsonResults.map((place) => Place.fromJson(place)).toList();
  // }
}