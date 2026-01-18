import 'dart:ui';

import 'package:VIN/screens/payment/payment_success_screen.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:VIN/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
class PaymentScreen extends StatelessWidget {
   PaymentScreen({Key? key}) : super(key: key);
   final cardNumbController = TextEditingController();
   final cardNameController = TextEditingController();
   final expiryController = TextEditingController();
   final cvvController = TextEditingController();
   final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomParentWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                          title: "Payment",
                          fontSize: 18,
                          color: darkBlueColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Saved Card
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                alignment: Alignment.centerLeft,
                child: CustomText(
                  title: "Saved Card",
                  fontSize: 16,
                  color: darkBlueColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              //Space
              SizedBox(height: 10,),
              //
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/visa_card.png")
                          )
                      ),
                    ),
                    //Space
                    SizedBox(width: 12,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            title: "Visa Card",
                            fontSize: 15,
                            color: darkBlueColor,
                          ),
                          //Space
                          SizedBox(height: 4,),
                          CustomText(
                            title: "**** 2369 ",
                            fontSize: 14,
                            color: darkBlueColor,
                          ),
                        ],
                      ),
                    ),
                    Image.asset("assets/icons/ic_forward.png")
                  ],
                ),
              ),
              //Space
              SizedBox(height: 15,),
              Divider(height: 2,thickness: 2,color: lightblueColor,indent: 18,endIndent: 18,),
              //Space
              SizedBox(height: 15,),
              //Add new card
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                alignment: Alignment.centerLeft,
                child: CustomText(
                  title: "Add new card",
                  fontSize: 16,
                  color: darkBlueColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              //Space
              SizedBox(height: 15,),
              //Card Number
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: "Card Number",
                      fontSize: 16,
                      color: darkBlueColor,
                    ),
                    //Space
                    SizedBox(height: 5,),
                    CustomTextField(
                      controller: cardNumbController,
                      keyboardType: TextInputType.number,
                      onChanged: (val) {},
                      fieldborderRadius: 10,
                      textFieldFillColor: lightblueColor,
                      fieldborderColor: blueColor,
                    ),
                  ],
                ),
              ),
              //Space
              const SizedBox(height: 15,),
              //Name on Card
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: "Name on Card",
                      fontSize: 16,
                      color: darkBlueColor,
                    ),
                    //Space
                    SizedBox(height: 5,),
                    CustomTextField(
                      controller: cardNameController,
                      keyboardType: TextInputType.text,
                      onChanged: (val) {},
                      fieldborderRadius: 10,
                      textFieldFillColor: lightblueColor,
                      fieldborderColor: blueColor,
                    ),
                  ],
                ),
              ),
              //Space
              const SizedBox(height: 15,),
              //MM/YYYY,CVV
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: "MM/YYYY",
                            fontSize: 16,
                            color: darkBlueColor,
                          ),
                          //Space
                          SizedBox(height: 5,),
                          CustomTextField(
                            controller: expiryController,
                            keyboardType: TextInputType.datetime,
                            onChanged: (val) {},
                            fieldborderRadius: 10,
                            textFieldFillColor: lightblueColor,
                            fieldborderColor: blueColor,
                          ),
                        ],
                      ),
                    ),
                    //Space
                    const SizedBox(width: 15,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: "CVV",
                            fontSize: 16,
                            color: darkBlueColor,
                          ),
                          //Space
                          SizedBox(height: 5,),
                          CustomTextField(
                            controller: cvvController,
                            keyboardType: TextInputType.number,
                            onChanged: (val) {},
                            fieldborderRadius: 10,
                            textFieldFillColor: lightblueColor,
                            fieldborderColor: blueColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18,vertical: 20),
            child: CustomButton(
              onPressed: () {
                  Helper.toScreen(context, PaymentSuccessScreen());
              },
              btnHeight: 48,
              btnRadius: 8,
              title: "Pay now",
              fontWeight: FontWeight.w600,
              btnColor: kPrimaryColor,
              textColor: whiteColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
