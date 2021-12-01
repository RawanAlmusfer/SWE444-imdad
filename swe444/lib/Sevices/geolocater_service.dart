import 'package:geolocator/geolocator.dart';

class GeolocaterService {
  final Geolocator geo= new Geolocator();

  Stream<Position> getCurrentLocation(){
    var locationOptions= LocationOptions(accuracy: LocationAccuracy.high);
    return Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high);
  }

  Future<Position> getInitialLocation() async{
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}