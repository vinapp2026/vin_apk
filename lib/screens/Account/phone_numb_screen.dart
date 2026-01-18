import 'package:VIN/Services/auth_services.dart';
import 'package:VIN/models/user_model.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/utilites/validator.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:VIN/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'otp_screen2.dart';

class PhoneNumbScreen extends StatefulWidget {
  PhoneNumbScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumbScreen> createState() => _PhoneNumbScreenState();
}

class _PhoneNumbScreenState extends State<PhoneNumbScreen> {
  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? countryCode;
  String? countryName;
  updatePhone(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      UserModel().phoneNo = phoneController.text;
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
      var result = await AuthServices.updatePhone(
        mobileNumber: UserModel().phoneNo.toString(),
      );
      if (result == true) {
        UserModel().email = "";
        Helper.toScreen(
            context,
            OTPScreen2(
              isUpdate: true,
            ));
        Provider.of<MainProvider>(context, listen: false)
            .changeIsLoading(false);
        Helper.showSnack(context, "Successfully");
      } else {
        Provider.of<MainProvider>(context, listen: false)
            .changeIsLoading(false);
        Helper.showSnack(context, "This number is already registered");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: true);

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
                      CustomInkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/icons/ic_back.png",
                            color: darkBlueColor,
                          ),
                        ),
                      ),
                      //Space
                      SizedBox(
                        width: 12,
                      ),
                      //
                      Expanded(
                        child: CustomText(
                          title: "Phone Number",
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
                  height: 60,
                ),
                //Phone
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          onChanged: (val) {},
                          validation: phoneField,
                          hintText: "Phone Number",
                          fieldborderRadius: 10,
                          textFieldFillColor: lightblueColor,
                          isOutlineInputBorderColor: blueColor,
                        ),
                      ),
                    ],
                  ),
                ),
                //Space
                SizedBox(
                  height: 6,
                ),
                //
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    title:
                        "A verification email will be sent to the above email",
                    fontSize: 11,
                    color: greyColor,
                  ),
                ),
                //Space
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: mainProvider.isLoading
                      ? Center(child: CupertinoActivityIndicator())
                      : CustomButton(
                          onPressed: () {
                            updatePhone(context);
                          },
                          btnHeight: 48,
                          btnRadius: 8,
                          title: "Send OTP",
                          fontWeight: FontWeight.w600,
                          btnColor: kPrimaryColor,
                          textColor: whiteColor,
                          fontSize: 18,
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
