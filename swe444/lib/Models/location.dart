class Location{
  final double lat; 
  final double long;
  
  Location({required this.lat, required this.long});

  factory Location.fromJson(Map<String,dynamic> json){
    return Location(
        lat: json['lat'], long: json['long']);
  }
}