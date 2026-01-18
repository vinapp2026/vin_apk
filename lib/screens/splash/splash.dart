
import 'package:VIN/SharedPreferences/auth_shared_preferences.dart';
import 'package:VIN/SharedPreferences/shared_preferences.dart';
import 'package:VIN/screens/Account/SignIn/signin_main_screen.dart';
import 'package:VIN/screens/homePage/home_page.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void init() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Future.delayed(Duration(seconds: 3),()async{
       await  AuthSharedPreferences.getAuthSharedPreferences();
        if (prefs.getString("token")==null||prefs.getString("token")=="") {
          Helper.toRemoveUntiScreen(context, SignInMainScreen());
        } else {
        await  SharedPreferencesService.getLatLngSharedPreferences();
            Helper.toRemoveUntiScreen(context, HomePage());
        }
      });
    } catch (e) {
      SharedPreferences.setMockInitialValues({});
    }
  }
  @override
  void initState() {
    super.initState();
    init();
  }
  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Color for Android
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ),
      sized: false,
      child: Scaffold(
      //  backgroundColor: kPrimaryColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
                image: AssetImage("assets/images/splash.jpeg"))
          ),
        ),
      ),
    );
  }
}
