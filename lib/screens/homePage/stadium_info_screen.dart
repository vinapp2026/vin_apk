import 'dart:convert';

import 'package:VIN/Api/api_url.dart';
import 'package:VIN/Services/general_services.dart';
import 'package:VIN/Services/get_stadium_info_services.dart';
import 'package:VIN/models/get_stadium_info_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:VIN/screens/courts_list_screen.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_cached_network_image.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: must_be_immutable
class StadiumInfoScreen extends StatefulWidget {
   int? stadiumId;
   StadiumInfoScreen({
     this.stadiumId,
     Key? key}) : super(key: key);

  @override
  State<StadiumInfoScreen> createState() => _StadiumInfoScreenState();
}

class _StadiumInfoScreenState extends State<StadiumInfoScreen> {
   favouriteAddRemove({
     String? isFav,
     int? favourite_id,
   }) async {
   //  String _result ="";
     Map data ={
       "stadiumID": widget.stadiumId,
       "is_favourite": isFav,
       "favourite_id":favourite_id
     };
     var response;
     response = await http.post(ApiUrl.addRemoveFavouriteEvent,
         headers: {
           "Content-Type": "application/json",
           "Accept": "application/json",
           'Authorization': 'Bearer ${UserModel().token}'
         },
         body: json.encode(data));
      print(response.body);
     final Map<String, dynamic> authResponseData = json.decode(response.body);
   //  bool success = authResponseData["success"];
    // success = authResponseData["success"];
     if (response.statusCode == 200) {
       if(authResponseData["data"]["is_favourite"]==0){
         print(authResponseData["data"]["is_favourite"]);
         isFavourite = 0;
       }else{
         isFavourite = 1;
         print(authResponseData["data"]["is_favourite"]);
       }
       setState(() {

       });
       GetStadiumInfoServices.getStadiumInfo(
         stadiumId: widget.stadiumId,
         latitude: UserModel().latitude,
         longitude: UserModel().longitude,
       );
     }
    // return getStadiumListModel;
   }

   int isFavourite =0;

  @override
  Widget build(BuildContext context) {
    return CustomParentWidget(
      child: Scaffold(
        body: FutureBuilder(
            future: GetStadiumInfoServices.getStadiumInfo(
              stadiumId: widget.stadiumId,
              latitude: UserModel().latitude,
              longitude: UserModel().longitude,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                GetStadiumInfoModel? getStadiumInfoModel = snapshot.data as GetStadiumInfoModel?;
                 isFavourite = getStadiumInfoModel!.data!.isFavourite!;
                 var lat =  getStadiumInfoModel.data!.latitude.toString();
                  var lng =   getStadiumInfoModel.data!.longitude.toString();
                return  Column(
                  children: [
                    //
                    Container(
                      width: double.infinity,
                      height: 300,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            width: double.infinity,
                              height: 300,
                              child: CustomCachedNetworkImage(url: getStadiumInfoModel.data!.stadiumAvatar.toString(),)
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 35),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomInkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: blackColor,
                                        shape: BoxShape.circle
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset("assets/icons/ic_back.png"),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      color: mediumBlueColor
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    title: "${getStadiumInfoModel.data!.distance} ${getStadiumInfoModel.data!.disMeasurement}",
                                    fontSize: 9,
                                    color: blueColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Transform.translate(
                      offset: Offset(0.0, -30),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )
                        ),
                        child: Column(
                          children: [
                            //Space
                            SizedBox(height: 30,),
                            //
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomText(
                                      title: getStadiumInfoModel.data!.name,
                                      fontSize: 18,
                                      maxLines: 2,
                                      color: blackColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  CustomInkWell(
                                    onTap: () {
                                      if(isFavourite==0){
                                        favouriteAddRemove(
                                            isFav: "1",
                                          );
                                      }else{
                                        favouriteAddRemove(
                                            isFav: "0",
                                            );
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: lightblueColor.withOpacity(0.7)
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child:isFavourite!=1? Image.asset(
                                        "assets/icons/ic_heart.png",
                                        color: blueColor,scale: 5,):
                                      Icon(Icons.favorite,color: blueColor.withOpacity(0.9),)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //Space
                            SizedBox(height: 20,),
                            //map
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4, right: 8),
                                    child: Image.asset(
                                        "assets/icons/ic_map_pin.png",scale: 6,),
                                  ),
                                  Expanded(
                                    child: CustomText(
                                      title: "${getStadiumInfoModel.data!.stadiumAddress}",
                                      fontSize: 13,
                                      maxLines: 2,
                                      color: darkBlueColor,
                                    ),
                                  ),
                                  //Space
                                  SizedBox(width: 15,),
                                  CustomInkWell(
                                    onTap: (){
                                      GeneralServices.launchMapsUrl(
                                        lat,
                                        lng
                                      );
                                    },
                                    child: CustomText(
                                      title: "Open in maps",
                                      fontSize: 13,
                                      color: blueColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //Space
                            SizedBox(height: 20,),
                            //
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                children: [
                                  Image.asset("assets/icons/ic_traced2.png",scale:9,color: darkBlueColor,),
                                  //Space
                                  SizedBox(width: 8,),
                                  Expanded(
                                    child: CustomText(
                                      title: "${getStadiumInfoModel.data!.role}",
                                      fontSize: 12,
                                      color: darkBlueColor,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //Space
                            SizedBox(height: 20,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: lightblueColor.withOpacity(0.7)
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset("assets/icons/ic_star.png",scale: 16,),
                                        //Space
                                        SizedBox(width: 4,),
                                        CustomText(
                                          title: "${getStadiumInfoModel.data!.rating} Reviews",
                                          fontSize: 13,
                                          color: kPrimaryColor,
                                        ),
                                        //Space
                                        SizedBox(width: 4,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ) ,
                            //Space
                            SizedBox(height: 20,),
                            //
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                children: [
                                  CustomInkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: lightblueColor.withOpacity(0.7)
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "assets/icons/ic_changing_room.png",scale: 5,
                                        color: blueColor,),
                                    ),
                                  ),
                                  //Space
                                  SizedBox(width: 8,),
                                  Expanded(
                                    child: CustomText(
                                      title: "${getStadiumInfoModel.data!.features![0].featureName}",
                                      fontSize: 13,
                                      color: darkBlueColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    //Space
                    Spacer(),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 18,vertical: 20),
                      child: CustomButton(
                        onPressed: () {
                          Helper.toScreen(context, CourtsListScreen(stadiumId: widget.stadiumId,));
                        },
                        btnHeight: 48,
                        btnRadius: 8,
                        title: "Select Court",
                        fontWeight: FontWeight.w600,
                        btnColor: kPrimaryColor,
                        textColor: whiteColor,
                        fontSize: 18,
                      ),
                    )
                  ],
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                  ),
                );
              }
            }
        ),
      )
    );
  }
}
