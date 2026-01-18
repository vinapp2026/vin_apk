import 'dart:ui';

import 'package:VIN/screens/homePage/home_page.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomParentWidget(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset("assets/images/ic_court.png",scale: 1,)),
            //Space
            SizedBox(height: 30,),
            //
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              child: CustomText(
                title: "Court Booking Succesfull",
                fontSize: 20,
                color: darkBlueColor,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18,vertical: 20),
            child: CustomButton(
              onPressed: () {
                Helper.toRemoveUntiScreen(context, HomePage(index: 1,));
              },
              btnHeight: 48,
              btnRadius: 8,
              title: "Go Back",
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
