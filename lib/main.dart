import 'package:VIN/provider/booking_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'provider/home_page_provider.dart';
import 'provider/location_provider.dart';
import 'provider/main_provider.dart';
import 'provider/my_calender_provider.dart';
import 'provider/tabs_provider.dart';
import 'screens/splash/splash.dart';
import 'utilites/constants.dart';

void getAppPermissions() async {
  await Permission.location.request();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getAppPermissions();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: kPrimaryColor, // Color for Android
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness:
            Brightness.dark, // Dark == white status bar -- for IOS.
        systemNavigationBarColor: whiteColor,
        systemNavigationBarIconBrightness: Brightness.dark));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider()),
        ChangeNotifierProvider(create: (context) => TabsProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => HomePageProvider()),
        ChangeNotifierProvider(create: (context) => BookingProvider()),
        ChangeNotifierProvider(create: (context) => MyCalenderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "VIN",
        home: const Splash(),
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: whiteColor,
                iconTheme: const IconThemeData(color: blackColor)),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: scaffoldBackgroundColor,
            canvasColor: scaffoldBackgroundColor,
            primaryColor: kPrimaryColor,
            primarySwatch: primarySwatch,
            fontFamily: 'medium',
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashFactory: InkRipple.splashFactory,
            focusColor: Colors.transparent,
            dividerColor: Colors.transparent,
            // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: kPrimaryColor)),
      ),
    );
  }
}
