import 'package:swe444/Models/geometry.dart';

class Place {
  // final Geometry geo;
  final double lat;
  final double long;
  final String name;

  Place({required this.long, required this.lat, required this.name});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      lat: json['lat'],
      long: json['long'],
      name: json['name'],
    );
  }

}
