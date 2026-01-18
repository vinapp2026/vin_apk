import 'dart:convert';
import 'dart:io';
import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SharedPreferences/auth_shared_preferences.dart';
import '../provider/booking_provider.dart';

class AuthServices {
  String verificationId = '';
  //Login with user
  static Future<String> login({
    String? email,
    String? password,
    String? type,
    String? mobile,
  }) async {
    String _result = "";
    Map data = {
      "email": email,
      "password": password,
      "type": mobile == null ? "1" : "2",
    };
    var response;
    bool success;
    response = await http.post(ApiUrl.login,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    print("response ${authResponseData}");
    if (success == true) {
      String token = authResponseData["data"]["token"];
      int id = authResponseData["data"]["data"]["id"];
      UserModel().email = authResponseData["data"]["data"]["email"];
      UserModel().username = authResponseData["data"]["data"]["name"];
      print(token);
      await AuthSharedPreferences.setAuthSharedPreferences(
        uid: id,
        accessToken: token,
      );
      await AuthSharedPreferences.getAuthSharedPreferences();
      _result = authResponseData['message'];
      //  print(_result.toString());
    } else {
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData['message'];
      // print(_result.toString());
    }
    return _result;
  }

  //Login with
  static Future<String> loginWithPhone({
    String? password,
    String? type,
    String? mobile,
  }) async {
    String _result = "";
    Map data = {
      "mobile_number": mobile,
      "password": password,
      "type": "2",
    };
    var response;
    bool success;
    response = await http.post(ApiUrl.login,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    debugPrint('$authResponseData');
    if (success == true) {
      String token = authResponseData["data"]["token"];
      int id = authResponseData["data"]["data"]["id"];
      UserModel().phoneNo = authResponseData["data"]["data"]["mobile_number"];
      UserModel().username = authResponseData["data"]["data"]["name"];
      await AuthSharedPreferences.setAuthSharedPreferences(
        uid: id,
        accessToken: token,
      );
      await AuthSharedPreferences.getAuthSharedPreferences();
      _result = authResponseData['message'];
      //  print(_result.toString());
    } else {
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData['message'];
      // print(_result.toString());
    }
    return _result;
  }

  //Signup with Email
  static Future<String> signupWithEmail({
    String? name,
    String? email,
    String? password,
    String? type,
  }) async {
    String _result = "";
    Map data = {
      "name": name,
      "email": email,
      "password": password,
      "c_password": password,
      "type": "1",
    };
    var response;
    bool success;
    response = await http.post(ApiUrl.register,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    if (success == true) {
      //  print(authResponseData);
      String token = authResponseData["data"]["token"];
      int id = authResponseData["data"]["data"]["id"];
      UserModel().email = authResponseData["data"]["data"]["email"];
      UserModel().username = authResponseData["data"]["data"]["name"];
      await AuthSharedPreferences.setAuthSharedPreferences(
        uid: id,
        accessToken: token,
      );
      await AuthSharedPreferences.getAuthSharedPreferences();
      _result = authResponseData['message'];
      //  print(_result.toString());
    } else {
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData['message'];
      // print(_result.toString());
    }
    return _result;
  }

//Signup with Phone
  static Future<String> signupWithPhone({
    String? name,
    String? mobileNumber,
    String? password,
    BuildContext? context,
  }) async {
    String _result = "";
    debugPrint('sign up method is called');
    Map data = {
      "name": name,
      "mobile_number": mobileNumber,
      "password": password,
      "c_password": password,
      "type": "2",
    };
    var response;
    bool success;
    response = await http.post(ApiUrl.register,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    debugPrint('RESP ${authResponseData}');

    success = authResponseData["success"];
    print(success);
    if (success == true) {
      //  print(authResponseData);
      Provider.of<BookingProvider>(context!, listen: false)
          .verifyPhone(mobileNumber.toString(), context);
      // debugPrint('successs');

      String token = authResponseData["data"]["token"];
      int id = authResponseData["data"]["data"]["id"];
      UserModel().phoneNo = authResponseData["data"]["data"]["mobile_number"];
      //  UserModel().username  = authResponseData["data"]["data"]["name"];
      await AuthSharedPreferences.setAuthSharedPreferences(
        uid: id,
        accessToken: token,
      );
      await AuthSharedPreferences.getAuthSharedPreferences();
      _result = authResponseData['message'];
      //  print(_result.toString());
    } else {
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData['message'];

      // print(_result.toString());
    }
    return _result;
  }

//Forget Password With Email
  static Future<String> forgetPassword({
    String? email,
  }) async {
    String _result = "";
    Map data = {
      "email": email,
      "type": "1",
    };
    var response;
    bool success;
    response = await http.post(ApiUrl.forgotPassword,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    if (success == true) {
      UserModel().email = authResponseData['data']["email"];
      _result = authResponseData['message'];
    } else {
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData['message'];
    }
    return _result;
  }

  //Forget Password With Phone
  static Future<String> forgetPasswordWithPhone(
      {String? mobileNumber, BuildContext? context}) async {
    String _result = "";
    Map data = {
      "mobile_number": mobileNumber,
      "type": "2",
    };
    var response;
    bool success;
    response = await http.post(ApiUrl.forgotPassword,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    if (success == true) {
      Provider.of<BookingProvider>(context!, listen: false)
          .verifyPhone(mobileNumber.toString(), context);
      UserModel().phoneNo = authResponseData['data']["mobile_number"];
      _result = authResponseData['message'];
    } else {
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData['message'];
    }
    return _result;
  }

  //verifyOtp
  static Future<String> verifyOtp({
    String? email,
    String? type,
    String? otp,
  }) async {
    String _result = "";
    Map data = {"email": email, "type": "1", "otp": otp};
    var response;
    bool success;
    response = await http.post(ApiUrl.verifyOtp,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    //print(authResponseData);
    if (success == true) {
      //  print(authResponseData);
      _result = authResponseData['message'];
      print(_result.toString());
      success = authResponseData["success"];
    } else {
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData['message'];
      print(_result.toString());
      success = authResponseData["success"];
    }
    return _result;
  }

  //verifyOtp With Phone
  static Future<String> verifyOtpWithPhone({
    String? mobileNumber,
    String? otp,
    BuildContext? context,
  }) async {
    String _result = "";
    Map data = {"mobile_number": mobileNumber, "type": "2", "otp": otp};
    var response;
    bool success;
    response = await http.post(ApiUrl.verifyOtp,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    await Provider.of<BookingProvider>(context!, listen: false)
        .signInWithPhoneNumber(
            Provider.of<BookingProvider>(context, listen: false).verficationid,
            otp.toString().trim(),
            context)
        .then((value) {
      debugPrint('then is called');
      _result = "Verification successfully";
    }).onError((error, stackTrace) {
      _result = error.toString();
    });

    return _result;
  }

  //Resend OTp With Email
  static Future<String> resendOtp({
    String? email,
    String? type,
  }) async {
    String _result = "";
    Map data = {
      "email": email,
      "type": "1",
    };
    var response;
    print(email);
    bool success;
    response = await http.post(ApiUrl.resendOtp,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    print(authResponseData);
    success = authResponseData["success"];
    if (success == true) {
      _result = authResponseData['message'];
    } else {
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData['message'];
    }
    return _result;
  }

  //Resend OTP With Phone Number
  static Future<String> resendOtpWithPhone({
    String? mobileNumber,
    BuildContext? context,
  }) async {
    String _result = "";
    Map data = {
      "mobile_number": mobileNumber,
      "type": "2",
    };
    var response;
    bool success;
    response = await http.post(ApiUrl.resendOtp,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    if (success == true) {
      await Provider.of<BookingProvider>(context!, listen: false)
          .verifyPhone(mobileNumber.toString(), context, isResendOtp: true);
      _result = authResponseData['message'];
    } else {
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData['message'];
    }
    return _result;
  }

  //Reset Password
  static Future<String> resetPassword({
    String? email,
    String? password,
  }) async {
    String _result = "";
    Map data = {
      "email": email,
      "password": password,
      "c_password": password,
      "type": "1",
    };
    var response;
    bool success;
    response = await http.post(ApiUrl.resetPassword,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    if (success == true) {
      _result = authResponseData['message'];
      //  print(_result.toString());
    } else {
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData['message'];
      // print(_result.toString());
    }
    return _result;
  }

//Reset Password With Phone
  static Future<String> resetPasswordWithPhone({
    String? mobileNumber,
    String? password,
  }) async {
    String _result = "";
    Map data = {
      "mobile_number": mobileNumber,
      "password": password,
      "c_password": password,
      "type": "2",
    };
    var response;
    bool success;
    response = await http.post(ApiUrl.resetPassword,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    if (success == true) {
      _result = authResponseData['message'];
      //  print(_result.toString());
    } else {
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData['message'];
      // print(_result.toString());
    }
    return _result;
  }

  //Update Email
  static Future<bool> updateEmail({
    String? email,
  }) async {
    String _result = "";
    Map data = {"email": email, "type": "1"};
    var response;
    bool success;
    response = await http.post(ApiUrl.updateEmailPhone,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    print(authResponseData);
    if (success == true) {
      print(authResponseData);
      // UserModel().email = authResponseData['data']["email"];
      // UserModel().username = authResponseData['data']["name"];
      // UserModel().phoneNo = authResponseData['data']["mobile_number"];
      // UserModel().bio = authResponseData['data']["bio"];
      // UserModel().gender = authResponseData['data']["gender"];
      // UserModel().img = authResponseData['data']['avatar'];
      // UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData["message"];
      success = authResponseData["success"];
      //  print(_result.toString());
    } else {
      _result = authResponseData["message"];
      success = authResponseData["success"];
      // print(_result.toString());
    }
    return success;
  }

  //updatePhoneVerifyOTp
  static Future<String> updateEmailVerifyOTp({
    String? email,
    String? otp,
  }) async {
    String _result = "";
    Map data = {"email": email, "type": "1", "otp": otp};
    var response;
    bool success;
    response = await http.post(ApiUrl.updateEmailPhoneVerifyOTP,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    if (success == true) {
      print(authResponseData);
      _result = authResponseData['message'];
      //  print(_result.toString());
      success = authResponseData["success"];
    } else {
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData['message'];
      print(_result.toString());
      success = authResponseData["success"];
    }
    return _result;
  }

//Update updatePhone
  static Future<bool> updatePhone({
    String? mobileNumber,
  }) async {
    String _result = "";
    Map data = {"mobile_number": mobileNumber, "type": "2"};
    var response;
    bool success;
    response = await http.post(ApiUrl.updateEmailPhone,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    print(authResponseData);
    if (success == true) {
      print(authResponseData);
      // UserModel().email = authResponseData['data']["email"];
      // UserModel().username = authResponseData['data']["name"];
      // UserModel().phoneNo = authResponseData['data']["mobile_number"];
      // UserModel().bio = authResponseData['data']["bio"];
      // UserModel().gender = authResponseData['data']["gender"];
      // UserModel().img = authResponseData['data']['avatar'];
      // UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData["message"];
      success = authResponseData["success"];
      //  print(_result.toString());
    } else {
      _result = authResponseData["message"];
      success = authResponseData["success"];
      // print(_result.toString());
    }
    return success;
  }

  //updatePhoneVerifyOTp
  static Future<bool> updatePhoneVerifyOTp({
    String? mobileNumber,
    String? otp,
  }) async {
    String _result = "";
    Map data = {"mobile_number": mobileNumber, "type": "2", "otp": otp};
    var response;
    bool success;
    response = await http.post(ApiUrl.updateEmailPhoneVerifyOTP,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    if (success == true) {
      //  print(authResponseData);
      _result = authResponseData['message'];
      //  print(_result.toString());
      success = authResponseData["success"];
    } else {
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData['message'];
      // print(_result.toString());
      success = authResponseData["success"];
    }
    return success;
  }

//Update User Info
  static Future<bool> updateUserInfo({
    String? name,
    String? gender,
    String? bio,
    String? mobileNumber,
  }) async {
    String _result = "";
    Map data = {
      "name": name,
      "gender": gender,
      "bio": bio,
      "mobile_number": mobileNumber,
    };
    var response;
    bool success;
    response = await http.post(ApiUrl.updateUserInfo,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    print(authResponseData);
    if (success == true) {
      // UserModel().email = authResponseData['data']["email"];
      // UserModel().username = authResponseData['data']["name"];
      // UserModel().phoneNo = authResponseData['data']["mobile_number"];
      // UserModel().bio = authResponseData['data']["bio"];
      // UserModel().gender = authResponseData['data']["gender"];
      // UserModel().img = authResponseData['data']['avatar'];
      // UserModel().errorMessage = authResponseData['message'];
      // _result = authResponseData["message"];
      success = authResponseData["success"];
      //  print(_result.toString());
    } else {
      _result = authResponseData["message"];
      success = authResponseData["success"];
      // print(_result.toString());
    }
    return success;
  }

//Update User Profile
  static Future<String> updateUserProfile({
    File? profilePhoto,
  }) async {
    String _result = "";
    Map data = {
      "avatar": profilePhoto!.path,
    };
    var response;
    bool success;
    response = await http.post(ApiUrl.updateUserProfile,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    print(authResponseData);
    if (success == true) {
      print(authResponseData);
      // UserModel().email = authResponseData['data']["email"];
      // UserModel().username = authResponseData['data']["name"];
      // UserModel().phoneNo = authResponseData['data']["mobile_number"];
      // UserModel().bio = authResponseData['data']["bio"];
      // UserModel().gender = authResponseData['data']["gender"];
      // UserModel().img = authResponseData['data']['avatar'];
      // UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData["message"];
      //  print(_result.toString());
    } else {
      _result = authResponseData["message"];
      // print(_result.toString());
    }
    return _result;
  }

  static Future uploadImage({required File image}) async {
    print("image path ${image.path}");
    final Map<String, dynamic> authResponseData;
    var url = Uri.parse("${ApiUrl.BaseUrl}update-user-profile");
    try {
      var request = http.MultipartRequest('POST', url);

      request.headers["Content-Type"] = "application/json";
      request.headers["Accept"] = "application/json";
      request.headers["Authorization"] = 'Bearer ${UserModel().token}';
      request.files.add(await http.MultipartFile.fromPath('avatar', image.path,
          contentType: new MediaType('avatar', 'png')));
      var response = await request.send();
      print(response.stream);
      print('cccc ${response.statusCode}');
      final res = await http.Response.fromStream(response);
      authResponseData = json.decode(res.body.toString());
      print(authResponseData);

      print("res ${authResponseData}");
      // print('reee ${authResponseData['uploadedFiles'][0]['filePath']}');
      // await updateImageProfile(link: authResponseData['originalFiles'][0]['filePath'],context: context);
    } catch (e) {
      print('Please try again $e');
    }
  }

  //Get User Info
  static Future<String> getUserInfo() async {
    String _result = "";
    var response;
    bool success;
    response = await http.get(
      ApiUrl.getUserInfo,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer ${UserModel().token}'
      },
    );
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    // print(authResponseData);
    if (success == true) {
      UserModel().email = authResponseData['data']["email"];
      UserModel().username = authResponseData['data']["name"];
      UserModel().phoneNo = authResponseData['data']["mobile_number"];
      UserModel().bio = authResponseData['data']["bio"];
      UserModel().gender = authResponseData['data']["gender"];
      UserModel().img = authResponseData['data']['avatar'];
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData["message"];
      //  print(_result.toString());
    } else {
      _result = authResponseData["message"];
      // print(_result.toString());
    }
    return _result;
  }

//Logout
  static Future<String> logout() async {
    String _result = "";
    var response;
    bool success;
    response = await http.post(
      ApiUrl.logout,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer ${UserModel().token}'
      },
    );
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    print(authResponseData);
    if (success == true) {
      _result = authResponseData["message"];
      //  print(_result.toString());
    } else {
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData["message"];
      // print(_result.toString());
    }
    return _result;
  }

  //deleteAccount
  static Future<String> deleteAccount() async {
    String _result = "";
    var response;
    bool success;
    response = await http.get(
      ApiUrl.deleteAccount,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer ${UserModel().token}'
      },
    );
    final Map<String, dynamic> authResponseData = json.decode(response.body);
    success = authResponseData["success"];
    print(authResponseData);
    if (success == true) {
      _result = authResponseData["message"];
      //  print(_result.toString());
    } else {
      UserModel().errorMessage = authResponseData['message'];
      _result = authResponseData["message"];
      // print(_result.toString());
    }
    return _result;
  }
}
