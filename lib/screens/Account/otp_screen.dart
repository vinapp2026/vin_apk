import 'dart:ui';

import 'package:VIN/Services/auth_services.dart';
import 'package:VIN/models/user_model.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:VIN/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

import 'reset_password_screen.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key}) : super(key: key);
  var text1Controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var verificaitonPin = "";
  verifyOtp(BuildContext context) async {
    Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
    var result = await AuthServices.verifyOtp(
      email: UserModel().email.toString(),
      otp: verificaitonPin,
    );
    print(result);
    if (result == "Verification successfully") {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
      Helper.showSnack(context, "$result");
      Helper.toScreen(context, ResetPasswordScreen());
    } else {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
      Helper.showSnack(context, "$result");
    }
  }

  verifyOtpWithPhone(
    BuildContext context,
  ) async {
    Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
    var result = await AuthServices.verifyOtpWithPhone(
        mobileNumber: UserModel().phoneNo.toString(),
        otp: verificaitonPin,
        context: context);
    print(result);
    if (result == "Verification successfully") {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
      Helper.showSnack(context, "Valid OTP");
      Helper.toScreen(context, ResetPasswordScreen());
    } else {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
      Helper.showSnack(context, "Invalid OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: true);
    return CustomParentWidget(
      child: ModalProgressHUD(
        inAsyncCall: mainProvider.isLoading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: whiteColor,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: blackColor,
                )),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                //Space
                const SizedBox(
                  height: 50,
                ),
                //ic_mail
                Container(
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: mediumBlueColor2),
                  child: Center(
                    child: Image.asset(
                      "assets/icons/ic_email.png",
                      scale: 1.5,
                    ),
                  ),
                ),
                //Space
                const SizedBox(
                  height: 20,
                ),
                //Verify OTP
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  alignment: Alignment.center,
                  child: CustomText(
                    title: "Verify OTP",
                    fontSize: 18,
                    color: blackColor,
                  ),
                ),
                //Space
                const SizedBox(
                  height: 6,
                ),
                //
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  alignment: Alignment.center,
                  child: CustomText(
                    title:
                        "Reset your password using the OTP that will be sent to your"
                        "${UserModel().email ?? UserModel().phoneNo}",
                    fontSize: 14,
                    color: greyColor,
                    textAlign: TextAlign.center,
                  ),
                ),
                //Space
                const SizedBox(
                  height: 40,
                ),
                //otp fields
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
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: CustomButton(
                onPressed: () {
                  if (UserModel().email != null || UserModel().email == '') {
                    verifyOtp(context);
                  } else {
                    verifyOtpWithPhone(context);
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
          ),
        ),
      ),
    );
  }
}
