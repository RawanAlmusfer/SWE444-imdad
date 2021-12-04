class PlaceSearch {
  final String placeId;

  PlaceSearch({required this.placeId});

  factory PlaceSearch.fromJson(Map<String,dynamic> json){
    return PlaceSearch(
        placeId: json['place_id']
    );
  }
}