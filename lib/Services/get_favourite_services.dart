import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/favourite_list_model.dart';
import 'package:VIN/models/get_stadium_list_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:http/http.dart' as http;
class GetFavouriteServices{
  static Future<FavouriteListModel?> getFavouriteList() async {
    String _result ="";
    FavouriteListModel? favouriteListModel;
    var response;
    response = await http.post(ApiUrl.getFavouriteEvent,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
    );
    print(UserModel().token);
    print(response.body);
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    bool success = authResponseData["success"];
    success = authResponseData["success"];
    if (response.statusCode == 200) {
      favouriteListModel = await FavouriteListModel.fromJson(jsonDecode(response.body)) ;
      // poiModel = await poiModelFromJson(response.body) ;
       print(favouriteListModel.data![0].stadiumLatitude);

    }
    return favouriteListModel;
  }

}