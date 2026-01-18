import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/get_court_bulk_info_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:http/http.dart' as http;
class GetCourtBulkInfoServices{
  static Future<GetCourtBulkInfoModel?> getCourtBulkInfo({
    int? courtId,
  }) async {
    String _result ="";
    GetCourtBulkInfoModel? getCourtBulkInfoModel;
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
      getCourtBulkInfoModel = await GetCourtBulkInfoModel.fromJson(jsonDecode(response.body)) ;
      print(getCourtBulkInfoModel.data!.id);

    }
    return getCourtBulkInfoModel;
  }

}