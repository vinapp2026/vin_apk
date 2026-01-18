import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/get_stadium_list_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:http/http.dart' as http;
class GetStadiumListServices{
  static Future<GetStadiumListModel?> getStadiumList({
    double? latitude,
    double? longitude
  }) async {
    String _result ="";
    GetStadiumListModel? getStadiumListModel;
    Map data ={
      "latitude": latitude,
      "longitude": longitude
    };
    var response;
    response = await http.post(ApiUrl.getStadiumList,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    //print(response.body);
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    bool success = authResponseData["success"];
    success = authResponseData["success"];
    if (response.statusCode == 200) {
      getStadiumListModel = await GetStadiumListModel.fromJson(jsonDecode(response.body)) ;
       print(getStadiumListModel.success);
    }
    return getStadiumListModel;
  }

}