import 'package:VIN/Services/get_court_list_services.dart';
import 'package:VIN/Services/get_upcoming_info_services.dart';
import 'package:VIN/models/get_court_list_model.dart';
import 'package:VIN/models/get_upcoming_model.dart';
import 'package:VIN/provider/home_page_provider.dart';
import 'package:VIN/screens/homePage/MyCalender/court_info_screen.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_cached_network_image.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_shimmer.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class PastList extends StatelessWidget {
   PastList({Key? key}) : super(key: key);
   DateTime currentDate = DateTime.now();

   @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: GetUpcomingInfoServices.getUpComingInfo(stadiumId: Provider.of<HomePageProvider>(context).getStadiumId),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              GetUpcomingInfoModel? getUpcomingInfoModel = snapshot
                  .data as GetUpcomingInfoModel?;
              return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: getUpcomingInfoModel!.data!.length,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DateTime  bookingDate =DateTime.parse(getUpcomingInfoModel.data![index].bookingDateTime.toString());
                    if(currentDate.isBefore(bookingDate)){
                      return  Container();
                    }else{
                      return Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CustomInkWell(
                          onTap: () {
                            Helper.toScreen(context, CourtInfoScreen(courtId: getUpcomingInfoModel.data![index].courtId,));
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Container(
                              height: 115,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(12),
                                            ),
                                            clipBehavior: Clip.hardEdge,
                                            child: CustomCachedNetworkImage(url: getUpcomingInfoModel.data![index].stadiumAvatar,)),
                                      ],
                                    ),
                                  ),
                                  //Space
                                  SizedBox(width: 12,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                title: getUpcomingInfoModel.data![index].courtName,
                                                fontSize: 15,
                                                color: darkBlueColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        //Space
                                        SizedBox(height: 5,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                title: getUpcomingInfoModel.data![index].stadiumAddress,
                                                fontSize: 12,
                                                maxLines: 2,
                                                color: greyColor,
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/ic_calendar2.png",
                                                        scale: 4,),
                                                    ],
                                                  ),
                                                  //Space
                                                  SizedBox(width: 5,),
                                                  Expanded(
                                                    child: CustomText(
                                                      title: getUpcomingInfoModel.data![index].bookingDateTime,
                                                      fontSize: 12,
                                                      color: darkBlueColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
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
    );
  }
}
