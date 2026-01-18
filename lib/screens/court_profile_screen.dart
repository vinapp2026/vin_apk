
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/utilites/helper.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../models/custom_model.dart';
import 'booking/booking_main_screen.dart';
class CourtProfileScreen extends StatelessWidget {
   CourtProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomParentWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //
              Container(
                width: double.infinity,
                height: 300,
                decoration: const BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/stadium_img2.png")
                  )
                ),
                padding: EdgeInsets.symmetric(horizontal: 18,vertical: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          color: blackColor,
                          shape: BoxShape.circle
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/icons/ic_back.png"),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: mediumBlueColor
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        title: "230 m.",
                        fontSize: 9,
                        color: blueColor,
                      ),
                    ),
                  ],
                ),
              ),

              Transform.translate(
                offset: Offset(0.0,-30),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "Indoor Stadium",
                              fontSize: 18,
                              color: blackColor,
                              fontWeight: FontWeight.w700,
                            ),
                            CustomInkWell(
                              onTap: (){},
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: lightblueColor.withOpacity(0.7)
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/icons/ic_heart.png"),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4,right: 8),
                              child: Image.asset("assets/icons/ic_map_pin.png"),
                            ),
                            Expanded(
                              child: CustomText(
                                title: "M78Q+VW6, Mandi Gobindgarh,Punjab 147301",
                                fontSize: 13,
                                color: darkBlueColor,
                              ),
                            ),
                            //Space
                            SizedBox(width: 15,),
                            CustomText(
                              title: "Open in maps",
                              fontSize: 13,
                              color: blueColor,
                            ),
                          ],
                        ),
                      ),
                      //Space
                      SizedBox(height: 20,),
                      //Technical
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Image.asset("assets/icons/ic_traced2.png", color: darkBlueColor,scale: 1.3,),
                            ),
                            Expanded(
                              child: CustomText(
                                title: "Technical",
                                fontSize: 13,
                                color: darkBlueColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                     //Space
                      SizedBox(height: 20,),
                      //Reviews
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomInkWell(
                              onTap: () {
                              },
                              child: Container(
                                width: 140,
                                height: 44,
                                decoration: BoxDecoration(
                                    color: lightblueColor,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Stack(
                                  children: [
                                    Positioned.directional(
                                        textDirection: Directionality.of(context),
                                        start: 35,
                                        top: 0,
                                        bottom: 0,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: CustomText(
                                              title: "4.9 Reviews",
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: kPrimaryColor
                                          ),
                                        )),
                                    Positioned.directional(
                                        textDirection: Directionality.of(context),
                                        start: 0,
                                        top: 0,
                                        bottom: 0,
                                        child: Image.asset("assets/icons/ic_star.png",scale: 1,))
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                CustomText(
                                  title: "₹150",
                                  fontSize: 14,
                                  color: darkBlueColor,
                                ),
                                CustomText(
                                  title: "/hour",
                                  fontSize: 14,
                                  color: greyColor,
                                ),
                              ],
                            )
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
                            Expanded(
                              child: CustomText(
                                title: "Lorem ipsum dolor sit amet, consectetur adipiscing "
                                "elit. Ac malesuada quis vel at morbi. Ac malesuada "
                                "quis vel at morbi.",
                                fontSize: 13,
                                color: darkBlueColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Space
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                         // spacing: 2,
                          runSpacing: 20,
                          runAlignment: WrapAlignment.start,
                          children: List.generate(courtProfileScreenList.length, (index){
                            return Container(
                              width: MediaQuery.of(context).size.width*0.4+18,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 41,
                                    height: 41,
                                    decoration: BoxDecoration(
                                        color: lightblueColor.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(4)
                                    ),
                                    child: Image.asset(courtProfileScreenList[index].img!),
                                  ),
                                  //Space
                                  SizedBox(width: 10,),
                                  //
                                  CustomText(
                                    title: courtProfileScreenList[index].title,
                                    fontSize: 13,
                                    color: darkBlueColor,
                                  )
                                ],
                              ),
                            );
                          })
                        )
                      ),
                      //Space
                      SizedBox(height: 50,),
                      //
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: CustomButton(
                          onPressed: () {
                            Helper.toScreen(context, BookingMainScreen());
                          },
                          btnHeight: 48,
                          btnRadius: 8,
                          title: "Book now",
                          fontWeight: FontWeight.w600,
                          btnColor: kPrimaryColor,
                          textColor: whiteColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
