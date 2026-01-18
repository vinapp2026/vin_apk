import 'dart:async';

import 'package:VIN/Services/auth_services.dart';
import 'package:VIN/models/user_model.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/screens/Account/edit_profile_screen.dart';
import 'package:VIN/screens/PickLocation/pick_location_screen.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:VIN/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

import '../../provider/home_page_provider.dart';
import '../homePage/home_page.dart';

class OTPScreen2 extends StatefulWidget {
  bool? isUpdate;
  final String? phoneNo;

  OTPScreen2({this.isUpdate, Key? key, this.phoneNo}) : super(key: key);

  @override
  State<OTPScreen2> createState() => _OTPScreen2State();
}

class _OTPScreen2State extends State<OTPScreen2> {
  var text1Controller = TextEditingController();
  var verificaitonPin = "";
  final formKey = GlobalKey<FormState>();

  //Verify Otp with Email
  verifyOtp(BuildContext context) async {
    Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
    var result = await AuthServices.verifyOtp(
      email: UserModel().email.toString(),
      otp: verificaitonPin,
    );
    print(result);
    if (result == "Verification successfully") {
      Helper.toRemoveUntiScreen(context, PickLocationScreen());
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
      Helper.showSnack(context, "Login Successfully");
    } else {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
      Helper.showSnack(context, "Wrong Otp Code");
    }
  }

  //Verify Otp with Phone
  verifyOtpPhone(BuildContext context) async {
    Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);

    var result = await AuthServices.verifyOtpWithPhone(
        mobileNumber: UserModel().phoneNo.toString(),
        otp: verificaitonPin,
        context: context);
    print(result);

    if (result == 'Verification successfully') {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);

      Helper.toRemoveUntiScreen(context, PickLocationScreen());
    } else {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
      Helper.showSnack(context, "Verification Failed");
    }

    //updateEmailVerifyOTp
    updateEmailVerifyOTp(BuildContext context) async {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
      var result = await AuthServices.updateEmailVerifyOTp(
        email: UserModel().email.toString(),
        otp: verificaitonPin,
      );
      print(result);
      if (result == "Your email updated successfully.") {
        AuthServices.getUserInfo();
        Provider.of<MainProvider>(context, listen: false)
            .changeIsLoading(false);
        Helper.showSnack(context, "Your email updated successfully.");
        var count = 0;
        Navigator.popUntil(context, (route) {
          return count++ == 2;
        });
      } else {
        Provider.of<MainProvider>(context, listen: false)
            .changeIsLoading(false);
        Helper.showSnack(context, "$result");
      }
    }

    //updatePhoneVerifyOTp
    updatePhoneVerifyOTp(BuildContext context) async {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
      var result = await AuthServices.updatePhoneVerifyOTp(
        mobileNumber: UserModel().phoneNo.toString(),
        otp: verificaitonPin,
      );
      print(result);
      if (result == true) {
        AuthServices.getUserInfo();
        Provider.of<MainProvider>(context, listen: false)
            .changeIsLoading(false);
        Helper.showSnack(context, "Valid OTP");
        var count = 0;
        Navigator.popUntil(context, (route) {
          return count++ == 2;
        });
      } else {
        Provider.of<MainProvider>(context, listen: false)
            .changeIsLoading(false);
        Helper.showSnack(context, "Invalid OTP");
      }
    }

//Resend Otp with Email
    resendOtp(BuildContext context) async {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading2(true);
      var result = await AuthServices.resendOtp(
        email: UserModel().email.toString(),
      );
      print(result);
      if (result == "Verification code sent successfully") {
        Provider.of<MainProvider>(context, listen: false)
            .changeIsLoading2(false);
        Helper.showSnack(context, "$result");
      } else {
        Provider.of<MainProvider>(context, listen: false)
            .changeIsLoading2(false);
        Helper.showSnack(context, "$result");
      }
    }

//Resend Otssocialp with Phone
    resendOtpWithPhone(BuildContext context) async {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading2(true);
      var result = await AuthServices.resendOtpWithPhone(
          mobileNumber: UserModel().phoneNo, context: context);
      print(result);
      if (result == "Verification code sent successfully") {
        Provider.of<MainProvider>(context, listen: false)
            .changeIsLoading2(false);
        Helper.showSnack(context, "$result");
      } else {
        Provider.of<MainProvider>(context, listen: false)
            .changeIsLoading2(false);
        Helper.showSnack(context, "$result");
      }
    }

    //
    Timer? timer1;
    int _start = 29;
    bool? visibleButton = false;
    void startTimer() {
      const oneSec = const Duration(seconds: 1);
      timer1 = new Timer.periodic(oneSec, (Timer timer) {
        setState(
          () {
            if (_start <= 0) {
              //_start = 59;
              timer.cancel();
              visibleButton = true;
              // visibleTimer = false;
            } else {
              _start = _start - 1;
            }
          },
        );
      });
    }

    @override
    void initState() {
      super.initState();
      startTimer();
      text1Controller = TextEditingController();
    }

    @override
    Widget build(BuildContext context) {
      // MainProvider mainProvider =
      // Provider.of<MainProvider>(context, listen: true);
      return CustomParentWidget(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  //Appbar
                  Container(
                    height: 80,
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Row(
                      children: [
                        // CustomInkWell(
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Image.asset(
                        //       "assets/icons/ic_back.png",
                        //       color: darkBlueColor,
                        //     ),
                        //   ),
                        // ),
                        // //Space
                        SizedBox(
                          width: 12,
                        ),
                        //
                        Expanded(
                          child: CustomText(
                            title: "Verify Number",
                            fontSize: 18,
                            color: darkBlueColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ), //
                  //Space
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      title:
                          UserModel().email == null || UserModel().email == ''
                              ? "Enter OTP received on\n"
                                  "${widget.phoneNo}"
                              : "Enter OTP received on\n"
                                  "${UserModel().email}",
                      fontSize: 14,
                      color: darkBlueColor,
                    ),
                  ),
                  //Space
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: PinCodeTextField(
                      autofocus: true,
                      controller: text1Controller,
                      hideCharacter: false,
                      highlight: false,
                      highlightColor: darkBlueColor,
                      defaultBorderColor: kPrimaryColor,
                      highlightPinBoxColor: lightblueColor,
                      hasTextBorderColor: kPrimaryColor,
                      // highlightPinBoxColor: Colors.orange,
                      maxLength:
                          UserModel().email == null || UserModel().email == ''
                              ? 6
                              : 4,
                      onDone: (text) {
                        verificaitonPin = text;
                      },
                      pinBoxWidth: 40,
                      pinBoxHeight: 40,
                      hasUnderline: false,
                      wrapAlignment: WrapAlignment.spaceAround,
                      pinBoxDecoration:
                          ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                      pinTextStyle: TextStyle(fontSize: 16.0),
                      pinBoxRadius: 8,
                      pinTextAnimatedSwitcherTransition:
                          ProvidedPinBoxTextAnimation.scalingTransition,
                      maskCharacter: '',
//                    pinBoxColor: Colors.green[100],
                      pinTextAnimatedSwitcherDuration:
                          Duration(milliseconds: 300),
//                    highlightAnimation: true,
                      highlightAnimationBeginColor: darkBlueColor,
                      highlightAnimationEndColor: darkBlueColor,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Provider.of<MainProvider>(context).isLoading
                        ? CupertinoActivityIndicator()
                        : CustomButton(
                            onPressed: () {
                              if (widget.isUpdate == true) {
                                if (UserModel().email != null ||
                                    UserModel().email != "") {
                                  updateEmailVerifyOTp(context);
                                } else {
                                  updatePhoneVerifyOTp(context);
                                }
                              } else {
                                if (UserModel().email != null ||
                                    UserModel().email != "") {
                                  verifyOtp(context);
                                } else {
                                  verifyOtpPhone(context);
                                }
                              }
                            },
                            btnHeight: 48,
                            btnRadius: 8,
                            title: "Verify",
                            fontWeight: FontWeight.w600,
                            btnColor: kPrimaryColor,
                            textColor: whiteColor,
                            fontSize: 18,
                          ),
                  ),
                  //Space
                  SizedBox(
                    height: 20,
                  ),
                  //
                  Container(
                    child: visibleButton == false
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 22),
                            alignment: Alignment.center,
                            child: Text(
                              "Resend code $_start" + "s",
                              style: TextStyle(
                                  color: greyColor,
                                  fontSize: 11,
                                  fontFamily: 'medium'),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            alignment: Alignment.centerLeft,
                            child: Provider.of<MainProvider>(context).isLoading2
                                ? Center(child: CupertinoActivityIndicator())
                                : CustomInkWell(
                                    onTap: () {
                                      if (UserModel().email != null) {
                                        resendOtp(context);
                                        startTimer();
                                        setState(() {
                                          _start = 29;
                                          visibleButton = false;
                                        });
                                        print(UserModel().email);
                                      } else {
                                        resendOtpWithPhone(context);
                                        startTimer();
                                        setState(() {
                                          _start = 29;
                                          visibleButton = false;
                                        });
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            title: "Didn’t get an OTP? ",
                                            fontSize: 13,
                                            color: darkBlueColor,
                                          ),
                                          CustomText(
                                            title: "Resend OTP",
                                            fontSize: 13,
                                            color: blueColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  //updateEmailVerifyOTp
  updateEmailVerifyOTp(BuildContext context) async {
    Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
    var result = await AuthServices.updateEmailVerifyOTp(
      email: UserModel().email.toString(),
      otp: verificaitonPin,
    );
    print(result);
    if (result == "Your email updated successfully.") {
      AuthServices.getUserInfo();
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
      Helper.showSnack(context, "Your email updated successfully.");
      var count = 0;
      Navigator.popUntil(context, (route) {
        return count++ == 2;
      });
    } else {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
      Helper.showSnack(context, "$result");
    }
  }

  //updatePhoneVerifyOTp
  updatePhoneVerifyOTp(BuildContext context) async {
    Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
    var result = await AuthServices.updatePhoneVerifyOTp(
      mobileNumber: UserModel().phoneNo.toString(),
      otp: verificaitonPin,
    );
    print(result);
    if (result == true) {
      AuthServices.getUserInfo();
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
      Helper.showSnack(context, "Valid OTP");
      var count = 0;
      Navigator.popUntil(context, (route) {
        return count++ == 2;
      });
    } else {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
      Helper.showSnack(context, "Invalid OTP");
    }
  }

//Resend Otp with Email
  resendOtp(BuildContext context) async {
    Provider.of<MainProvider>(context, listen: false).changeIsLoading2(true);
    var result = await AuthServices.resendOtp(
      email: UserModel().email.toString(),
    );
    print(result);
    if (result == "Verification code sent successfully") {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading2(false);
      Helper.showSnack(context, "$result");
    } else {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading2(false);
      Helper.showSnack(context, "$result");
    }
  }

//Resend Otssocialp with Phone
  resendOtpWithPhone(BuildContext context) async {
    Provider.of<MainProvider>(context, listen: false).changeIsLoading2(true);
    var result = await AuthServices.resendOtpWithPhone(
        mobileNumber: UserModel().phoneNo, context: context);
    print(result);
    if (result == "Verification code sent successfully") {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading2(false);
      Helper.showSnack(context, "$result");
    } else {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading2(false);
      Helper.showSnack(context, "$result");
    }
  }

  //
  Timer? timer1;
  int _start = 29;
  bool? visibleButton = false;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer1 = new Timer.periodic(oneSec, (Timer timer) {
      setState(
        () {
          if (_start <= 0) {
            //_start = 59;
            timer.cancel();
            visibleButton = true;
            // visibleTimer = false;
          } else {
            _start = _start - 1;
          }
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    text1Controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // MainProvider mainProvider =
    // Provider.of<MainProvider>(context, listen: true);
    return CustomParentWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                //Appbar
                Container(
                  height: 80,
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: Row(
                    children: [
                      // CustomInkWell(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Image.asset(
                      //       "assets/icons/ic_back.png",
                      //       color: darkBlueColor,
                      //     ),
                      //   ),
                      // ),
                      // //Space
                      SizedBox(
                        width: 12,
                      ),
                      //
                      Expanded(
                        child: CustomText(
                          title: "Verify Number",
                          fontSize: 18,
                          color: darkBlueColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ), //
                //Space
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    title: UserModel().email == null || UserModel().email == ''
                        ? "Enter OTP received on\n"
                            "${widget.phoneNo}"
                        : "Enter OTP received on\n"
                            "${UserModel().email}",
                    fontSize: 14,
                    color: darkBlueColor,
                  ),
                ),
                //Space
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: PinCodeTextField(
                    autofocus: true,
                    controller: text1Controller,
                    hideCharacter: false,
                    highlight: false,
                    highlightColor: darkBlueColor,
                    defaultBorderColor: kPrimaryColor,
                    highlightPinBoxColor: lightblueColor,
                    hasTextBorderColor: kPrimaryColor,
                    // highlightPinBoxColor: Colors.orange,
                    maxLength:
                        UserModel().email == null || UserModel().email == ''
                            ? 6
                            : 4,
                    onDone: (text) {
                      verificaitonPin = text;
                    },
                    pinBoxWidth: 40,
                    pinBoxHeight: 40,
                    hasUnderline: false,
                    wrapAlignment: WrapAlignment.spaceAround,
                    pinBoxDecoration:
                        ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                    pinTextStyle: TextStyle(fontSize: 16.0),
                    pinBoxRadius: 8,
                    pinTextAnimatedSwitcherTransition:
                        ProvidedPinBoxTextAnimation.scalingTransition,
                    maskCharacter: '',
//                    pinBoxColor: Colors.green[100],
                    pinTextAnimatedSwitcherDuration:
                        Duration(milliseconds: 300),
//                    highlightAnimation: true,
                    highlightAnimationBeginColor: darkBlueColor,
                    highlightAnimationEndColor: darkBlueColor,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Provider.of<MainProvider>(context).isLoading
                      ? CupertinoActivityIndicator()
                      : CustomButton(
                          onPressed: () {
                            if (widget.isUpdate == true) {
                              if (UserModel().email != null ||
                                  UserModel().email != "") {
                                updateEmailVerifyOTp(context);
                              } else {
                                updatePhoneVerifyOTp(context);
                              }
                            } else {
                              if (UserModel().email != null ||
                                  UserModel().email == '') {
                                verifyOtp(context);
                              } else {
                                verifyOtpPhone(context);
                              }
                            }
                          },
                          btnHeight: 48,
                          btnRadius: 8,
                          title: "Verify",
                          fontWeight: FontWeight.w600,
                          btnColor: kPrimaryColor,
                          textColor: whiteColor,
                          fontSize: 18,
                        ),
                ),
                //Space
                SizedBox(
                  height: 20,
                ),
                //
                Container(
                  child: visibleButton == false
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 22),
                          alignment: Alignment.center,
                          child: Text(
                            "Resend code $_start" + "s",
                            style: TextStyle(
                                color: greyColor,
                                fontSize: 11,
                                fontFamily: 'medium'),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          alignment: Alignment.centerLeft,
                          child: Provider.of<MainProvider>(context).isLoading2
                              ? Center(child: CupertinoActivityIndicator())
                              : CustomInkWell(
                                  onTap: () {
                                    if (UserModel().email != null) {
                                      resendOtp(context);
                                      startTimer();
                                      setState(() {
                                        _start = 29;
                                        visibleButton = false;
                                      });
                                      print(UserModel().email);
                                    } else {
                                      resendOtpWithPhone(context);
                                      startTimer();
                                      setState(() {
                                        _start = 29;
                                        visibleButton = false;
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          title: "Didn’t get an OTP? ",
                                          fontSize: 13,
                                          color: darkBlueColor,
                                        ),
                                        CustomText(
                                          title: "Resend OTP",
                                          fontSize: 13,
                                          color: blueColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
