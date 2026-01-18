import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/get_stadium_list_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:http/http.dart' as http;
class SearchStadiumServices{
  static  searchStadiumList({
    String? searchData
  }) async {
    String _result ="";
    GetStadiumListModel? getStadiumListModel;
    Map data ={
      "search_data": searchData,
      "latitude": UserModel().latitude,
      "longitude": UserModel().longitude
    };
    var response;
    response = await http.post(ApiUrl.searchStadium,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
   // print(response.body);
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    bool success = authResponseData["success"];
    success = authResponseData["success"];
    if (response.statusCode == 200) {
      getStadiumListModel = await GetStadiumListModel.fromJson(jsonDecode(response.body)) ;
      // poiModel = await poiModelFromJson(response.body) ;
       print(getStadiumListModel.data![0].latitude);
    }
    return getStadiumListModel;
  }

}