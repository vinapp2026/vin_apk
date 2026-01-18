import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/user_model.dart';
import 'package:http/http.dart' as http;
class BookingCancelService{
  //Update updatePhone
  static Future<bool> bookingCancel({
    var bookingId,
  })async {

    String _result ="";
    Map data ={
      "booking_id": bookingId,
    };
    var response;
    bool success;
    response = await http.post(ApiUrl.cancelBooking,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
       success = authResponseData["success"];
    if (success == true) {
      print(authResponseData);
      //_result = authResponseData["data"];
      UserModel().success = true;
      print("ressssssssssss $success");
      //  print(_result.toString());
    } else {
     // _result = authResponseData["data"];
      success = authResponseData["success"];
      UserModel().success = false;
      // print(_result.toString());
    }
    return success;
  }
}