import 'package:VIN/Services/auth_services.dart';
import 'package:VIN/Services/get_court_info_services.dart';
import 'package:VIN/Services/save_booking_info_services.dart';
import 'package:VIN/models/custom_model.dart';
import 'package:VIN/models/get_booking_info_model.dart';
import 'package:VIN/models/get_court_info_model.dart';
import 'package:VIN/models/get_court_list_model.dart';
import 'package:VIN/models/get_stadium_info_model.dart';
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
class OneTimeBooking extends StatefulWidget {
  GetCourtListModel? getCourtListModel;
  int? index;
  int? courtId;
   OneTimeBooking({
     this.getCourtListModel,
     this.index,
     this.courtId,
     Key? key}) : super(key: key);

  @override
  State<OneTimeBooking> createState() => _OneTimeBookingState();
}

class _OneTimeBookingState extends State<OneTimeBooking> {
   DateTime currentDate = DateTime.now();

   var dateVal;
   var timeVal;

   var now = DateTime.now();

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

   var bookingType;
   var slotId;
   var courtId;
   var amount;
   var bookingID;
   var timeID;
   var bookingDate;
   var stadiumID;


   saveBooking()async{
     if(dateVal ==null){
       showToast("Select Date");
     }else if(isTime == false){
       showToast("Select Time");
     }else{
       SaveBookingInfoModel? saveBookingInfoModel;

       Provider.of<MainProvider>(context, listen: false).changeIsLoading(true);
       setState(() {

       });
       saveBookingInfoModel = await Provider.of<BookingProvider>(context, listen: false).saveBookingInfo(
         bookingType: bookingType,
         slotId: slotId,
         courtId: courtId,
         amount: amount,
       //  bookingID: bookingID,
         timeID: timeID,
         bookingDate: dateVal,
         stadiumID: stadiumID,
       );
       if (Provider.of<BookingProvider>(context,listen: false).message == "No Slot Available"){
         Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
         Helper.showSnack(context, "No Slot Available");
       }else if (saveBookingInfoModel!.message != "Your booking has been done"){
         Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
         Helper.showSnack(context, "Booking Failed");
       }else {
         Helper.toScreen(context, BookingDetailScreen(saveBookingInfoModel: saveBookingInfoModel,));
         Provider.of<MainProvider>(context, listen: false).changeIsLoading(false);
         Helper.showSnack(context, "Booking Successfully");
       }
     }
   }

bool isTime=false;
   var tapIndex;
  @override
  Widget build(BuildContext context) {
    print(widget.courtId);
    var oldVal = DateFormat('yyyy-MM-dd').format(now);
    return ModalProgressHUD(
      inAsyncCall: Provider.of<MainProvider>(context).isLoading,
      child: FutureBuilder(
          future: GetCourtInfoServices.getCourtInfo(courtId: widget.courtId),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            GetCourtInfoModel? getCourtInfoModel = snapshot.data as GetCourtInfoModel?;
            if(getCourtInfoModel!.data!.courtTiming!.isNotEmpty){
              bookingType = 1;
               stadiumID = getCourtInfoModel.data!.stadiumId;
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
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          alignment: Alignment.centerLeft,
                          child:Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: List.generate(getCourtInfoModel.data!.courtTiming!.length, (index){
                              slotId = getCourtInfoModel.data!.courtTiming![index].id;
                              print("slooooooooooot$slotId");
                              courtId = getCourtInfoModel.data!.id;
                              print("ccccccc$courtId");
                              amount = getCourtInfoModel.data!.courtTiming![index].price;
                              //bookingID = getCourtInfoModel.data!.courtTiming![index].id;
                              //timeID = getCourtInfoModel.data!.courtTiming![index].id;
                              bookingDate = dateVal;

                              final now = DateTime.now();
                              final expirationDate = DateTime(now.year,now.month,now.day);
                              final bool isExpired = expirationDate.isBefore(now);

                              DateTime  checkData =DateTime.parse(dateVal==null?oldVal:dateVal);
                              print("_s ${now.isBefore(checkData)}");
                              if(getCourtInfoModel.data!.courtTiming![index].startTiming!=null) {
                                TimeOfDay stringToTimeOfDay() {
                                  final format = DateFormat.jm(); //"6:00 AM"
                                  return TimeOfDay.fromDateTime(format.parse(getCourtInfoModel.data!.courtTiming![index].startTiming.toString()));
                                }
                                TimeOfDay string2ToTimeOfDay() {
                                  final format = DateFormat.jm(); //"6:00 AM"
                                  return TimeOfDay.now();
                                }
                                print("tm ${stringToTimeOfDay()}");
                                print("tm2 ${string2ToTimeOfDay()}");
                               bool isCheck  = now.isBefore(checkData);
                               print("check $isCheck");
                                if(isCheck==true) {
                                  return CustomInkWell(
                                    onTap: () {
                                      setState(() {
                                        isTime = true;
                                        tapIndex = index;
                                        timeVal = "${getCourtInfoModel.data!
                                            .courtTiming![index].startTiming
                                            .toString()} "
                                            "- ${getCourtInfoModel.data!
                                            .courtTiming![index].endTiming
                                            .toString()}";
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              4),
                                          color: tapIndex == index
                                              ? blueColor
                                              : lightblueColor
                                      ),
                                      child: CustomText(
                                        title: "${getCourtInfoModel.data!
                                            .courtTiming![index].startTiming} "
                                            "- ${getCourtInfoModel.data!
                                            .courtTiming![index].endTiming}",
                                        fontSize: 14,
                                        color: tapIndex == index
                                            ? whiteColor
                                            : blackColor,
                                      ),
                                    ),
                                  );
                                }else
                                if(isCheck==false&&int.parse(stringToTimeOfDay().hour.toString())>int.parse(string2ToTimeOfDay().hour.toString())) {
                                  return CustomInkWell(
                                    onTap: () {
                                      setState(() {
                                        isTime = true;
                                        tapIndex = index;
                                        timeVal = "${getCourtInfoModel.data!
                                            .courtTiming![index].startTiming
                                            .toString()} "
                                            "- ${getCourtInfoModel.data!
                                            .courtTiming![index].endTiming
                                            .toString()}";
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              4),
                                          color: tapIndex == index
                                              ? blueColor
                                              : lightblueColor
                                      ),
                                      child: CustomText(
                                        title: "${getCourtInfoModel.data!
                                            .courtTiming![index].startTiming} "
                                            "- ${getCourtInfoModel.data!
                                            .courtTiming![index].endTiming}",
                                        fontSize: 14,
                                        color: tapIndex == index
                                            ? whiteColor
                                            : blackColor,
                                      ),
                                    ),
                                  );
                                }else{
                                  return SizedBox();
                                }
                              }else{
                                return SizedBox();
                              }
                            }),
                          )
                      ),

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
                                    title:amount==null?"":"₹$amount",
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
            }else{
              return   Container(
                alignment: Alignment.center,
                child: CustomText(
                  title: "Booking Not Available",
                  color: kPrimaryColor,
                  fontSize: 22,
                ),
              );
            }
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
