import 'package:VIN/Services/auth_services.dart';
import 'package:VIN/SharedPreferences/shared_preferences.dart';
import 'package:VIN/models/user_model.dart';
import 'package:VIN/provider/booking_provider.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/screens/Account/SignIn/signin_main_screen.dart';
import 'package:VIN/screens/homePage/CustomDrawer/webview_screens.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  deleteAccount(BuildContext context) async {
    EasyLoading.show();
    // Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
    var result = await AuthServices.deleteAccount();
    if (result == "Successfully Deleted!.") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getInt("id") != null || prefs.getString("token") != null) {
        prefs.clear();
        UserModel().location = "";
        UserModel().latitude = null;
        UserModel().longitude = null;
        if (prefs.getString("token") == null ||
            prefs.getString("token") == "") {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Helper.toRemoveUntiScreen(context, SignInMainScreen());
            Helper.showSnack(context, "Account Deleted Successfully");
          });
        }
      }
      EasyLoading.dismiss();
      //Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
    } else {
      EasyLoading.dismiss();
      // Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
      Helper.showSnack(context, "Failed ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Scaffold(
        key: _scaffoldKey,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<MainProvider>(context).isLoading,
          child: Column(
            children: [
              //Space
              SizedBox(
                height: 80,
              ),
              CustomInkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          title: "About Us",
                          fontSize: 16,
                          color: blackColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              CustomInkWell(
                onTap: () {
                  Navigator.pop(context);
                  Helper.toScreen(
                      context,
                      WebViewScreens(
                        screenName: "Terms & Conditions",
                        url: "http://vinsports.in/terms.html",
                      ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          title: "Terms & Conditions",
                          fontSize: 16,
                          color: blackColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              CustomInkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          title: "Refund Policy",
                          fontSize: 16,
                          color: blackColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              CustomInkWell(
                onTap: () {
                  Navigator.pop(context);
                  Helper.toScreen(
                      context,
                      WebViewScreens(
                        screenName: "Privacy Policy",
                        url: "http://vinsports.in/pp.html",
                      ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          title: "Privacy Policy",
                          fontSize: 16,
                          color: blackColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              CustomInkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          title: "Contact Us",
                          fontSize: 16,
                          color: blackColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              CustomInkWell(
                onTap: () {
                  // Navigator.pop(context);
                  showDialog(
                    context: _scaffoldKey.currentContext!,
                    builder: (ctx) => AlertDialog(
                      // key: _scaffoldKey,
                      title: CustomText(
                        title: "Are you sure want delete account",
                        fontSize: 15,
                        color: blackColor,
                      ),
                      //  content: const Text("You have raised a Alert Dialog Box"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            //  SchedulerBinding.instance.addPostFrameCallback((_) {
                            //     Navigator.pop(context);
                            // });
                            //  EasyLoading.show();
                            // Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
                            var result = await AuthServices.deleteAccount();
                            setState((){});
                            Provider.of<BookingProvider>(context, listen: false)
                                .deleteUserFromFirebase();
                            if (result == "Successfully Deleted!.") {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              if (prefs.getInt("id") != null ||
                                  prefs.getString("token") != null) {
                                prefs.clear();
                                UserModel().location = "";
                                UserModel().latitude = null;
                                UserModel().longitude = null;
                                // if(prefs.getString("token")==null||prefs.getString("token")=="") {

                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.pop(context);
                                  Helper.toRemoveUntiScreen(
                                      context, SignInMainScreen());
                                  Helper.showSnack(
                                      context, "Account Deleted Successfully");
                                });
                              }
                            }
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            child: CustomText(
                                title: "Delete",
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            child: CustomText(
                              title: "No",
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          title: "Delete Account",
                          fontSize: 16,
                          color: blackColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
