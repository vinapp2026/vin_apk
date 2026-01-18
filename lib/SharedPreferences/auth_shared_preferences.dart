import 'package:VIN/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthSharedPreferences{
  //Set
  static setAuthSharedPreferences({
    int? uid,
    String? accessToken,
  })async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("id", uid??0);
    await prefs.setString("token", accessToken??"");
  }
  //Get
  static getAuthSharedPreferences()async{
    final prefs = await SharedPreferences.getInstance();
    UserModel().uid =prefs.getInt('id');
    UserModel().token = prefs.getString('token');
  }
  //Clear
   static clearUserIdToken()async{
     // final prefs = await SharedPreferences.getInstance();
     // UserModel().uid = await prefs.setInt('uid',);
     // UserModel().accessToken = await prefs.getString('accessToken');
   }
}