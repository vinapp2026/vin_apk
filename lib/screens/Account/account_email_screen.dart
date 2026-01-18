import 'package:VIN/Services/auth_services.dart';
import 'package:VIN/models/user_model.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/screens/Account/otp_screen2.dart';
import 'package:VIN/screens/Account/phone_numb_screen.dart';
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
class AccountEmailScreen extends StatelessWidget {
   AccountEmailScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
   updateEmail(BuildContext context)async{
     if (formKey.currentState!.validate()) {
       UserModel().email = emailController.text;
       Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
       var result = await AuthServices.updateEmail(
         email: UserModel().email,
       );
       if (result == true) {
         UserModel().phoneNo = "";
         Helper.toScreen(context, OTPScreen2(isUpdate: true,));
         Provider.of<MainProvider>(context, listen: false).changeIsLoading(
             false);
         Helper.showSnack(context, "Successfully");
       } else {
         Provider.of<MainProvider>(context, listen: false).changeIsLoading(
             false);
         Helper.showSnack(context, "This email is already registered");
       }
     }
   }

   @override
  Widget build(BuildContext context) {
     MainProvider mainProvider =
     Provider.of<MainProvider>(context, listen: true);

     return CustomParentWidget(
      child: Scaffold(
        body:  SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                //Appbar
                Container(
                  height: 80,
                  padding: const EdgeInsets.only(left: 10,top: 20),
                  child: Row(
                    children: [
                      CustomInkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/icons/ic_back.png",color: darkBlueColor,),
                        ),
                      ),
                      //Space
                      SizedBox(width: 12,),
                      //
                      Expanded(
                        child: CustomText(
                          title: "Account Email",
                          fontSize: 18,
                          color: darkBlueColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),  //
                //Space
                SizedBox(height: 60,),
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
                    textFieldFillColor: lightblueColor,
                    isOutlineInputBorderColor: blueColor,
                  ),
                ),
                //Space
                SizedBox(height: 6,),
                //
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    title: "A verification email will be sent to the above email",
                    fontSize: 11,
                    color: greyColor,
                  ),
                ),
                //Space
                SizedBox(height: 40,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child:mainProvider.isLoading?Center(child: CupertinoActivityIndicator()):  CustomButton(
                    onPressed: () {
                      updateEmail(context);
                    //  Helper.toScreen(context, PhoneNumbScreen());
                    },
                    btnHeight: 48,
                    btnRadius: 8,
                    title: "Send Code",
                    fontWeight: FontWeight.w600,
                    btnColor: kPrimaryColor,
                    textColor: whiteColor,
                    fontSize: 18,
                  ),
                ),
                //Space
                SizedBox(height: 20,),
                //
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 18),
                //   alignment: Alignment.centerLeft,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       CustomText(
                //         title: "Didn’t get an email? ",
                //         fontSize: 13,
                //         color: darkBlueColor,
                //       ),
                //       CustomText(
                //         title: "Resend Email",
                //         fontSize: 13,
                //         color: blueColor,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
