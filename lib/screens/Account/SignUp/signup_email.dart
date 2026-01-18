import 'package:VIN/Services/auth_services.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/screens/Account/otp_screen.dart';
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
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignUpEmail extends StatefulWidget {
  SignUpEmail({Key? key}) : super(key: key);

  @override
  State<SignUpEmail> createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  signUpWithEmail(BuildContext context,MainProvider mainProvider) async {
    if (formKey.currentState!.validate()) {
      mainProvider.changeIsLoading(true);
      var result = await AuthServices.signupWithEmail(
        name: nameController.text.toString(),
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );
      print(result);
      if (result == "Registration complete") {
        mainProvider
            .changeIsLoading(false);

        Helper.toRemoveUntiScreen(context, OTPScreen2());
      } else {
        mainProvider
            .changeIsLoading(false);
        Helper.showSnack(context, "This email is already registered");
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
    // MainProvider mainProvider =
    //     Provider.of<MainProvider>(context, listen: true);

    return StatefulWrapper(
        onInit: () {},
        child:Consumer<MainProvider>(
            builder: (context,mainProvider,child) {
            return Scaffold(
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
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (val) {},
                          validation: emailField,
                          hintText: "Email",
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
                                  signUpWithEmail(context,mainProvider);
                                  //  Helper.toScreen(context, OTPScreen2());
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
            );
          }
        ),
        dispose: () {});
  }
}
