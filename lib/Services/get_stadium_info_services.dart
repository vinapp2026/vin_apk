import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/get_stadium_info_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:http/http.dart' as http;
class GetStadiumInfoServices{
  static Future<GetStadiumInfoModel?> getStadiumInfo({
    int? stadiumId,
    double? latitude,
    double? longitude
  }) async {
    String _result ="";
    GetStadiumInfoModel? getStadiumInfoModel;
    Map data ={
      "latitude": latitude,
      "longitude": longitude
    };
    var response;
    String url = "${ApiUrl.getStadiumInfo}$stadiumId";
    Uri uri = Uri.parse(url);
    response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    if (response.statusCode == 200) {
    //  print(response.body);
      getStadiumInfoModel = await GetStadiumInfoModel.fromJson(jsonDecode(response.body)) ;
      // print(getStadiumInfoModel.data!.id);

    }
    return getStadiumInfoModel;
  }

}