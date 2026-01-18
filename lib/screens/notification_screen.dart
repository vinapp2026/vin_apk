import 'package:VIN/Services/get_notification_services.dart';
import 'package:VIN/models/notification_model.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_shimmer.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NotificationScreen extends StatelessWidget {
   NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomParentWidget(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteColor,
          leading:    CustomInkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/icons/ic_back.png",color: darkBlueColor,),
            ),
          ),
          title: CustomText(
            title: "Notifications",
            fontSize: 18,
            color: darkBlueColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        body:FutureBuilder(
          future: GetNotificationServices.getNotificationInfo(),
          builder: (context, snapshot) {
          if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
            NotificationModel? notificationModel = snapshot.data as NotificationModel?;
            return Column(
        children: [
          //
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            alignment: Alignment.centerLeft,
            child: CustomText(
              title: "Booking details",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: darkBlueColor,
            ),
          ),
          //Space
          SizedBox(height: 12,),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: notificationModel!.data!.length,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var oldDate = notificationModel.data![index].createdDate;
                  var date = DateFormat('dd MMM yyyy').format(oldDate!);
                  return Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CustomInkWell(
                      onTap: () {
                        //        Helper.toScreen(context, CourtProfileScreen2());
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Container(
                          height: 90,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child:notificationModel.data![index].comment!.contains("Your booking is failed")||
                                      notificationModel.data![index].comment!.contains("Your booking has been canceled!.")?
                                  Image.asset(
                                      "assets/icons/ic_error.png"):
                                  Image.asset(
                                      "assets/icons/ic_confirmed.png"),
                                ),
                              ),
                              //Space
                              SizedBox(width: 12,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      title: "${notificationModel.data![index].comment}",
                                      fontSize: 15,
                                      color: darkBlueColor,
                                    ),
                                    //Space
                                    SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        CustomText(
                                          title: "$date",
                                          fontSize: 12,
                                          color: greyColor,
                                        ),
                                        //Space
                                        SizedBox(width: 15,),
                                        CustomText(
                                          title: "${notificationModel.data![index].createdTime}",
                                          fontSize: 12,
                                          color: greyColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
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
    );
  }
}
