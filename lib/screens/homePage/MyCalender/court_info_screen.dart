import 'package:VIN/Services/booking_cancel_service.dart';
import 'package:VIN/Services/get_court_info_services.dart';
import 'package:VIN/models/get_court_info_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/screens/booking/booking_main_screen.dart';
import 'package:VIN/screens/homePage/home_page.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/utilites/validator.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_cached_network_image.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class CourtInfoScreen extends StatefulWidget {
  int? courtId;
  var bookingId;
  bool? isUpcoming;
   CourtInfoScreen({
     this.courtId,
     this.bookingId,
     this.isUpcoming,
     Key? key}) : super(key: key);

  @override
  State<CourtInfoScreen> createState() => _CourtInfoScreenState();
}

class _CourtInfoScreenState extends State<CourtInfoScreen> {
  bool? isLoading =false;

  bookingCancel(BuildContext context)async{
        setState((){});
        isLoading=true;
      await BookingCancelService.bookingCancel(
        bookingId: widget.bookingId,
      );
      if (UserModel().success == true){
        setState((){});
        isLoading=false;
        Helper.showSnack(context, "Your booking has been canceled!");
        Helper.toRemoveUntiScreen(context, HomePage());
      }else {
        setState((){});
        isLoading=false;
        Helper.showSnack(context, "The booking id field is required.");
      }
  }

  @override
  Widget build(BuildContext context) {
    print("sssssssssss${widget.bookingId}");
    return CustomParentWidget(
        child:ModalProgressHUD(
          inAsyncCall: Provider.of<MainProvider>(context).isLoading,
          child: Scaffold(
            body: FutureBuilder(
                future: GetCourtInfoServices.getCourtInfo(courtId: widget.courtId),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    GetCourtInfoModel? getCourtInfoModel = snapshot.data as GetCourtInfoModel?;
                    DateTime  bookingDate =DateTime.parse(getCourtInfoModel!.data!.courtTiming![0].endTime.toString());
                    //      DateTime time = DateTime.parse("${homePageProvider.packageIdDataModel!.value!.comments![index].dateTime}");
                    var finalDate2 = DateFormat('dd-MM-yyyy hh:mm').format(bookingDate);
                    var finalDate3 = DateFormat.jm().format(DateFormat("yyyy-MM-dd hh:mm").parse("$finalDate2"));
                   // print(getCourtInfoModel.data.);

                    return  Column(
                      children: [
                        //
                        Container(
                          width: double.infinity,
                          height: 300,
                          child: Stack(
                            children: [
                              Container(
                                  width: double.infinity,
                                  height: 300,
                                  child: CustomCachedNetworkImage(url: getCourtInfoModel.data!.stadiumAvatar??"",)),
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
                                  alignment: Alignment.centerLeft,
                                  child: CustomText(
                                    title: getCourtInfoModel.data!.name,
                                    fontSize: 18,
                                    color: blackColor,
                                    fontWeight: FontWeight.w700,
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
                                          title: "${getCourtInfoModel.data!.stadiumAddress}",
                                          fontSize: 13,
                                          color: darkBlueColor,
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
                                      Image.asset("assets/icons/ic_calendar.png",scale: 4,color: blueColor,),
                                      //Space
                                      SizedBox(width: 8,),
                                      Expanded(
                                        child: CustomText(
                                          title: "$finalDate2",
                                          fontSize: 12,
                                          color: darkBlueColor,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Space
                                SizedBox(height: 60,),
                               //Divider
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: lightblueColor,
                                  indent: 18,
                                  endIndent: 18,
                                ),
                                //Space
                                SizedBox(height: 20,),
                                //
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 18),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        title: "Total amount paid",
                                        fontSize: 18,
                                        color: greyColor,
                                      ),
                                      CustomText(
                                        title: "₹${getCourtInfoModel.data!.courtTiming![0].price.toString()}",
                                        fontSize: 18,
                                        color: blueColor,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        //Space
                        Spacer(),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18,vertical: 20),
                          child:isLoading==true?
                          CupertinoActivityIndicator():
                          CustomButton(
                            onPressed: () {
                              if(widget.isUpcoming==true) {
                                bookingCancel(context);
                              }else{
                                Helper.toScreen(context, BookingMainScreen(
                                  getCourtInfoModel: getCourtInfoModel,
                                  courtId: getCourtInfoModel.data!.id,
                                ));
                              }
                              },
                            btnHeight: 48,
                            btnRadius: 8,
                            title:widget.isUpcoming==true? "Booking Cancel":"Book Again",
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
          ),
        )
    );
  }
}
