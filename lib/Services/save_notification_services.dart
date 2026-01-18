import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/user_model.dart';
import 'package:http/http.dart' as http;
class SaveNotificationServices{
  static Future<dynamic> saveNotificationInfo({
    var bookingID,
    var orderID,
    var comment,
    var status,
  }) async {
    String _result ="";
    Map data ={
      "bookingID": bookingID,
      "orderID": orderID,
      "comment": comment,
      "status": status,
    };
    var response;
    response = await http.post(ApiUrl.saveNotification,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    if (response.statusCode == 200) {
      print("Save Notification to Api Success");
    }else{
      print(response.body);
      print("Failed");
    }
    // return getStadiumInfoModel;
  }

  static Future<dynamic> saveNotificationInfo2({
    var comment,
    var status,
  }) async {
    String _result ="";
    Map data ={
      "comment": comment,
      "status": status,
    };
    var response;
    response = await http.post(ApiUrl.saveNotification,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    if (response.statusCode == 200) {
      print("Save Notification to Api Success");
    }else{
      print(response.body);
      print("Failed");
    }
    // return getStadiumInfoModel;
  }
}