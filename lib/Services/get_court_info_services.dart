import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/get_court_info_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:http/http.dart' as http;
class GetCourtInfoServices{
  static Future<GetCourtInfoModel?> getCourtInfo({
    int? courtId,
  }) async {
    String _result ="";
    GetCourtInfoModel? getCourtInfoModel;
    var response;
    String url = "${ApiUrl.getCourtInfo}$courtId";
    Uri uri = Uri.parse(url);
    Map data ={
      "courtType": "1",
    };
    response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    if (response.statusCode == 200) {
      getCourtInfoModel = await GetCourtInfoModel.fromJson(jsonDecode(response.body)) ;
      print(getCourtInfoModel.data!.id);

    }
    return getCourtInfoModel;
  }

  static Future<GetCourtInfoModel?> getCourtInfoBulk({
    int? courtId,
  }) async {
    String _result ="";
    GetCourtInfoModel? getCourtInfoModel;
    var response;
    String url = "${ApiUrl.getCourtInfo}$courtId";
    Uri uri = Uri.parse(url);
    Map data ={
      "courtType": "2",
    };
    response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    if (response.statusCode == 200) {
      getCourtInfoModel = await GetCourtInfoModel.fromJson(jsonDecode(response.body)) ;
      print(getCourtInfoModel.data!.id);

    }
    return getCourtInfoModel;
  }

}