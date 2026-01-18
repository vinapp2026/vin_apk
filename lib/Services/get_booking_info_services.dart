import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/get_booking_info_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:http/http.dart' as http;
class GetBookingInfoServices{
  static Future<GetBookingInfoModel?> getBookingInfo({
    int? bookingId,
  }) async {
    String _result ="";
    GetBookingInfoModel? getBookingInfoModel;
    var response;
    Map data ={
      "bookingID": bookingId,
    };
    print(bookingId);
    response = await http.post(ApiUrl.getBookingInfo,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    print(response.body);
    if (response.statusCode == 200) {
      getBookingInfoModel = await GetBookingInfoModel.fromJson(jsonDecode(response.body)) ;
     // print(getBookingInfoModel.data!);

    }
    return getBookingInfoModel;
  }

}