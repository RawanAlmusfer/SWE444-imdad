import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe444/Models/location.dart';

class Geometry{
  final double lat;
  final double long;
  
  Geometry({required this.lat, required this.long });

  factory Geometry.fromJson(Map<dynamic,dynamic> json){
    return Geometry(
        lat: json['lat'], 
        long: json['long']
    );
  }
}