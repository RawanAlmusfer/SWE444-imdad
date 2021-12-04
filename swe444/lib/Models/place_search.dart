import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceSearch {
  final String placeId;
  final LatLng geometry;

  PlaceSearch({required this.placeId, required this.geometry});

  factory PlaceSearch.fromJson(Map<String,dynamic> json){
    return PlaceSearch(
        placeId: json['place_id'], geometry: LatLng(json['lat'], json['long'])
    );
  }
}