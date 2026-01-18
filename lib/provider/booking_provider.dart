import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/models/save_booking_info_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:VIN/provider/home_page_provider.dart';
import 'package:VIN/screens/homePage/home_page.dart';
import 'package:VIN/screens/homePage/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../screens/PickLocation/pick_location_screen.dart';
import '../utilites/helper.dart';
import 'main_provider.dart';

class BookingProvider extends ChangeNotifier {
  SaveBookingInfoModel? saveBookingInfoModel;
  var message;
  saveBookingInfo({
    var bookingType,
    var slotId,
    var courtId,
    var amount,
    var timeID,
    var bookingDate,
    var stadiumID,
  }) async {
    message = "";
    Map data = {
      "bookingType": bookingType,
      "slotID": slotId,
      "courtID": courtId,
      "amount": amount,
      //  "bookingID": bookingID,
      //"timeID": timeID==null?"":timeID,
      "bookingDate": bookingDate,
      "stadiumID": stadiumID
    };
    print("data: ${data}");
    var response;
    response = await http.post(ApiUrl.saveBookingInfo,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    if (response.statusCode == 200) {
      final Map<String, dynamic> authResponseData = json.decode(response.body);
      print(authResponseData);
      message = authResponseData["message"];
      // print("meeeeeesaaaaaage Success $message");
      saveBookingInfoModel =
          await SaveBookingInfoModel.fromJson(jsonDecode(response.body));
      // print(saveBookingInfoModel!.data!.id);
    } else {
      final Map<String, dynamic> authResponseData = json.decode(response.body);
      print(authResponseData);
      message = authResponseData["message"];
      // print("meeeeeesaaaaaage $message");
    }
    notifyListeners();
    return saveBookingInfoModel;
  }

  //

  saveBookingInfo2({
    var bookingType,
    var slotId,
    var courtId,
    var amount,
    //   var bookingID,
    var timeID,
    var bookingDate,
    var stadiumID,
  }) async {
    message = "";
    Map data = {
      "bookingType": bookingType,
      "slotID": slotId,
      "courtID": courtId,
      "amount": amount,
      //  "bookingID": bookingID,
      "timeID": timeID,
      "bookingDate": bookingDate,
      "stadiumID": stadiumID
    };

    SaveBookingInfoModel? saveBookingInfoModel;
    var response;
    response = await http.post(ApiUrl.saveBookingInfo,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer ${UserModel().token}'
        },
        body: json.encode(data));
    print(response.body);
    if (response.statusCode == 200) {
      saveBookingInfoModel =
          await SaveBookingInfoModel.fromJson(jsonDecode(response.body));
      final Map<String, dynamic> authResponseData = json.decode(response.body);
      print(authResponseData);
      message = authResponseData["message"];
      print("meeeeeesaaaaaage Success $message");
    } else {
      final Map<String, dynamic> authResponseData = json.decode(response.body);
      print(authResponseData);
      message = authResponseData["message"];
      // print("meeeeeesaaaaaage $message");
    }
    notifyListeners();
    return saveBookingInfoModel;
  }

  //  Sign in with phone number firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verficationid = '';

  verifyPhone(String phoneNumber, BuildContext context,
      {bool isResendOtp = false}) async {
    int? forceResendToken;
    await  FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber.toString().trim(),
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatically handles verification on some devices

      },
      verificationFailed: (FirebaseAuthException exception) {
        // Handle verification failure
        debugPrint(exception.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        debugPrint('code sent');
        forceResendToken = resendToken;
        verficationid = verificationId;
        notifyListeners();

        // Save the verification ID somewhere to use it later
        // e.g., in a state variable
        // and show a UI to enter the verification code
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      forceResendingToken: isResendOtp ? forceResendToken : null,
    );
    notifyListeners();
  }

  Future signInWithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    debugPrint('$smsCode');
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await _signInWithCredential(credential, context);
  }

  UserCredential? userCredential;
  _signInWithCredential(
      PhoneAuthCredential credential, BuildContext context) async {
    userCredential = await _auth.signInWithCredential(credential);
    debugPrint('User :${userCredential?.user}');
    // try {
    //
    //   final User? user = userCredential.user;
    //   if (user != null) {
    //     Provider.of<MainProvider>(context, listen: false)
    //         .changeIsLoading(false);
    //     Helper.showSnack(context, "successful");
    //     Helper.toRemoveUntiScreen(context, PickLocationScreen());
    //   } else {
    //     Provider.of<MainProvider>(context, listen: false)
    //         .changeIsLoading(false);
    //     Helper.showSnack(context, "Verification Failed");
    //   }
    //
    //   // Authentication successful, do something with the user
    // } catch (e) {
    //   // Handle authentication failure
    // }
    notifyListeners();
  }

  deleteUserFromFirebase() async {
    User? user = userCredential?.user;
    if (user != null) {
      try {
        await user.delete();
        print('User deleted successfully.');
      } catch (e) {
        print('Error deleting user: $e');
      }
    } else {
      print('No user currently signed in.');
    }
    notifyListeners();
  }
}
