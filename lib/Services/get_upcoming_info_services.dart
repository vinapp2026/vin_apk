import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/get_upcoming_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:http/http.dart' as http;
class GetUpcomingInfoServices{
  static Future<GetUpcomingInfoModel?> getUpComingInfo({
    int? stadiumId,
  }) async {
    String _result ="";
    GetUpcomingInfoModel? getUpcomingInfoModel;
    var response;
    String url = "${ApiUrl.getUpcomingInfo}$stadiumId";
    Uri uri = Uri.parse(url);
    response = await http.get(uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
    );
  //  print(response.body);
    if (response.statusCode == 200) {
      getUpcomingInfoModel = await GetUpcomingInfoModel.fromJson(jsonDecode(response.body)) ;
      print(getUpcomingInfoModel.data![0].id);

    }
    return getUpcomingInfoModel;
  }

}