import 'package:VIN/Services/get_stadium_list_services.dart';
import 'package:VIN/models/custom_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../provider/location_provider.dart';
import '../homePage/home_page.dart';
import 'web_view_screen.dart';
class PickingScreen extends StatelessWidget {
   PickingScreen({Key? key}) : super(key: key);
   getStadiumList(BuildContext context)async{
     Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
     var result = await GetStadiumListServices.getStadiumList(
        latitude: UserModel().latitude,
        longitude: UserModel().longitude,
     );
     if (result == true){
         Helper.toScreen(context, HomePage());
         Provider.of<MainProvider>(context, listen: false).changeIsLoading(
             false);
         Helper.showSnack(context, "Successfully");
     }else {
       Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
       Helper.showSnack(context, "Failed");
     }
   }

  @override
  Widget build(BuildContext context) {
    // double lat = Provider.of<LocationProvider>(context,listen: false).currentPostion!.latitude;
    // double lng = Provider.of<LocationProvider>(context,listen: false).currentPostion!.longitude;
    // LatLng startLocation = LatLng(lat , lng) ;
    // print(startLocation.longitude);
    return CustomParentWidget(
      child: ModalProgressHUD(
        inAsyncCall: Provider.of<MainProvider>(context).isLoading,
        child: Scaffold(
          body: Column(
            children: [
              //Space
              SizedBox(height: 50,),
              //Pick One,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                alignment: Alignment.centerLeft,
                child: CustomText(
                  title: "Pick One,",
                  fontSize: 28,
                  color: darkBlueColor,
                ),
              ),
              //Space
              SizedBox(height: 6,),
              // What you are looking for!
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                alignment: Alignment.centerLeft,
                child: CustomText(
                  title: "What you are looking for!",
                  fontSize: 18,
                  color: darkBlueColor,
                ),
              ),
              //Space
              SizedBox(height: 50,),
              Container(
                height: 200,
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: CustomInkWell(
                  onTap: (){
                   // getStadiumList(context);
                    Helper.toScreen(context, HomePage());
                  },
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: lightblueColor,
                          border: Border.all(
                              width: 1,
                              color: blueColor
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/court_img.png",scale: 2,),
                          //Space
                          SizedBox(height: 15,),
                          CustomText(
                            title: "Court Booking",
                            fontSize: 16,
                            color: blueColor,
                          )
                        ],
                      )),
                ),
              ),
              //Space
              const SizedBox(height: 30,),
              Container(
                height: 200,
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: CustomInkWell(
                  onTap: (){
                    Helper.toScreen(context, WebViewScreen());
                  },
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: lightblueColor,
                          border: Border.all(
                              width: 1,
                              color: blueColor
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/VIN_img2.png",scale: 2,),
                          //Space
                          SizedBox(height: 15,),
                          CustomText(
                            title: "Tournament Booking",
                            fontSize: 16,
                            color: blueColor,
                          )
                        ],
                      )),
                ),
              ),
              //Space
              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
