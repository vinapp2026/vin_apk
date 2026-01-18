import 'dart:ui';

import 'package:VIN/provider/main_provider.dart';
import 'package:VIN/provider/my_calender_provider.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../court_profile_screen2.dart';
import 'cancel_screen.dart';
import 'past_list.dart';
import 'upcoming_list.dart';
class CalenderScreen extends StatelessWidget {
   CalenderScreen({Key? key}) : super(key: key);

   bool isPast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        title:  CustomText(
          title: "My Calender",
          fontSize: 18,
          color: darkBlueColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Column(
        children: [
          //Buttons
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      Provider.of<MyCalenderProvider>(context,
                          listen: false).myCalendertoggle(0);
                    },
                    btnHeight: 48,
                    btnRadius: 8,
                    title: "Upcoming",
                    fontWeight: FontWeight.w600,
                    btnColor:Provider.of<MyCalenderProvider>(context)
                        .tabIndex ==
                        0? kPrimaryColor:lightblueColor,
                    textColor:Provider.of<MyCalenderProvider>(context)
                        .tabIndex ==
                        0?  whiteColor:darkBlueColor,
                    fontSize: 14,
                  ),
                ),
                //Space
                SizedBox(width: 20,),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      Provider.of<MyCalenderProvider>(context,
                          listen: false).myCalendertoggle(1);
                    },
                    btnHeight: 48,
                    btnRadius: 8,
                    title: "Past",
                    fontWeight: FontWeight.w600,
                    btnColor: Provider.of<MyCalenderProvider>(context)
                        .tabIndex ==
                        1?kPrimaryColor: lightblueColor,
                    textColor:Provider.of<MyCalenderProvider>(context)
                        .tabIndex ==
                        1?   whiteColor:darkBlueColor,
                    fontSize: 14,
                  ),
                ),
                //Space
                SizedBox(width: 20,),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      Provider.of<MyCalenderProvider>(context,
                          listen: false).myCalendertoggle(2);
                    },
                    btnHeight: 48,
                    btnRadius: 8,
                    title: "Cancel",
                    fontWeight: FontWeight.w600,
                    btnColor: Provider.of<MyCalenderProvider>(context)
                        .tabIndex ==
                        2? kPrimaryColor:lightblueColor,
                    textColor:Provider.of<MyCalenderProvider>(context)
                        .tabIndex ==
                        2?   whiteColor:darkBlueColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          //Space
          SizedBox(height: 20,),
          Provider.of<MyCalenderProvider>(context)
              .tabIndex ==
              0?  UpcomingList():Provider.of<MyCalenderProvider>(context)
              .tabIndex ==
              1?PastList():CancelScreen(),
        ],
      ),
    );
  }
}
