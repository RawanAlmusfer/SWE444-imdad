import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'package:swe444/Services/google_api/geolocater_service.dart';

class Applicationbloc with ChangeNotifier {
  final geolocaterService = GeolocaterService();
  Position? currentLocation;

  Applicationbloc(){
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geolocaterService.getCurrentLocation();
    notifyListeners();
  }
}