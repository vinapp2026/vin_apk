import 'package:VIN/models/custom_model.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:VIN/widgets/custom_button.dart';
import 'package:VIN/widgets/custom_inkwell_btn.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/material.dart';
class CourtProfileScreen2 extends StatelessWidget {
   CourtProfileScreen2({Key? key}) : super(key: key);

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
                    image: DecorationImage(
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
                      onTap: (){
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
                                child: Image.asset("assets/icons/ic_heart.png",color: blueColor,),
                              ),
                            ),
                          ],
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
                      //
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Image.asset("assets/icons/ic_calendar2.png",scale: 1.4,),
                                Positioned.directional(
                                    textDirection: Directionality.of(context),
                                    start: 8,
                                    bottom: -2,
                                    child: Image.asset("assets/icons/ic_clock.png",scale: 1.5,))
                              ],
                            ),
                            //Space
                            SizedBox(width: 8,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title: "15 April 2021,    05:30pm",
                                    fontSize: 13,
                                    color: darkBlueColor,
                                    maxLines: 1,
                                  ),
                                  CustomText(
                                    title: "Thursday",
                                    fontSize: 10,
                                    color: darkBlueColor,
                                    maxLines: 1,
                                  ),
                                ],
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
                            Image.asset("assets/icons/ic_users.png",scale: 1.4,),
                            //Space
                            SizedBox(width: 8,),
                            Expanded(
                              child: CustomText(
                                title: "2 Players",
                                fontSize: 13,
                                color: darkBlueColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Space
                      SizedBox(height: 15,),
                      Divider(height: 2,thickness: 2,color: lightblueColor,indent: 18,endIndent: 18,),
                      //Space
                      SizedBox(height: 15,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              title: "Total amount paid",
                              fontSize: 16,
                              color: greyColor,
                            ),
                            CustomText(
                              title: "₹330.00",
                              fontSize: 16,
                              color: blueColor,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
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
               // Helper.toScreen(context, PaymentSuccessScreen());
              },
              btnHeight: 48,
              btnRadius: 8,
              title: "Book Again",
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
