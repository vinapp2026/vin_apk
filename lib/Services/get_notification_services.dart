import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/get_stadium_info_model.dart';
import 'package:VIN/models/notification_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:http/http.dart' as http;
class GetNotificationServices{
  static Future<NotificationModel?> getNotificationInfo() async {
    String _result ="";
    NotificationModel? notificationModel;
    var response;
    String url = "${ApiUrl.getStadiumInfo}";
    Uri uri = Uri.parse(url);
    response = await http.get(ApiUrl.getNotification,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        );
    if (response.statusCode == 200) {
      notificationModel = await NotificationModel.fromJson(jsonDecode(response.body)) ;
      print(notificationModel.data![0].id);

    }
    return notificationModel;
  }

}