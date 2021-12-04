// import 'package:http/http.dart' as http;
// import 'package:places_autocomplete/src/models/place.dart';
// import 'dart:convert' as convert;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swe444/Models/place_search.dart';

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
          PlaceSearch place= PlaceSearch(placeId: i.current['name'].toString());
          if(!placesResults.contains(place))
          placesResults.add(place);
        }
      }
    }).onError((error, stackTrace) => print("error"));

  }

  // Future<Place> getPlace(String placeId) async {
  //   var url =
  //       'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
  //   var response = await http.get(url);
  //   var json = convert.jsonDecode(response.body);
  //   var jsonResult = json['result'] as Map<String,dynamic>;
  //   return Place.fromJson(jsonResult);
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