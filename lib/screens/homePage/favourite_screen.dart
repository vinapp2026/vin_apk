import 'package:VIN/Services/get_favourite_services.dart';
import 'package:VIN/models/favourite_list_model.dart';
import 'package:VIN/models/get_stadium_list_model.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_cached_network_image.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_shimmer.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'stadium_info_screen.dart';
class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteColor,
          centerTitle: false,
          title:    CustomText(
            title: "Favourite Venues",
            fontSize: 18,
            color: darkBlueColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        body: FutureBuilder(
          future: GetFavouriteServices.getFavouriteList(),
          builder: (context, snapshot) {
          if (snapshot.hasData &&
          snapshot.connectionState == ConnectionState.done) {
            FavouriteListModel? favouriteListModel = snapshot
                .data as FavouriteListModel?;
                return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    itemCount: favouriteListModel!.data!.length,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return Container(
                        padding: const EdgeInsets.only(
                            bottom: 10),
                        child: CustomInkWell(
                          onTap: (){
                               Helper.toScreen(context, StadiumInfoScreen(stadiumId: favouriteListModel.data![index].stadiumId,));
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
                                            child: CustomCachedNetworkImage(url: favouriteListModel.data![index].stadiumAvatar,)),
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
                                                  title: favouriteListModel.data![index].rating.toString(),
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
                                                  title: favouriteListModel.data![index].stadiumName,
                                                  fontSize: 14,
                                                  color: darkBlueColor,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              //Space
                                              SizedBox(width: 20,),
                                              // Container(
                                              //   decoration: BoxDecoration(
                                              //       borderRadius: BorderRadius
                                              //           .circular(
                                              //           10),
                                              //       color: lightblueColor
                                              //           .withOpacity(
                                              //           0.4)
                                              //   ),
                                              //   padding: const EdgeInsets
                                              //       .all(6.0),
                                              //   child: CustomText(
                                              //     title: "${favouriteListModel.data![index].distance}"
                                              //         " ${favouriteListModel.data![index].disMeasurement}",
                                              //     fontSize: 9,
                                              //     color: blueColor,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          //Space
                                          SizedBox(
                                            height: 5,),
                                          CustomText(
                                            title: "${favouriteListModel.data![index].stadiumAddress}",
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
        ),
      )
    );
  }
}
