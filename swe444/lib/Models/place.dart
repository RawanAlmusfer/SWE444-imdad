import 'package:swe444/Models/geometry.dart';

class Place {
  final Geometry geometry;
  final String name;
  final String? vic;

  Place({required this.geometry, required this.name, this.vic});

  factory Place.fromJson(Map<String, dynamic> parsedJson) {
    return Place(
        geometry: Geometry.fromJson(parsedJson['geometry']),
        name: parsedJson['formatted_address'],
        vic: parsedJson['vicinity']);
  }
}
