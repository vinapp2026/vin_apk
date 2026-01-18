import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/user_model.dart';
import 'package:http/http.dart' as http;
class SavePaymentServices{
  static Future<dynamic> savePaymentInfo({
    var bookingID,
    var orderID,
    var amount,
    var payment_status,
    var rz_py_id,
    var rz_od_id,
    var rz_signature,
  }) async {
    String _result ="";
    Map data ={
      "bookingID": bookingID,
      "orderID": orderID,
      "amount": amount,
      "payment_status": payment_status,
      "rz_py_id": rz_py_id,
      "rz_od_id": rz_od_id,
      "rz_signature": rz_signature,
    };
    var response;
    response = await http.post(ApiUrl.savePaymentInfo,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    if (response.statusCode == 200) {
        print("Save Payment to Api Success");
        print(response.body);
    }else{
      print("save payment response Failed");
      print(response.body);
    }
   // return getStadiumInfoModel;
  }

}