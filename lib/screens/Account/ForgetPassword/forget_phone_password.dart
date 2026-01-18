import 'package:VIN/Services/auth_services.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/screens/Account/otp_screen.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/utilites/validator.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:VIN/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPhonePassword extends StatelessWidget {
  ForgetPhonePassword({Key? key}) : super(key: key);
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  forgetPasswordWithPhone(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (phoneController.text.toString().startsWith("+")) {
        Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
        var result = await AuthServices.forgetPasswordWithPhone(
            mobileNumber: phoneController.text.toString().trim(),
            context: context);
        if (result == "Verification code sent successfully") {
          Helper.toScreen(context, OTPScreen());
          Provider.of<MainProvider>(context, listen: false)
              .changeIsLoading(false);
          Helper.showSnack(context, "$result");
        } else {
          Provider.of<MainProvider>(context, listen: false)
              .changeIsLoading(false);
          Helper.showSnack(context, "$result");
        }
      }else{
        Helper.showSnack(context, "Please write the phone number in correct format i.e +91-XXXXXXXXXX");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            //Space
            const SizedBox(
              height: 20,
            ),
            //
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              child: CustomText(
                title:
                    "Reset your password using the link that will be sent to your number account",
                fontSize: 14,
                color: greyColor,
                textAlign: TextAlign.center,
              ),
            ),
            //Space
            const SizedBox(
              height: 40,
            ),
            //Email
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: CustomTextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                onChanged: (val) {},
                validation: phoneField,
                hintText: "Phone",
                fieldborderRadius: 10,
                isOutlineInputBorderColor: blueColor,
                textFieldFillColor: lightblueColor,
              ),
            ),
            //Space
            const SizedBox(
              height: 90,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Provider.of<MainProvider>(context).isLoading
                  ? CupertinoActivityIndicator()
                  : CustomButton(
                      onPressed: () {
                        forgetPasswordWithPhone(context);
                      },
                      btnHeight: 48,
                      btnRadius: 8,
                      title: "Send Otp",
                      fontWeight: FontWeight.w600,
                      btnColor: kPrimaryColor,
                      textColor: whiteColor,
                      fontSize: 18,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
