
import 'package:VIN/models/custom_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService{
  static setLatLngSharedPreferences({String? location,double? latitude, double? longitude})async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("location", location!);
    await prefs.setDouble("latitude", latitude!);
    await prefs.setDouble("longitude", longitude!);
  }
  static getLatLngSharedPreferences()async{
    final prefs = await SharedPreferences.getInstance();
    UserModel().location =prefs.getString('location');
    UserModel().latitude =prefs.getDouble('latitude');
    UserModel().longitude =prefs.getDouble('longitude');
  }
}