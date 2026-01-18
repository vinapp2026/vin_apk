import 'dart:io';
import 'package:VIN/Services/get_stadium_list_services.dart';
import 'package:VIN/SharedPreferences/shared_preferences.dart';
import 'package:VIN/provider/location_provider.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/screens/homePage/home_page.dart';
import 'package:VIN/screens/search_screen.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:VIN/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'picking_screen.dart';
import '../../widgets/custom_button.dart';
import 'search_location_screen.dart';
import 'package:google_maps_webservice/places.dart';

class CustomModelBottomSheet extends StatefulWidget {
  bool? isHomeScreen;
  CustomModelBottomSheet({this.isHomeScreen, Key? key}) : super(key: key);

  @override
  State<CustomModelBottomSheet> createState() => _CustomModelBottomSheetState();
}

class _CustomModelBottomSheetState extends State<CustomModelBottomSheet> {
  final locationController = TextEditingController();
  String googleApikey = "AIzaSyAsqnge5i30iNU_0MlfTY97H25gDi4PpMg";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng? startLocation;
  String location = "Search Location";

  searchFung() async {
    var place = await PlacesAutocomplete.show(
        context: context,
        apiKey: googleApikey,
        mode: Mode.fullscreen,
        backArrowIcon: Builder(builder: (BuildContext context) {
          return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: blackColor,
              ));
        }),
        // types: [],
        // strictbounds: false,
        logo: Container(),
        // components: [Component(Component.country, 'np')],
        //google_map_webservice package
        onError: (err) {
          print(err.status);
        });

    if (place != null) {
      setState(() {
        location = place.description.toString();
      });

      //form google_maps_webservice package
      final plist = GoogleMapsPlaces(
        apiKey: googleApikey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
        //from google_api_headers package
      );
      String placeid = place.placeId ?? "0";
      final detail = await plist.getDetailsByPlaceId(placeid);
      final geometry = detail.result.geometry!;
      final lat = geometry.location.lat;
      final lang = geometry.location.lng;
      var newlatlang = LatLng(lat, lang);
      startLocation = LatLng(lat, lang);
      await SharedPreferencesService.setLatLngSharedPreferences(
          location: location, latitude: lat, longitude: lang);
      await SharedPreferencesService.getLatLngSharedPreferences();
      //move map camera to selected place with animation
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: startLocation!, zoom: 17)));
      setState(() {
        Provider.of<LocationProvider>(context, listen: false)
            .getManuelLocation(location);
        locationController.text = location;
        print("${startLocation!.longitude}" +
            "AAAA" +
            "${startLocation!.latitude}");
      });
    }
  }

  String currentLocation = "";
  void initState() {
    // TODO: implement initState
    if (mounted)
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
    super.initState();
    locationController.text="";
  }

  getStadiumList(BuildContext context) async {
    if (locationController.text.isNotEmpty) {
      Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
      var result = await GetStadiumListServices.getStadiumList(
        latitude: startLocation!.latitude,
        longitude: startLocation!.longitude,
      );
      if (result!.success == true) {
        Provider.of<MainProvider>(context, listen: false)
            .changeIsLoading(false);
        if (widget.isHomeScreen == true) {
          locationController.clear();
          locationController.text="";
          Helper.toRemoveUntiScreen(context, HomePage());
        } else {
          Helper.toScreen(context, PickingScreen());
          Provider.of<MainProvider>(context, listen: false)
              .changeIsLoading(false);
          Helper.showSnack(context, "Successfully");
          locationController.clear();
        }
      } else {
        Provider.of<MainProvider>(context, listen: false)
            .changeIsLoading(false);
        locationController.clear();
        locationController.text="";
        Helper.showSnack(context, "Failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // locationController.text =
    //     Provider.of<LocationProvider>(context).currentLocation ?? "";
    // print("${startLocation!.longitude}" +"AAAA"+"${startLocation!.latitude}");
    return ModalProgressHUD(
      inAsyncCall: Provider.of<MainProvider>(context).isLoading,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            //Space
            SizedBox(
              height: 30,
            ),
            //Location
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: GestureDetector(
                onTap: () {
                  //  Helper.toScreen(context, SearchLocationScreen());
                  searchFung();
                },
                child: CustomTextField(
                  enabled: false,
                  controller: locationController,
                  keyboardType: TextInputType.text,
                  textFieldFillColor: lightblueColor,
                  onChanged: (val) {},
                  hintText: "Location",
                  fieldborderRadius: 10,
                  fieldborderColor: blueColor,
                ),
              ),
            ),
            //Space
            SizedBox(
              height: 20,
            ),
            //
            CustomInkWell(
              onTap: () async {
                locationController.text =
                    await Provider.of<LocationProvider>(context, listen: false)
                        .getCurrentLocation();
                print(locationController.text);
                double lat =
                    Provider.of<LocationProvider>(context, listen: false)
                        .currentPostion!
                        .latitude;
                double lng =
                    Provider.of<LocationProvider>(context, listen: false)
                        .currentPostion!
                        .longitude;
                startLocation = LatLng(lat, lng);
                // print("${startLocation!.longitude}" +"AAAA"+"${startLocation!.latitude}");
                SharedPreferencesService.setLatLngSharedPreferences(
                    location: locationController.text,
                    latitude: lat,
                    longitude: lng);
                SharedPreferencesService.getLatLngSharedPreferences();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/ic_crosshair.png",
                      scale: 2,
                    ),
                    //Space
                    SizedBox(
                      width: 12,
                    ),
                    //
                    CustomText(
                      title: "Use current location",
                      fontSize: 14,
                      color: blueColor,
                    )
                  ],
                ),
              ),
            ),
            //
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: CustomButton(
                onPressed: () {
                  getStadiumList(context);
                },
                btnHeight: 48,
                btnRadius: 8,
                title: "Done",
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
