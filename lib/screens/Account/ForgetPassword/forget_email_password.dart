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
class ForgetEmailPassword extends StatelessWidget {
   ForgetEmailPassword({Key? key}) : super(key: key);
   final emailController = TextEditingController();
   final formKey = GlobalKey<FormState>();
   forgetPasswordWithEmail(BuildContext context)async{
     if (formKey.currentState!.validate()) {
       Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
       var result = await AuthServices.forgetPassword(
         email: emailController.text.toString(),
       );
       if (result == "Verification code sent successfully"){
         Helper.toScreen(context, OTPScreen());
         Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
         Helper.showSnack(context, "$result");

       }else {
         Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
         Helper.showSnack(context, "$result");
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
            const SizedBox(height: 20,),
            //
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              child: CustomText(
                title: "Reset your password using the link that will be sent to your email account",
                fontSize: 14,
                color: greyColor,
                textAlign: TextAlign.center,
              ),
            ),
            //Space
            const SizedBox(height: 40,),
            //Email
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: CustomTextField(
                controller: emailController,
                keyboardType: TextInputType.text,
                onChanged: (val) {},
                validation: emailField,
                hintText: "Email",
                fieldborderRadius: 10,
                isOutlineInputBorderColor: blueColor,
                textFieldFillColor: lightblueColor,
              ),
            ),
            //Space
            const SizedBox(height: 90,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child:Provider.of<MainProvider>(context).isLoading?CupertinoActivityIndicator(): CustomButton(
                onPressed: () {
                 forgetPasswordWithEmail(context);
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
