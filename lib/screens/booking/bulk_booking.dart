import 'package:VIN/Services/get_court_bulk_info_services.dart';
import 'package:VIN/Services/save_booking_info_services.dart';
import 'package:VIN/models/custom_model.dart';
import 'package:VIN/models/get_court_bulk_info_model.dart';
import 'package:VIN/models/get_court_list_model.dart';
import 'package:VIN/models/save_booking_info_model.dart';
import 'package:VIN/provider/booking_provider.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/utilites/validator.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'booking_detail_screen.dart';
class BulkBooking extends StatefulWidget {
  GetCourtListModel? getCourtListModel;
  int? index;
  int? courtId;
   BulkBooking({
     this.getCourtListModel,
     this.index,
     this.courtId,
     Key? key}) : super(key: key);

  @override
  State<BulkBooking> createState() => _BulkBookingState();
}

class _BulkBookingState extends State<BulkBooking> {
   bool selectDuration=false;

   var selectTime;

   var tapIndex;

   var bookingType;
   var slotId;
   var courtId;
   var amount;
   var bookingID;
   var timeID;
   var bookingDate;
   var stadiumID;
   DateTime currentDate = DateTime.now();

   saveBooking()async{
   //  var date = DateFormat('yyyy-MM-dd').format(currentDate);
     if(selectDuration ==false){
       showToast("Select Duration");
     }else if(selectTime == null){
       showToast("Select Time");
     }else{
       SaveBookingInfoModel? saveBookingInfoModel;
       Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
       saveBookingInfoModel = await Provider.of<BookingProvider>(context, listen: false).saveBookingInfo2(
         bookingType: 2,
         slotId: slotId,
         courtId: courtId,
         amount: amount,
        // bookingID: bookingID,
         timeID: timeID,
         bookingDate: dateVal,
         stadiumID: stadiumID,
       );
       print(saveBookingInfoModel!.message);
       if (Provider.of<BookingProvider>(context,listen: false).message == "No Slot Available"){
         Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
         Helper.showSnack(context, "No Slot Available");
       }else if (saveBookingInfoModel.message != "Your booking has been done"){
         Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
         Helper.showSnack(context, "Booking Failed");
       }else {
         Helper.toScreen(context, BookingDetailScreen(saveBookingInfoModel: saveBookingInfoModel,));
         Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
         Helper.showSnack(context, "Booking Successfully");
       }
     }
   }
   var now = DateTime.now();
   var dateVal;
   var timeVal;
   Future<void> openDatePicker(BuildContext context) async {
     final DateTime? picked = await showDatePicker(
       context: context,
       initialDate: currentDate,
       firstDate: currentDate,
       lastDate: DateTime(2101),
     );
     if (picked != null && picked != currentDate) {
       setState(() {
         dateVal = DateFormat('yyyy-MM-dd').format(picked);
         print(dateVal);
       });
     }
   }

  @override
  Widget build(BuildContext context) {
    var oldVal = DateFormat('yyyy-MM-dd').format(now);

    return ModalProgressHUD(
      inAsyncCall: Provider.of<MainProvider>(context).isLoading,
      child: FutureBuilder(
          future: GetCourtBulkInfoServices.getCourtBulkInfo(courtId: widget.courtId),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              GetCourtBulkInfoModel? getCourtBulkInfoModel = snapshot.data as GetCourtBulkInfoModel? ;
              if(getCourtBulkInfoModel!.data!.bulkDuartion![0].timing!.isEmpty){
                return   Container(
                  alignment: Alignment.center,
                  child: CustomText(
                    title: "Booking Not Available",
                    color: kPrimaryColor,
                    fontSize: 22,
                  ),
                );
              }else{
                //    bookingType = getCourtBulkInfoModel!.data!.courtTypeId;
                courtId = getCourtBulkInfoModel.data!.id;
                bookingDate = dateVal;
                stadiumID = getCourtBulkInfoModel.data!.stadiumId;
                print("court  $courtId");
                print("stadium  $stadiumID");
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        //Date
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            title: "Date",
                            fontSize: 15,
                            color: darkBlueColor,
                          ),
                        ),
                        //Space
                        SizedBox(height: 15,),
                        //Date
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: CustomInkWell(
                            onTap: (){
                              openDatePicker(context);
                            },
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: blueColor),
                                  borderRadius: BorderRadius.circular(6)),
                              clipBehavior: Clip.none,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 12),
                                      alignment: Alignment.centerLeft,
                                      child: CustomText(
                                        title:dateVal==null?"$oldVal":"$dateVal",
                                        fontSize: 15,
                                        color: darkBlueColor,
                                      ),
                                    ),
                                  ),
                                  CustomInkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                          color: lightblueColor,
                                          borderRadius: BorderRadius.circular(6)),

                                      alignment: Alignment.center,
                                      child: Image.asset("assets/icons/ic_calendar.png",scale: 4,color: blueColor,),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //Space
                        SizedBox(height: 20,),
                        //Duration
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            title: "Duration",
                            fontSize: 15,
                            color: darkBlueColor,
                          ),
                        ),
                        //Space
                        SizedBox(height: 15,),
                        //Duration slot
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                                spacing: 0,
                                runSpacing: 20,
                                children: List.generate(getCourtBulkInfoModel.data!.bulkDuartion!.length, (index){
                                  slotId = getCourtBulkInfoModel.data!.bulkDuartion![index].id;
                                  print("ssssssssssssssssssssssss$slotId");
                                  return  Container(
                                    width: MediaQuery.of(context).size.width*0.3,
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: CustomButton(
                                      onPressed: () {
                                        setState(() {
                                          selectDuration=true;
                                        });
                                      },
                                      btnHeight: 48,
                                      btnRadius: 8,
                                      title: "${getCourtBulkInfoModel.data!.bulkDuartion![index].totalNoOfDays.toString()} "
                                          "${getCourtBulkInfoModel.data!.bulkDuartion![index].daysLabel}",
                                      fontWeight: FontWeight.w600,
                                      btnColor:selectDuration==true? blueColor:lightblueColor,
                                      textColor:selectDuration==true? whiteColor: darkBlueColor,
                                      fontSize: 16,
                                    ),
                                  );
                                })
                            )
                        ),

                        //Space
                        SizedBox(height: 20,),
                        //Time
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            title: "Time",
                            fontSize: 15,
                            color: darkBlueColor,
                          ),
                        ),
                        //Space
                        SizedBox(height: 15,),
                        //time slot
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Wrap(
                                spacing: 0,
                                runSpacing: 20,
                                children: List.generate(getCourtBulkInfoModel.data!.bulkDuartion![0].timing!.length, (index){
                                  // slotId = getCourtBulkInfoModel.data!.bulkDuartion![0].timing![0].id;
                                  amount = getCourtBulkInfoModel.data!.bulkDuartion![0].timing![index].price;
                                  //  bookingID = getCourtBulkInfoModel.data!.bulkDuartion![0].timing![index].id;
                                  timeID = getCourtBulkInfoModel.data!.bulkDuartion![0].timing![index].id;
                                  print("timeeeeeeeeeeee $timeID");
                                  return Container(
                                    width: MediaQuery.of(context).size.width*0.5-18,
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child:  CustomInkWell(
                                      onTap: (){
                                        setState(() {
                                          tapIndex = index;
                                          selectTime ="${getCourtBulkInfoModel.data!.bulkDuartion![0].timing![index].startTiming} "
                                              "- ${getCourtBulkInfoModel.data!.bulkDuartion![0].timing![index].endTiming}";
                                        });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            color: tapIndex == index?blueColor:lightblueColor,
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              title: "${getCourtBulkInfoModel.data!.bulkDuartion![0].timing![index].timingLabel} ",
                                              fontSize: 18,
                                              color: tapIndex == index?whiteColor:darkBlueColor,
                                            ),
                                            CustomText(
                                              title: "${getCourtBulkInfoModel.data!.bulkDuartion![0].timing![index].startTiming} "
                                                  "- ${getCourtBulkInfoModel.data!.bulkDuartion![0].timing![index].endTiming}",
                                              fontSize: 11,
                                              color: tapIndex == index?whiteColor:darkBlueColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })
                            )
                        ),
                        //Space
                        SizedBox(height: 15,),
                      ],
                    ),
                  ),
                  bottomNavigationBar: BottomAppBar(
                    elevation: 0,
                    child:  Container(
                      width: double.infinity,
                      height: 80,
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      color: blueColor,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      title:getCourtBulkInfoModel.data!.bulkDuartion![0].timing![0].price==null?"₹ 0":
                                      "₹ ${getCourtBulkInfoModel.data!.bulkDuartion![0].timing![0].price}",
                                      fontSize: 18,
                                      color: whiteColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CustomButton(
                            onPressed: () {
                              saveBooking();
                            },
                            btnHeight: 40,
                            btnWidth: 120,
                            btnRadius: 8,
                            title: "Continue",
                            fontWeight: FontWeight.w600,
                            btnColor: whiteColor,
                            textColor: blueColor,
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
            else if(!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done){
              return   Container(
                alignment: Alignment.center,
                child: CustomText(
                  title: "No Record Found",
                  color: kPrimaryColor,
                  fontSize: 22,
                ),
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
    );
  }
}
