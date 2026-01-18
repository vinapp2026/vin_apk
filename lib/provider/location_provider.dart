import 'package:VIN/Services/general_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier{
  //User Location
  Position? currentPostion;
  var currentLocation;
  bool isLocLoading=false;
  String? place;
  bool isLocation=false;
  getCurrentLocation()async{
    isLocLoading = true;
    currentPostion = await GeneralServices.getGeoLocationPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPostion!.latitude, currentPostion!.longitude);
    place = placemarks[0].locality.toString();
    currentLocation = place;
    isLocLoading=false;
    notifyListeners();
    return currentLocation;
  }

  getManuelLocation(manuelLocation)async{
    currentLocation =manuelLocation;
  }
 // LatLng? latLng;
  getManuelPosition(manuelLocation)async{
    currentPostion =manuelLocation;
  }
}