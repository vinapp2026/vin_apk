import 'package:VIN/Services/auth_services.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/screens/Account/otp_screen2.dart';
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

class SignUpPhone extends StatefulWidget {
  SignUpPhone({Key? key}) : super(key: key);

  @override
  State<SignUpPhone> createState() => _SignUpPhoneState();
}

class _SignUpPhoneState extends State<SignUpPhone> {
  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  signUpWithPhone(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (phoneController.text.toString().startsWith("+")) {
        Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
        var result = await AuthServices.signupWithPhone(
          name: nameController.text.toString(),
          mobileNumber: phoneController.text.toString(),
          password: passwordController.text.toString(),
          context: context,
        );
        print(result);
        Provider.of<MainProvider>(context, listen: false).changeIsLoading(
            false);
        // Helper.showSnack(context, "Your profile has been created");
        // Helper.toRemoveUntiScreen(
        //     context,
        //     OTPScreen2(
        //       phoneNo: phoneController.text,
          //  ));
        if (result == "Registration complete") {
          Provider.of<MainProvider>(context, listen: false)
              .changeIsLoading(false);
          Helper.showSnack(context, "Your profile has been created");
          Helper.toScreen(context, OTPScreen2(phoneNo: phoneController.text));
        }
        else {
          Provider.of<MainProvider>(context, listen: false)
              .changeIsLoading(false);
          Helper.showSnack(context, "This number is already registered");
        }
      }else{
        Helper.showSnack(context, "Please write the phone number in correct format i.e +91-XXXXXXXXXX");
      }
    }
  }

  bool isObscure = true;

  toggle() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: true);

    return StatefulWrapper(
        onInit: () {},
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  //Space
                  const SizedBox(
                    height: 40,
                  ),
                  //Name
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: CustomTextField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      onChanged: (val) {},
                      validation: NameField,
                      hintText: "Name",
                      fieldborderRadius: 10,
                      isOutlineInputBorderColor: blueColor,
                      textFieldFillColor: lightblueColor,
                    ),
                  ),
                  //Space
                  const SizedBox(
                    height: 15,
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
                    height: 15,
                  ),
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
                        onTap: () {
                          toggle();
                        },
                        child: isObscure
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: const Icon(
                                  Icons.visibility_off,
                                  color: darkBlueColor,
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: const Icon(
                                  Icons.visibility_rounded,
                                  color: darkBlueColor,
                                ),
                              ),
                      ),
                    ),
                  ),
                  //Space
                  const SizedBox(
                    height: 30,
                  ),
                  //Sign up
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: mainProvider.isLoading
                        ? CupertinoActivityIndicator()
                        : CustomButton(
                            onPressed: () {
                              signUpWithPhone(context);
                              //   Helper.toScreen(context, VerifyYourselfScreen());
                            },
                            btnHeight: 48,
                            btnRadius: 8,
                            title: "Sign up",
                            fontWeight: FontWeight.w600,
                            btnColor: kPrimaryColor,
                            textColor: whiteColor,
                            fontSize: 18,
                          ),
                  ),
                  //Space
                  const SizedBox(
                    height: 50,
                  ),
                  //
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    alignment: Alignment.center,
                    child: CustomText(
                      title:
                          "By continuing you agree VIN’s Terms of\nServices & Privacy Policy",
                      fontSize: 13,
                      color: greyColor,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //Space
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomInkWell(
                        onTap: () {
                          if (mainProvider.isLoading != true) {
                            Navigator.pop(context);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CustomText(
                                title: "Already have an account?",
                                fontSize: 13,
                                color: greyColor,
                                textAlign: TextAlign.center,
                              ),
                              CustomText(
                                title: " Login",
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
        ),
        dispose: () {});
  }
}
