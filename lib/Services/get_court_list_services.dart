import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/get_court_list_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:http/http.dart' as http;
class GetCourtListServices{
  static Future<GetCourtListModel?> getCourtList({
    int? stadiumId,
  }) async {
    String _result ="";
    GetCourtListModel? getCourtListModel;
    Map data ={
      "courtType": "1",
    };
    var response;
    String url = "${ApiUrl.getCourtList}$stadiumId";
    Uri uri = Uri.parse(url);
    response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    if (response.statusCode == 200) {
      getCourtListModel = await GetCourtListModel.fromJson(jsonDecode(response.body)) ;
      print(getCourtListModel.data![0].id);

    }
    return getCourtListModel;
  }

}