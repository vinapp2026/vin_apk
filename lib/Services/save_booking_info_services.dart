import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/save_booking_info_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:http/http.dart' as http;

class SaveBookingInfoServices{
  static Future<SaveBookingInfoModel?> saveBookingInfo({
    var bookingType,
    var slotId,
    var courtId,
    var amount,
    var timeID,
    var bookingDate,
    var stadiumID,
  }) async {
    Map data ={
      "bookingType": bookingType,
      "slotID": slotId,
      "courtID": courtId,
      "amount": amount,
    //  "bookingID": bookingID,
      //"timeID": timeID==null?"":timeID,
      "bookingDate": bookingDate,
      "stadiumID": stadiumID
    };

    SaveBookingInfoModel? saveBookingInfoModel;
    var response;
    response = await http.post(ApiUrl.saveBookingInfo,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    print(response.body);
    if (response.statusCode == 200) {
      saveBookingInfoModel = await SaveBookingInfoModel.fromJson(jsonDecode(response.body)) ;
      print(saveBookingInfoModel.data!.id);
    }else{
      saveBookingInfoModel = await SaveBookingInfoModel.fromJson(jsonDecode(response.body)) ;
    }
    return saveBookingInfoModel;
  }


  static Future<SaveBookingInfoModel?> saveBookingInfo2({
    var bookingType,
    var slotId,
    var courtId,
    var amount,
    //   var bookingID,
    var timeID,
    var bookingDate,
    var stadiumID,
  }) async {
    Map data ={
      "bookingType": bookingType,
      "slotID": slotId,
      "courtID": courtId,
      "amount": amount,
      //  "bookingID": bookingID,
      "timeID":timeID,
      "bookingDate": bookingDate,
      "stadiumID": stadiumID
    };

    SaveBookingInfoModel? saveBookingInfoModel;
    var response;
    response = await http.post(ApiUrl.saveBookingInfo,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    print(response.body);
    if (response.statusCode == 200) {
      saveBookingInfoModel = await SaveBookingInfoModel.fromJson(jsonDecode(response.body)) ;
      print(saveBookingInfoModel.data!.id);
    }else{
      saveBookingInfoModel = await SaveBookingInfoModel.fromJson(jsonDecode(response.body)) ;
    }
    return saveBookingInfoModel;
  }
}