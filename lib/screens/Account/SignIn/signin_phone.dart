import 'package:VIN/Services/auth_services.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/screens/Account/ForgetPassword/forget_password_main_screen.dart';
import 'package:VIN/screens/Account/SignUp/signup_main_screen.dart';
import 'package:VIN/screens/PickLocation/pick_location_screen.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/utilites/validator.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:VIN/widgets/custom_textfield.dart';
import 'package:VIN/widgets/satatefull_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SigInPhone extends StatefulWidget {
   SigInPhone({Key? key}) : super(key: key);

  @override
  State<SigInPhone> createState() => _SigInPhoneState();
}

class _SigInPhoneState extends State<SigInPhone> {
   final phoneController = TextEditingController();

   final passwordController = TextEditingController();

   final formKey = GlobalKey<FormState>();

   SignInWithEmail(BuildContext context,MainProvider mainProvider)async{
     if (formKey.currentState!.validate()) {
       mainProvider.changeIsLoading(true);
       var result = await AuthServices.loginWithPhone(
         mobile: phoneController.text.toString(),
         password: passwordController.text.toString(),
       );
       if (result == "User logged in successfully!"){
         Helper.toScreen(context, PickLocationScreen());
         mainProvider.changeIsLoading(false);
         Helper.showSnack(context, "Login Successfully");

       }else {
         mainProvider.changeIsLoading(false);
         Helper.showSnack(context, "Invalid User");
       }
     }
   }

   bool isObscure = true;

   toggle(){
     setState(() {
       isObscure =! isObscure;
     });
   }

   @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (context,mainProvider,child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  //Space
                  const SizedBox(height: 40,),
                  //Phone
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
                  const SizedBox(height: 15,),
                  //Password
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: CustomTextField(
                      obscureText: isObscure,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (val) {},
                      validation: validateCurrentPassword,
                      hintText: "Password",
                      fieldborderRadius: 10,
                      isOutlineInputBorderColor: blueColor,
                      textFieldFillColor: lightblueColor,
                      suffixIcon: CustomInkWell(
                        onTap: (){
                        toggle();
                        },
                        child:isObscure?
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child:  Icon(Icons.visibility_off,color: darkBlueColor,),
                        ):
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child:  Icon(Icons.visibility_rounded,color: darkBlueColor,),
                        ),
                      ),
                    ),
                  ),
                  //Space
                  const SizedBox(height: 7,),
                  //Show
                  Container(
                    padding: const EdgeInsets.only(left: 18,right: 10),
                    alignment: Alignment.centerRight,
                    child: CustomInkWell(
                      onTap: (){
                        if(Provider.of<MainProvider>(context, listen: false).isLoading!=true){
                          Helper.toScreen(context, ForgetPasswordMainScreen());
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          title: "Forgot Password?",
                          fontSize: 14,
                          color: blueColor,
                        ),
                      ),
                    ),
                  ),
                  //Space
                  const SizedBox(height: 30,),
                  //Sign in
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Provider.of<MainProvider>(context, listen: false).isLoading?
                    CupertinoActivityIndicator():CustomButton(
                      onPressed: () {
                        SignInWithEmail(context,mainProvider);
                      },
                      btnHeight: 48,
                      btnRadius: 8,
                      title: "Sign in",
                      fontWeight: FontWeight.w600,
                      btnColor: kPrimaryColor,
                      textColor: whiteColor,
                      fontSize: 18,
                    ),
                  ),
                  //Space
                  const SizedBox(height: 50,),
                  //
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    alignment: Alignment.center,
                    child: CustomText(
                      title: "By continuing you agree VIN’s Terms of\nServices & Privacy Policy",
                      fontSize: 13,
                      color: greyColor,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //Space
                  const SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomInkWell(
                        onTap: (){
                          Helper.toScreen(context, SignUpMainScreem());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CustomText(
                                title: "Don’t have an account?",
                                fontSize: 13,
                                color: greyColor,
                                textAlign: TextAlign.center,
                              ),
                              CustomText(
                                title: " Create one",
                                fontSize: 13,
                                color: blueColor,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
