import 'package:VIN/models/get_court_info_model.dart';
import 'package:VIN/models/get_court_list_model.dart';
import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/screens/booking/booking_detail_screen.dart';
import 'package:VIN/screens/payment/payment_screen.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bulk_booking.dart';
import 'one_time_booking.dart';
class BookingMainScreen extends StatelessWidget {
   GetCourtListModel? getCourtListModel;
   GetCourtInfoModel? getCourtInfoModel;
   int? index;
   int? courtId;
   BookingMainScreen({
     this.getCourtListModel,
     this.getCourtInfoModel,
     this.index,
     this.courtId,
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  CustomInkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/icons/ic_back.png",color: darkBlueColor,),
                    ),
                  ),
                  //
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: CustomText(
                        title: "Booking",
                        fontSize: 18,
                        color: darkBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            //Buttons
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Provider.of<MainProvider>(context,
                            listen: false).bookingtoggle(false);
                      },
                      btnHeight: 48,
                      btnRadius: 8,
                      title: "One time booking",
                      fontWeight: FontWeight.w600,
                      btnColor:Provider.of<MainProvider>(context)
                          .isBulk ==
                          false? kPrimaryColor:lightblueColor,
                      textColor:Provider.of<MainProvider>(context)
                          .isBulk ==
                          false?  whiteColor:darkBlueColor,
                      fontSize: 14,
                    ),
                  ),
                  //Space
                  SizedBox(width: 12,),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Provider.of<MainProvider>(context,
                            listen: false).bookingtoggle(true);
                      },
                      btnHeight: 48,
                      btnRadius: 8,
                      title: "Bulk booking",
                      fontWeight: FontWeight.w600,
                      btnColor:Provider.of<MainProvider>(context)
                          .isBulk ==
                          false?lightblueColor:kPrimaryColor,
                      textColor:Provider.of<MainProvider>(context)
                          .isBulk ==
                          false?  darkBlueColor:whiteColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            //Space
            SizedBox(height: 30,),
            //
            Provider.of<MainProvider>(context)
                .isBulk ==
                false?
               Expanded(
                 child: OneTimeBooking(
                   getCourtListModel: getCourtListModel,
                   index: index,
                   courtId: courtId,
                 ),
               ):
            Expanded(
              child: BulkBooking(getCourtListModel: getCourtListModel,
                  index: index,
                 courtId: courtId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
