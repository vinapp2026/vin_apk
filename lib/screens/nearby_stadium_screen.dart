
import 'package:VIN/Services/get_stadium_list_services.dart';
import 'package:VIN/models/get_stadium_list_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_cached_network_image.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_shimmer.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'homePage/stadium_info_screen.dart';
import 'search_screen.dart';
class NearbyStadiumScreen extends StatefulWidget {
   int? stadiumId;
   NearbyStadiumScreen({
     this.stadiumId,
     Key? key}) : super(key: key);

  @override
  State<NearbyStadiumScreen> createState() => _NearbyStadiumScreenState();
}

class _NearbyStadiumScreenState extends State<NearbyStadiumScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomParentWidget(
      child: Scaffold(
        body: Column(
          children: [
            //Appbar
            Container(
              height: 110,
              color: blueColor,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  CustomInkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/icons/ic_back.png"),
                    ),
                  ),
                  //Space
                  SizedBox(width: 20,),
                  //
                  Expanded(
                    child: CustomText(
                      title: "Nearby Stadiums",
                      fontSize: 18,
                      color: whiteColor,
                    ),
                  ),
                  CustomInkWell(
                    onTap: (){
                      Helper.toScreen(context, SearchScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: lightblueColor.withOpacity(0.4)
                      ),
                      child: Image.asset("assets/icons/ic_search.png",scale: 14,),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Transform.translate(
                offset: Offset(0.0,-20.0),
                child: Container(
                  //  height: double.infinity,
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
                        SizedBox(height: 20,),

                        // card
                        // Container(
                        //   padding: const EdgeInsets.symmetric(horizontal: 16,),
                        //   child: Card(
                        //     elevation: 3,
                        //     shape:  RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(9)
                        //     ),
                        //     child: Container(
                        //       height: 48,
                        //       width: double.infinity,
                        //       decoration: BoxDecoration(
                        //           color: blueColor,
                        //           border: Border.all(width: 1, color: blueColor),
                        //           borderRadius: BorderRadius.circular(9)),
                        //       clipBehavior: Clip.none,
                        //       child: Row(
                        //         children: [
                        //           Expanded(
                        //             child: Stack(
                        //               children: [
                        //                 CustomButton(
                        //                   onPressed: () {
                        //                    sortDialogue(context);
                        //                   },
                        //                   btnHeight: 48,
                        //                   btnRadius: 8,
                        //                   title: "Sort by",
                        //                   fontWeight: FontWeight.w600,
                        //                   btnColor: kPrimaryColor,
                        //                   textColor: whiteColor,
                        //                   fontSize: 13,
                        //                 ),
                        //                 Positioned.directional(
                        //                     textDirection: Directionality.of(context),
                        //                     start: 5,
                        //                     top: 0,
                        //                     bottom: 0,
                        //                     child: Image.asset("assets/icons/ic_menu.png",))
                        //               ],
                        //             ),
                        //           ),
                        //           const VerticalDivider(
                        //             width: 1,
                        //             color: whiteColor,
                        //             indent: 8,
                        //             endIndent: 8,
                        //           ),
                        //           Expanded(
                        //             child: Stack(
                        //               children: [
                        //                 CustomButton(
                        //                   onPressed: () {
                        //                     filterDialogue(context);
                        //                   },
                        //                   btnHeight: 48,
                        //                   btnRadius: 8,
                        //                   title: "Filter by",
                        //                   fontWeight: FontWeight.w600,
                        //                   btnColor: kPrimaryColor,
                        //                   textColor: whiteColor,
                        //                   fontSize: 13,
                        //                 ),
                        //                 Positioned.directional(
                        //                     textDirection: Directionality.of(context),
                        //                     start: 0,
                        //                     top: 0,
                        //                     bottom: 0,
                        //                     child: Image.asset("assets/icons/ic_filter.png",))
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // //Space
                        // SizedBox(height: 20,),

                        FutureBuilder(
                            future: GetStadiumListServices.getStadiumList(
                              latitude: UserModel().latitude,
                              longitude: UserModel().longitude,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.connectionState == ConnectionState.done) {
                                GetStadiumListModel? getStadiumListModel = snapshot
                                    .data as GetStadiumListModel?;
                                return Expanded(
                                  child:  ListView.builder(
                                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 15),
                                      itemCount: getStadiumListModel!.data!.length,
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context,index){
                                        return Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 10),
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
                                                // width: double.infinity,
                                                height: 120,
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
                                                              child: CustomCachedNetworkImage(url: getStadiumListModel.data![index].stadiumAvatar,)),
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
                                      })
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
                                return Expanded(child: CustomShimmer());
                              }
                            }
                        ),
                      ],
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // var groupValue = 1;
  String _selectedVal = 'Popularity';
   void sortDialogue(BuildContext context) {
     showDialog(
       context: context,
       builder: (BuildContext ctx) {
         return  Dialog(
           insetPadding: EdgeInsets.symmetric(horizontal: 30),
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
           clipBehavior: Clip.hardEdge,
           child: Container(
               padding: EdgeInsets.symmetric(vertical: 25,),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   //Sort by
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 20),
                     alignment: Alignment.centerLeft,
                     child: CustomText(
                       title: "Sort by",
                       fontSize: 18,
                       color: blackColor,
                       fontWeight: FontWeight.w700,
                     ),
                   ),
                   //space
                   SizedBox(height: 10,),
                   //Popularity
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 7),
                     height: 50,
                     child: Row(
                       children: [
                         Transform.scale(
                           scale: 0.8,
                           child: Radio(
                             value: "Popularity",
                             groupValue: _selectedVal,
                             activeColor: Colors.blue,
                             onChanged: (value) {
                               setState(() {
                                 _selectedVal = value!.toString();
                               });
                             },
                           ),
                         ),
                         //space
                         SizedBox(width: 2,),
                         Expanded(
                           child: CustomText(
                             title: "Popularity",
                             fontSize: 16,
                             color: blackColor,
                           ),
                         )
                       ],
                     ),
                   ),
                   //Distance
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 7),
                     height: 50,
                     child: Row(
                       children: [
                         Transform.scale(
                           scale: 0.8,
                           child: Radio(
                             value: "Distance",
                             groupValue: _selectedVal,
                             activeColor: Colors.blue,
                             onChanged: (value) {
                               setState(() {
                                 _selectedVal = value!.toString();
                               });
                             },
                           ),
                         ),
                         //space
                         SizedBox(width: 2,),
                         Expanded(
                           child: CustomText(
                             title: "Distance",
                             fontSize: 16,
                             color: blackColor,
                           ),
                         )
                       ],
                     ),
                   ),
                   //Space
                   SizedBox(height: 8,),
                   //
                   CustomButton(
                     onPressed: () {
                     },
                     btnHeight: 40,
                     btnWidth: 120,
                     btnRadius: 7,
                     title: "Done",
                     fontWeight: FontWeight.w600,
                     btnColor: kPrimaryColor,
                     textColor: whiteColor,
                     fontSize: 15,
                   )
                 ],
               )
           ),
         );
       },
     );
   }

//filter
   filterDialogue(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          clipBehavior: Clip.hardEdge,
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
              return Container(
                  padding: EdgeInsets.symmetric(vertical: 25,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //Filter by
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          title: "Filter by",
                          fontSize: 18,
                          color: blackColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      //space
                      SizedBox(height: 25,),
                      //Venues with offers
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: CustomInkWell(
                          onTap: () {
                          },
                          child: Container(
                            width: double.infinity,
                            height: 44,
                            decoration: BoxDecoration(
                                color: lightblueColor,
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: Stack(
                              children: [
                                Positioned.directional(
                                    textDirection: Directionality.of(context),
                                    start: 60,
                                    top: 0,
                                    bottom: 0,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: CustomText(
                                          title: "Venues with offers",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: kPrimaryColor
                                      ),
                                    )),
                                Positioned.directional(
                                    textDirection: Directionality.of(context),
                                    start: 12,
                                    top: 0,
                                    bottom: 0,
                                    child: Image.asset("assets/icons/ic_venues.png",scale: 1.4,))
                              ],
                            ),
                          ),
                        ),
                      ),
                      //space
                      SizedBox(height: 15,),
                      //Safety
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: CustomInkWell(
                          onTap: () {
                          },
                          child: Container(
                            width: double.infinity,
                            height: 44,
                            decoration: BoxDecoration(
                                color: lightblueColor,
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: Stack(
                              children: [
                                Positioned.directional(
                                    textDirection: Directionality.of(context),
                                    start: 60,
                                    top: 0,
                                    bottom: 0,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: CustomText(
                                          title: "Safety and hygine",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: kPrimaryColor
                                      ),
                                    )),
                                Positioned.directional(
                                    textDirection: Directionality.of(context),
                                    start: 12,
                                    top: 0,
                                    bottom: 0,
                                    child: Image.asset("assets/icons/ic_safety.png",scale: 1.4,))
                              ],
                            ),
                          ),
                        ),
                      ),
                      //space
                      SizedBox(height: 15,),
                      //3+
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: CustomInkWell(
                          onTap: () {
                          },
                          child: Container(
                            width: double.infinity,
                            height: 44,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: Stack(
                              children: [
                                Positioned.directional(
                                    textDirection: Directionality.of(context),
                                    start: 60,
                                    top: 0,
                                    bottom: 0,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: CustomText(
                                          title: "3+ Rated Venues",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: whiteColor
                                      ),
                                    )),
                                Positioned.directional(
                                    textDirection: Directionality.of(context),
                                    start: 12,
                                    top: 0,
                                    bottom: 0,
                                    child: Image.asset("assets/icons/ic_star2.png",scale: 1.4,))
                              ],
                            ),
                          ),
                        ),
                      ),
                      //space
                      SizedBox(height: 30,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                onPressed: () {
                                },
                                btnHeight: 44,
                                btnRadius: 4,
                                title: "Reset",
                                fontWeight: FontWeight.w600,
                                btnBorderColor: kPrimaryColor,
                                textColor: kPrimaryColor,
                                fontSize: 15,
                              ),
                            ),
                            //space
                            SizedBox(width: 15,),
                            Expanded(
                              child: CustomButton(
                                onPressed: () {
                                  //    Helper.toScreen(context, CourtProfileScreen());
                                  Navigator.pop(context);
                                },
                                btnHeight: 44,
                                btnRadius: 4,
                                title: "Done",
                                fontWeight: FontWeight.w600,
                                btnColor: kPrimaryColor,
                                textColor: whiteColor,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
              );
            }
          ),
        );
      },
    );
  }
}
