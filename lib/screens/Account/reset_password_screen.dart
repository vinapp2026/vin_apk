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

import 'SignIn/signin_main_screen.dart';
class ResetPasswordScreen extends StatelessWidget {
   ResetPasswordScreen({Key? key}) : super(key: key);
   final passwordController = TextEditingController();
   final confPasswordController = TextEditingController();
   final formKey = GlobalKey<FormState>();
   resetPassword(BuildContext context)async{
     if (formKey.currentState!.validate()) {
       Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
       var result = await AuthServices.resetPassword(
         email: UserModel().email.toString(),
         password: confPasswordController.text.toString(),
       );
       if (result == "Your account password has been updated"){
         Helper.toRemoveUntiScreen(context, SignInMainScreen());
         Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
         Helper.showSnack(context, "Your account password has been updated");

       }else {
         Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
         Helper.showSnack(context, "$result");
       }
     }
   }

   resetPasswordWithPhone(BuildContext context)async{
     if (formKey.currentState!.validate()) {
       Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
       var result = await AuthServices.resetPasswordWithPhone(
         mobileNumber: UserModel().phoneNo.toString(),
         password: confPasswordController.text.toString(),
       );
       if (result == "Your account password has been updated"){
         Helper.toRemoveUntiScreen(context, SignInMainScreen());
         Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
         Helper.showSnack(context, "Your account password has been updated");

       }else {
         Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
         Helper.showSnack(context, "$result");
       }
     }
   }
   @override
  Widget build(BuildContext context) {
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: true);
    return CustomParentWidget(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back,color: blackColor,)
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                //Space
                const SizedBox(height: 50,),
                //ic_key
                Container(
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: mediumBlueColor2
                  ),
                  child: Center(
                    child: Image.asset("assets/icons/ic_key.png",scale: 1.5,),
                  ),
                ),
                //Space
                const SizedBox(height: 20,),
                //Reset Your Password
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  alignment: Alignment.center,
                  child: CustomText(
                    title: "Reset Your Password",
                    fontSize: 18,
                    color: blackColor,
                  ),
                ),
                //Space
                const SizedBox(height: 6,),
                //
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  alignment: Alignment.center,
                  child: CustomText(
                    title: "Reset your password using the link that"
                        "will be sent to your email account",
                    fontSize: 14,
                    color: greyColor,
                    textAlign: TextAlign.center,
                  ),
                ),
                //Space
                const SizedBox(height: 40,),
                //New Password
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: CustomTextField(
                    obscureText: mainProvider.isToggle,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (val) {},
                    validation: validatePassword,
                    hintText: "New Password",
                    fieldborderRadius: 10,
                    textFieldFillColor: lightblueColor,
                    isOutlineInputBorderColor: blueColor,
                    suffixIcon: CustomInkWell(
                      onTap: (){
                        mainProvider.toggleDone(index: 0);
                      },
                      child:mainProvider.isToggle?
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: const Icon(Icons.visibility_off,color: darkBlueColor,),
                      ):
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: const Icon(Icons.visibility_rounded,color: darkBlueColor,),
                      ),
                    ),
                  ),
                ),
                //Space
                const SizedBox(height: 20,),
                //Confirm Password
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: CustomTextField(
                    obscureText: mainProvider.isToggle1,
                    controller: confPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (val) {},
                    validation: validateRepeatPassword,
                    hintText: "Confirm Password",
                    fieldborderRadius: 10,
                    textFieldFillColor: lightblueColor,
                    isOutlineInputBorderColor: blueColor,
                    suffixIcon: CustomInkWell(
                      onTap: (){
                        mainProvider.toggleDone(index: 1);
                      },
                      child:mainProvider.isToggle1?
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: const Icon(Icons.visibility_off,color: darkBlueColor,),
                      ):
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: const Icon(Icons.visibility_rounded,color: darkBlueColor,),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child:  Container(
            padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 20),
            child:mainProvider.isLoading?CupertinoActivityIndicator():  CustomButton(
              onPressed: () {
                if(UserModel().email!=null) {
                  resetPassword(context);
                }else{
                  resetPasswordWithPhone(context);
                }
              },
              btnHeight: 48,
              btnRadius: 8,
              title: "Confirm",
              fontWeight: FontWeight.w600,
              btnColor: kPrimaryColor,
              textColor: whiteColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
