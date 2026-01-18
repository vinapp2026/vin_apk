import 'dart:ui';

import 'package:VIN/Services/get_stadium_list_services.dart';
import 'package:VIN/models/get_stadium_list_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:VIN/provider/home_page_provider.dart';
import 'package:VIN/provider/location_provider.dart';
import 'package:VIN/screens/PickLocation/pick_location_screen.dart';
import 'package:VIN/screens/booking/booking_detail_screen.dart';
import 'package:VIN/screens/court_profile_screen.dart';
import 'package:VIN/screens/court_profile_screen2.dart';
import 'package:VIN/screens/courts_list_screen.dart';
import 'package:VIN/screens/nearby_stadium_screen.dart';
import 'package:VIN/screens/payment/payment_success_screen.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_cached_network_image.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_shimmer.dart';
import 'package:VIN/widgets/custom_slider.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../notification_screen.dart';
import '../search_screen.dart';
import 'stadium_info_screen.dart';
class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   DateTime currentDate = DateTime.now();

   var dateVal;

   var now = DateTime.now();

    openDatePicker(BuildContext context) async {
     final DateTime? picked = await showDatePicker(
       context: context,
       initialDate: currentDate,
       firstDate: currentDate,
       lastDate: DateTime(2101),
     );
     if (picked != null && picked != currentDate) {
       setState(() {
         dateVal = DateFormat('dd MMM yyyy').format(picked);
         print(dateVal);
       });
     }
   }
var stdId;
  @override
  Widget build(BuildContext context) {
    var oldData = DateFormat('dd MMM yyyy').format(now);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: CustomInkWell(
                onTap: (){
                  Helper.toScreen(context, PickLocationScreen(isHomeScreen: true,));
                },
                child: Row(
                  children: [
                    //
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/icons/ic_navigation.png",scale: 5.5,),
                    ),
                    //
                    Expanded(
                      child: CustomText(
                        title: UserModel().location,
                        fontSize: 12,
                        color: whiteColor,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Space
            SizedBox(width: 5,),
            CustomInkWell(
              onTap: (){
                Helper.toScreen(context, SearchScreen());
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: lightblueColor.withOpacity(0.4)
                ),
                child: Image.asset("assets/icons/ic_search.png",scale: 15,),
              ),
            ),
            //Space
            const SizedBox(width: 10,),
            CustomInkWell(
              onTap: (){
                Helper.toScreen(context, NotificationScreen());
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: lightblueColor.withOpacity(0.4)
                ),
                child: Image.asset("assets/icons/ic_bell.png",scale: 5.5,),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-82,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 380,
                      decoration: const BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          )
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Column(
                            children: [
                              //Space
                              const SizedBox(height: 20,),
                              //
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 18),
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  title: "Hey User Let’s\nselect a venue to play",
                                  fontSize: 18,
                                  color: whiteColor,
                                ),
                              ),
                              //Space
                              const SizedBox(height: 20,),
                              //
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      title: "Special Promo",
                                      fontSize: 14,
                                      color: whiteColor,
                                    ),
                                    CustomText(
                                      title: "See all promo",
                                      fontSize: 14,
                                      color: whiteColor,
                                    ),
                                  ],
                                ),
                              ),
                              //Space
                              const SizedBox(height: 15,),
                              //Slider
                              Container(
                                // padding: const EdgeInsets.symmetric(horizontal: 18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: CustomSlider(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //card
                    Transform.translate(
                      offset: Offset(0.0,-100),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          children: [
                            Card(
                              elevation: 4,
                              shape:  RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Container(
                                height: 210,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    //1st
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //1st
                                          Expanded(
                                            child: CustomInkWell(
                                              onTap: (){
                                                openDatePicker(context);
                                              },
                                              child: Container(
                                                //color: redColor,
                                                padding: const EdgeInsets.symmetric(vertical: 15,),
                                                child: Row(
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Stack(
                                                      clipBehavior: Clip.none,
                                                      children: [
                                                        Image.asset("assets/icons/ic_calendar2.png",scale: 4,),
                                                      ],
                                                    ),
                                                    //Space
                                                    const SizedBox(width: 12,),
                                                    //
                                                    Expanded(
                                                      child: CustomText(
                                                        title: dateVal??oldData,
                                                        fontSize: 13,
                                                        color: darkBlueColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //2nd
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,),
                                      child: Container(
                                        height: 45,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1, color: blueColor),
                                            borderRadius: BorderRadius.circular(9)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Stack(
                                                children: [
                                                  CustomButton(
                                                    onPressed: () {
                                                    },
                                                    btnHeight: 48,
                                                    btnRadius: 8,
                                                    title: "General",
                                                    fontWeight: FontWeight.w600,
                                                    btnColor: kPrimaryColor,
                                                    textColor: whiteColor,
                                                    fontSize: 13,
                                                  ),
                                                  Positioned.directional(
                                                      textDirection: Directionality.of(context),
                                                      start: 5,
                                                      top: 0,
                                                      bottom: 0,
                                                      child: Image.asset("assets/icons/ic_traced.png",scale: 10,))
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Stack(
                                                children: [
                                                  CustomButton(
                                                    onPressed: () {
                                                    },
                                                    btnHeight: 48,
                                                    btnRadius: 8,
                                                    title: "Technical",
                                                    fontWeight: FontWeight.w600,
                                                    btnColor: whiteColor,
                                                    textColor: kPrimaryColor,
                                                    fontSize: 13,
                                                  ),
                                                  Positioned.directional(
                                                      textDirection: Directionality.of(context),
                                                      start: -5,
                                                      top: 0,
                                                      bottom: 0,
                                                      child: Image.asset("assets/icons/ic_traced2.png",scale: 9,))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    //Space
                                    const SizedBox(height: 15,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            child: const DottedLine(
                                              direction: Axis.horizontal,
                                              lineLength: double.infinity,
                                              lineThickness: 1.0,
                                              dashLength: 5.0,
                                              dashColor: blueColor,
                                              dashRadius: 0.0,
                                              dashGapLength: 5.0,
                                              dashGapColor: Colors.transparent,
                                              dashGapRadius: 0.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Space
                                    const SizedBox(height: 15,),
                                    //3rd
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: CustomButton(
                                              onPressed: () {
                                                Helper.toScreen(context, NearbyStadiumScreen());
                                              },
                                              btnHeight: 44,
                                              btnRadius: 8,
                                              title: "Bulk Booking",
                                              fontWeight: FontWeight.w600,
                                              btnColor: whiteColor,
                                              btnBorderColor: kPrimaryColor,
                                              textColor: kPrimaryColor,
                                              fontSize: 13,
                                            ),
                                          ),
                                          //Space
                                          const SizedBox(width: 12,),
                                          Expanded(
                                            child: CustomButton(
                                              onPressed: () {
                                                Helper.toScreen(context, NearbyStadiumScreen());
                                              },
                                              btnHeight: 44,
                                              btnRadius: 8,
                                              title: "Quick Book",
                                              fontWeight: FontWeight.w600,
                                              btnColor: kPrimaryColor,
                                              textColor: whiteColor,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //
                //
                Transform.translate(
                  offset: Offset(0.0,-70),
                  child: Container(
                      child:  Column(
                        children: [
                          //Nearby
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  title: "Nearby Courts",
                                  fontSize: 18,
                                  color: darkBlueColor,
                                ),
                                CustomInkWell(
                                  onTap: (){
                                    Helper.toScreen(context, NearbyStadiumScreen());
                                  },
                                  child: CustomText(
                                    title: "See all",
                                    fontSize: 14,
                                    color: blueColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //Space
                          const SizedBox(height: 10,),
                          //
                          Container(
                            height: 130,
                            child: FutureBuilder(
                                future: GetStadiumListServices.getStadiumList(
                                  latitude: UserModel().latitude,
                                  longitude: UserModel().longitude,
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.connectionState == ConnectionState.done) {
                                    GetStadiumListModel? getStadiumListModel = snapshot
                                        .data as GetStadiumListModel?;
                                    return Container(
                                      //padding: EdgeInsets.symmetric(horizontal: 18),
                                      child: ListView.builder(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18),
                                          itemCount: getStadiumListModel!.data!.length,
                                          scrollDirection: Axis.horizontal,
                                          physics: const ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            stdId = getStadiumListModel.data![index].id;
                                            Provider.of<HomePageProvider>(context,listen: false).setStadiumId(stadiumId: stdId);
                                            return Container(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: CustomInkWell(
                                                onTap: (){
                                                  Helper.toScreen(context, StadiumInfoScreen(stadiumId: getStadiumListModel.data![index].id,));
                                                },
                                                child: Card(
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(12)
                                                  ),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width*1-42,
                                                    padding: const EdgeInsets
                                                        .symmetric(horizontal: 10,
                                                        vertical: 12),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 80,
                                                          height: double.infinity,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .circular(12),
                                                            // image: const DecorationImage(
                                                            //     fit: BoxFit.cover,
                                                            //     image: AssetImage(
                                                            //         "assets/images/stadium_img.png")
                                                            // )
                                                          ),
                                                          //clipBehavior: Clip.hardEdge,
                                                          child: Stack(
                                                            clipBehavior: Clip.none,
                                                            children: [
                                                              Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius
                                                                        .circular(12),
                                                                  ),
                                                                  clipBehavior: Clip.hardEdge,
                                                                  child: CustomCachedNetworkImage(url: getStadiumListModel.data![index].stadiumAvatar.toString(),)),
                                                              Positioned
                                                                  .directional(
                                                                textDirection: Directionality
                                                                    .of(context),
                                                                start: -10,
                                                                top: -11,
                                                                child: Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal: 8,
                                                                      vertical: 6),
                                                                  decoration: const BoxDecoration(
                                                                      borderRadius: BorderRadius
                                                                          .only(
                                                                          topLeft: Radius
                                                                              .circular(
                                                                              12),
                                                                          bottomRight: Radius
                                                                              .circular(
                                                                              12)
                                                                      ),
                                                                      color: blueColor
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Image.asset(
                                                                          "assets/icons/ic_star.png",scale: 19,),
                                                                      //Space
                                                                      SizedBox(
                                                                        width: 3,),
                                                                      CustomText(
                                                                        title: getStadiumListModel.data![index].rating.toString(),
                                                                        fontSize: 12,
                                                                        color: whiteColor,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            padding: const EdgeInsets
                                                                .only(left: 12,),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child: CustomText(
                                                                        title: getStadiumListModel.data![index].name,
                                                                        fontSize: 14,
                                                                        color: darkBlueColor,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius
                                                                              .circular(
                                                                              10),
                                                                          color: lightblueColor
                                                                              .withOpacity(
                                                                              0.4)
                                                                      ),
                                                                      padding: const EdgeInsets
                                                                          .all(6.0),
                                                                      child: CustomText(
                                                                        title: "${getStadiumListModel.data![index].distance}"
                                                                            " ${getStadiumListModel.data![index].disMeasurement}",
                                                                        fontSize: 9,
                                                                        color: blueColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                //Space
                                                                SizedBox(
                                                                  height: 5,),
                                                                CustomText(
                                                                  title: "${getStadiumListModel.data![index].address}",
                                                                  fontSize: 12,
                                                                  color: greyColor,
                                                                  maxLines: 1,
                                                                ),
                                                                //Space
                                                                SizedBox(
                                                                  height: 5,),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: CustomText(
                                                                        title: "Available today",
                                                                        fontSize: 12,
                                                                        color: mediumGreenColor,
                                                                      ),
                                                                    ),
                                                                    Image.asset("assets/icons/ic_traced2.png",scale: 9,color: darkBlueColor,)
                                                                    // //Space
                                                                    // SizedBox(
                                                                    //   width: 5,),
                                                                    // CustomText(
                                                                    //   title: "₹150",
                                                                    //   fontSize: 14,
                                                                    //   color: blueColor,
                                                                    // ),
                                                                    // CustomText(
                                                                    //   title: "/hour",
                                                                    //   fontSize: 14,
                                                                    //   color: greyColor,
                                                                    // ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                  }else if(!snapshot.hasData &&
                                      snapshot.connectionState == ConnectionState.done){
                                    return   Container(
                                      alignment: Alignment.center,
                                      child: CustomText(
                                        title: "No Record Found",
                                        color: kPrimaryColor,
                                        fontSize: 22,
                                      ),
                                    );
                                  }else {
                                    return CustomShimmer();
                                  }
                                }
                            ),
                          ),
                        ],
                      )
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
