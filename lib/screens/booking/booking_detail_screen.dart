import 'dart:ui';

import 'package:VIN/Services/get_booking_info_services.dart';
import 'package:VIN/Services/save_notification_services.dart';
import 'package:VIN/Services/save_payment_services.dart';
import 'package:VIN/models/get_booking_info_model.dart';
import 'package:VIN/models/save_booking_info_model.dart';
import 'package:VIN/models/user_model.dart';
import 'package:VIN/screens/homePage/home_page.dart';
import 'package:VIN/screens/payment/payment_success_screen.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/utilites/validator.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_cached_network_image.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class BookingDetailScreen extends StatefulWidget {
  SaveBookingInfoModel? saveBookingInfoModel;
   BookingDetailScreen({
     this.saveBookingInfoModel,
     Key? key}) : super(key: key);

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  static const platform = const MethodChannel("razorpay_flutter");

  var  _razorpay = Razorpay();

   void initState() {
     super.initState();
     _razorpay = Razorpay();
     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
   }



  void openCheckout() async {
    var options = {
      'key': 'rzp_live_sLcL2BkSgvXQ5j',
      'amount': widget.saveBookingInfoModel!.data!.amount*100,
      //'order_id': widget.saveBookingInfoModel!.data!.orderId.toString(),
      'name': 'Court Booking',
      'description': 'Active Payment',
      'timeout': 300,
      'send_sms_hash': true,
      'prefill': {
        'contact': '+91 - 9880789692',
        'email': 'vinsports1000@gmail.com'},
      'external': {
        'wallet': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    showToast( "SUCCESS: " + response.paymentId!,);
    SavePaymentServices.savePaymentInfo(
      bookingID: widget.saveBookingInfoModel!.data!.id,
      orderID: widget.saveBookingInfoModel!.data!.orderId,
      amount: widget.saveBookingInfoModel!.data!.amount,
      payment_status: 1,
      rz_py_id: response.paymentId,
      rz_od_id: response.orderId.toString(),
      rz_signature: response.signature.toString()
    );
    SaveNotificationServices.saveNotificationInfo(
      bookingID: widget.saveBookingInfoModel!.data!.id,
      orderID: widget.saveBookingInfoModel!.data!.orderId,
      comment: "Your booking is confirmed",
      status: 1,
    );
    Helper.toRemoveUntiScreen(context, PaymentSuccessScreen());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
    showToast( "Payment canceled, Please try again.");
    print("ERROR: " + response.code.toString() + " - " + response.message!);
    SaveNotificationServices.saveNotificationInfo2(
      comment: "Your booking is failed",
      status: 1,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
    showToast( "EXTERNAL_WALLET: " + response.walletName!,);
  }

   @override
  Widget build(BuildContext context) {

    // print("bookind id ${UserModel().token}");
     print("bookind id ${widget.saveBookingInfoModel!.data!.id}");
      print("orderID id ${widget.saveBookingInfoModel!.data!.orderId}");
  //   print(widget.saveBookingInfoModel!.data!.status);
   //  print("Order id is${widget.saveBookingInfoModel!.data!.id}");

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
            title: "Booking Details",
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: darkBlueColor,
          ),
        ),
        body: FutureBuilder(
          future: GetBookingInfoServices.getBookingInfo(bookingId: widget.saveBookingInfoModel!.data!.id),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              GetBookingInfoModel? getBookingInfoModel = snapshot.data as GetBookingInfoModel?;
              var getDate =  getBookingInfoModel!.data!.bookingDateTime ;
              var newDate;
              if(getDate!=null) {
                print("data $getDate");
                DateTime pickUpTime = DateTime.parse("$getDate");
                 newDate = DateFormat('dd-MM-yyyy').format(pickUpTime);
              }
             // print(getBookingInfoModel!.data);
              return Column(
                children: [
                  //Space
                  SizedBox(height: 15,),
                  //
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: CustomCachedNetworkImage(url: getBookingInfoModel.data!.stadiumAvatar,),
                        ),
                        //Space
                        SizedBox(width: 12,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                title: getBookingInfoModel.data!.courtName,
                                fontSize: 18,
                                color: blueColor,
                              ),
                              //Space
                              SizedBox(height: 4,),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: CustomText(
                                  title: getBookingInfoModel.data!.stadiumAddress,
                                  fontSize: 13,
                                  color: greyColor,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  //Space
                  SizedBox(height: 15,),
                  Divider(height: 4,
                    thickness: 4,
                    color: lightblueColor,
                    indent: 18,
                    endIndent: 18,),
                  //Space
                  SizedBox(height: 15,),
                  //Name
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          title: "Name",
                          fontSize: 14,
                          color: greyColor,
                        ),
                        CustomText(
                          title: getBookingInfoModel.data!.userName,
                          fontSize: 14,
                          color: darkBlueColor,
                        ),
                      ],
                    ),
                  ),
                  //Mobile Number
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          title: "Mobile Number",
                          fontSize: 14,
                          color: greyColor,
                        ),
                        CustomText(
                          title:"",
                          fontSize: 14,
                          color: darkBlueColor,
                        ),
                      ],
                    ),
                  ),
                  //Date
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          title: "Date",
                          fontSize: 14,
                          color: greyColor,
                        ),
                        CustomText(
                          title: "${newDate??""}",
                          fontSize: 14,
                          color: darkBlueColor,
                        ),
                      ],
                    ),
                  ),
                  //Time
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          title: "Time",
                          fontSize: 14,
                          color: greyColor,
                        ),
                        CustomText(
                          title:getBookingInfoModel.data!.timing==null?"": getBookingInfoModel.data!.timing!.startTime,
                          fontSize: 14,
                          color: darkBlueColor,
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 2,
                    thickness: 2,
                    color: lightblueColor,
                    indent: 18,
                    endIndent: 18,),
                  //Total payable amount
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          title: "Total payable amount",
                          fontSize: 14,
                          color: greyColor,
                        ),
                        CustomText(
                          title: "₹ ${getBookingInfoModel.data!.amount??""}",
                          fontSize: 14,
                          color: darkBlueColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 2,
                    thickness: 2,
                    color: lightblueColor,
                    indent: 18,
                    endIndent: 18,),

                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                    child: CustomButton(
                      onPressed: () {
                        openCheckout();
                        //  Helper.toScreen(context, PickingScreen());
                      },
                      btnHeight: 48,
                      btnRadius: 8,
                      title: "Pay Now",
                      fontWeight: FontWeight.w600,
                      btnColor: kPrimaryColor,
                      textColor: whiteColor,
                      fontSize: 18,
                    ),
                  ),
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
    );
  }
  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

}
