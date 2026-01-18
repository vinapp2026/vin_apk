
import 'dart:ui';

import 'package:VIN/Services/get_court_list_services.dart';
import 'package:VIN/models/get_court_list_model.dart';
import 'package:VIN/screens/booking/booking_main_screen.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_cached_network_image.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_shimmer.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'court_profile_screen.dart';
class CourtsListScreen extends StatelessWidget {
  int? stadiumId;
   CourtsListScreen({
     this.stadiumId,
     Key? key}) : super(key: key);
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
                      title: "Courts List",
                      fontSize: 18,
                      color: whiteColor,
                    ),
                  ),
                  // CustomInkWell(
                  //   onTap: (){},
                  //   child: Container(
                  //     padding: const EdgeInsets.all(6.0),
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: lightblueColor.withOpacity(0.4)
                  //     ),
                  //     child: Image.asset("assets/icons/ic_search.png"),
                  //   ),
                  // ),
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
                  child:   FutureBuilder(
                    future: GetCourtListServices.getCourtList(stadiumId:stadiumId ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        GetCourtListModel? getCourtListModel = snapshot.data as GetCourtListModel?;
                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16,vertical: 15),
                            itemCount: getCourtListModel!.data!.length,
                            physics:  ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: CustomInkWell(
                                  onTap: (){
                                    Helper.toScreen(context, BookingMainScreen(
                                      getCourtListModel: getCourtListModel,
                                      index: index,
                                      courtId: getCourtListModel.data![index].id,
                                    ));
                                  },
                                  child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Container(
                                      height: 215,
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 12),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 110,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(12),
                                            ),
                                            clipBehavior: Clip.hardEdge,
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                CustomCachedNetworkImage(url: getCourtListModel.data![index].stadiumAvatar.toString(),),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              //Space
                                              SizedBox(height: 8,),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: CustomText(
                                                      title: getCourtListModel.data![index].name,
                                                      fontSize: 15,
                                                      color: darkBlueColor,
                                                    ),
                                                  ),
                                                  //
                                                  Image.asset(
                                                    "assets/icons/ic_traced2.png",
                                                    color: darkBlueColor,
                                                    scale: 9,
                                                  ),
                                                ],
                                              ),
                                              //Space
                                              SizedBox(height: 5,),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: CustomText(
                                                  title: getCourtListModel.data![index].stadiumAddress,
                                                  fontSize: 12,
                                                  maxLines: 2,
                                                  color: greyColor,
                                                ),
                                              ),
                                              //Space
                                              SizedBox(height: 5,),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment
                                              //       .spaceBetween,
                                              //   children: [
                                              //     Expanded(
                                              //       child: Row(
                                              //         children: [
                                              //           Image.asset(
                                              //               "assets/icons/ic_star.png"),
                                              //           //Space
                                              //           SizedBox(width: 3,),
                                              //           CustomText(
                                              //             title: getCourtListModel.data![index].isBulk,
                                              //             fontSize: 12,
                                              //             color: darkBlueColor,
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //     //Space
                                              //     SizedBox(width: 5,),
                                              //     CustomText(
                                              //       title: "0",
                                              //       fontSize: 14,
                                              //       color: blueColor,
                                              //     ),
                                              //     CustomText(
                                              //       title: "/0",
                                              //       fontSize: 14,
                                              //       color: greyColor,
                                              //     ),
                                              //   ],
                                              // ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
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
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
