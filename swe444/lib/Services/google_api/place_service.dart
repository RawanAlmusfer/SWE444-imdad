import 'package:http/http.dart' as http;
import 'package:swe444/Models/place.dart';
import 'dart:convert' as convert;

import 'package:swe444/Models/place_search.dart';
class PlaceService{
  final key = 'AIzaSyCfvjRHNGvqQPcW7AOPj5LNPJsKs-TgM4M';
  late final String? searchTerm;

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&location=24.774265,46.738586&radius=1000&types=establishment&key=$key');
    var response= await http.get(url);
    var json= convert.jsonDecode(response.body);

    var jsonResults= json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String placeId) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key'); 
    var response= await http.get(url);
    var json= convert.jsonDecode(response.body);

    var jsonResults= json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResults);
  }

  // Future<List<Place>> getEPlace(double lat, double lng, String search) async {
  //   var url = Uri.parse(
  //       'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cname%2Cgeometry&input=$search&inputtype=textquery&locationbias=%40$lat%2C$lng&key=$key');
  //   var response= await http.get(url);
  //   var json= convert.jsonDecode(response.body);
  //   var jsonResults= json['result'] as List;
  //   return jsonResults.map((place) =>Place.fromJson(place)).toList();
  // }

  Future<List<Place>> getPlaces(double lat, double lng,String placeType) async {
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }

}